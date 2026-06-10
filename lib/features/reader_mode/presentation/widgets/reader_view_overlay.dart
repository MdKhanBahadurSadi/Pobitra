import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/reader_mode_cubit.dart';

class ReaderViewOverlay extends StatefulWidget {
  const ReaderViewOverlay({super.key});

  @override
  State<ReaderViewOverlay> createState() => _ReaderViewOverlayState();
}

class _ReaderViewOverlayState extends State<ReaderViewOverlay> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReaderModeCubit, ReaderModeState>(
      builder: (context, state) {
        if (!state.isEnabled || state.content == null) return const SizedBox.shrink();

        final bgColor = _getBackgroundColor(state.theme);
        final textColor = _getTextColor(state.theme);

        return Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.close, color: textColor),
              onPressed: () => context.read<ReaderModeCubit>().exitReaderMode(),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.text_fields, color: textColor),
                onPressed: () => _showSettings(context),
              ),
              IconButton(
                icon: Icon(state.isPlaying ? Icons.pause : Icons.play_arrow, color: textColor),
                onPressed: () => context.read<ReaderModeCubit>().togglePlayback(),
              ),
            ],
          ),
          body: SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state.content!.coverImage != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 24.0),
                    child: Image.network(state.content!.coverImage!),
                  ),
                Text(
                  state.content!.title,
                  style: TextStyle(
                    fontSize: state.fontSize + 8,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    fontFamily: state.fontFamily == 'Serif' ? 'Georgia' : null,
                  ),
                ),
                if (state.content!.author != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'By ${state.content!.author}',
                      style: TextStyle(
                        fontSize: state.fontSize - 2,
                        color: textColor.withOpacity(0.7),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                const Divider(height: 48),
                Text(
                  state.content!.body,
                  style: TextStyle(
                    fontSize: state.fontSize,
                    color: textColor,
                    height: 1.6,
                    fontFamily: state.fontFamily == 'Serif' ? 'Georgia' : null,
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: state.isPlaying ? _buildPlaybackControls(context, state, textColor) : null,
        );
      },
    );
  }

  Widget _buildPlaybackControls(BuildContext context, ReaderModeState state, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: _getBackgroundColor(state.theme).withOpacity(0.9),
        border: Border(top: BorderSide(color: textColor.withOpacity(0.1))),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Text('${state.playbackSpeed}x', style: TextStyle(color: textColor)),
            Expanded(
              child: Slider(
                value: state.playbackSpeed,
                min: 0.5,
                max: 2.0,
                onChanged: (val) => context.read<ReaderModeCubit>().setPlaybackSpeed(val),
              ),
            ),
            IconButton(
              icon: Icon(Icons.stop, color: textColor),
              onPressed: () => context.read<ReaderModeCubit>().togglePlayback(),
            ),
          ],
        ),
      ),
    );
  }

  void _showSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (bContext) {
        return BlocBuilder<ReaderModeCubit, ReaderModeState>(
          bloc: context.read<ReaderModeCubit>(),
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Font Size', style: TextStyle(fontWeight: FontWeight.bold)),
                  Slider(
                    value: state.fontSize,
                    min: 12,
                    max: 28,
                    onChanged: (val) => context.read<ReaderModeCubit>().setFontSize(val),
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _themeButton(context, ReaderTheme.white, Colors.white, Colors.black),
                      _themeButton(context, ReaderTheme.sepia, const Color(0xFFF4ECD8), Colors.brown),
                      _themeButton(context, ReaderTheme.amoled, Colors.black, Colors.white),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ChoiceChip(
                        label: const Text('Sans-Serif'),
                        selected: state.fontFamily == 'Sans-Serif',
                        onSelected: (_) => context.read<ReaderModeCubit>().setFontFamily('Sans-Serif'),
                      ),
                      ChoiceChip(
                        label: const Text('Serif'),
                        selected: state.fontFamily == 'Serif',
                        onSelected: (_) => context.read<ReaderModeCubit>().setFontFamily('Serif'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _themeButton(BuildContext context, ReaderTheme theme, Color bg, Color text) {
    return GestureDetector(
      onTap: () => context.read<ReaderModeCubit>().setTheme(theme),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: bg,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text('Aa', style: TextStyle(color: text)),
      ),
    );
  }

  Color _getBackgroundColor(ReaderTheme theme) {
    switch (theme) {
      case ReaderTheme.white: return Colors.white;
      case ReaderTheme.sepia: return const Color(0xFFF4ECD8);
      case ReaderTheme.amoled: return Colors.black;
    }
  }

  Color _getTextColor(ReaderTheme theme) {
    switch (theme) {
      case ReaderTheme.white: return Colors.black87;
      case ReaderTheme.sepia: return Colors.brown[900]!;
      case ReaderTheme.amoled: return Colors.white70;
    }
  }
}
