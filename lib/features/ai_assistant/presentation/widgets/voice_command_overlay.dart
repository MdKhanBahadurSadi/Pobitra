import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../browser_core/presentation/bloc/tab_cubit.dart';
import '../../../reader_mode/presentation/bloc/reader_mode_cubit.dart';
import '../../../browser_core/presentation/widgets/browser_webview_viewport.dart';
import '../../../core/utils/reader_scraper.dart';
import '../../../reader_mode/data/models/reader_content.dart';
import 'dart:convert';

class VoiceCommandOverlay extends StatefulWidget {
  const VoiceCommandOverlay({super.key});

  @override
  State<VoiceCommandOverlay> createState() => _VoiceCommandOverlayState();
}

class _VoiceCommandOverlayState extends State<VoiceCommandOverlay> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Listening...';
  double _confidence = 1.0;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _startListening();
  }

  void _startListening() async {
    bool available = await _speech.initialize(
      onStatus: (val) {
        if (val == 'done' || val == 'notListening') {
          setState(() => _isListening = false);
        }
      },
      onError: (val) => print('onError: $val'),
    );
    if (available) {
      setState(() => _isListening = true);
      _speech.listen(
        onResult: (val) => setState(() {
          _text = val.recognizedWords;
          if (val.hasConfidenceRating && val.confidence > 0) {
            _confidence = val.confidence;
          }
          if (val.finalResult) {
            _processVoiceCommand(_text);
          }
        }),
      );
    }
  }

  void _processVoiceCommand(String command) async {
    final cmd = command.toLowerCase();
    
    // Intent: Open Website
    if (cmd.contains('open') || cmd.contains('এ যাও')) {
      final domain = _extractDomain(cmd);
      if (domain != null) {
        context.read<TabCubit>().addNewTab('https://$domain');
        Navigator.pop(context);
        return;
      }
    }

    // Intent: Summarize
    if (cmd.contains('summarize') || cmd.contains('সারসংক্ষেপ')) {
      _triggerSummarization();
      Navigator.pop(context);
      return;
    }

    // Intent: Bookmarks/History
    if (cmd.contains('bookmark') || cmd.contains('বুকমার্ক')) {
      // Navigate to bookmarks
      Navigator.pop(context);
      return;
    }

    // Intent: Close Tab
    if (cmd.contains('close tab') || cmd.contains('ট্যাব বন্ধ করো')) {
      final activeTab = context.read<TabCubit>().state.activeTab;
      if (activeTab != null) {
        context.read<TabCubit>().closeTab(activeTab.id);
      }
      Navigator.pop(context);
      return;
    }

    // Default: Search
    context.read<TabCubit>().addNewTab('https://www.google.com/search?q=\${Uri.encodeComponent(command)}');
    Navigator.pop(context);
  }

  String? _extractDomain(String cmd) {
    final parts = cmd.split(' ');
    for (var i = 0; i < parts.length; i++) {
      if ((parts[i] == 'open' || parts[i] == 'visit') && i + 1 < parts.length) {
        return parts[i + 1].contains('.') ? parts[i + 1] : '\${parts[i + 1]}.com';
      }
    }
    // Simple Bengali match
    if (cmd.contains(' এ যাও')) {
      final site = cmd.split(' ')[0];
      return site.contains('.') ? site : '\$site.com';
    }
    return null;
  }

  void _triggerSummarization() async {
    final controller = BrowserWebViewViewport.activeController;
    if (controller != null) {
      final result = await controller.evaluateJavascript(source: ReaderScraper.extractScript);
      if (result != null && mounted) {
        final content = ReaderContent.fromJson(jsonDecode(result));
        context.read<ReaderModeCubit>().enterReaderMode(content);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _isListening ? 'Listening...' : 'Processing...',
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          Text(
            _text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _isListening ? Icons.mic : Icons.mic_none,
              size: 48,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
