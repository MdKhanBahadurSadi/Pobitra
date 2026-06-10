import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pobitra_browser/features/ai_assistant/presentation/bloc/ai_assistant_cubit.dart';

class AiAssistantPanel extends StatefulWidget {
  final String pageContent;

  const AiAssistantPanel({super.key, required this.pageContent});

  @override
  State<AiAssistantPanel> createState() => _AiAssistantPanelState();
}

class _AiAssistantPanelState extends State<AiAssistantPanel> {
  final TextEditingController _questionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Automatically summarize when panel opens if not already done
    final cubit = context.read<AiAssistantCubit>();
    if (cubit.state.summary == null) {
      cubit.summarizePage(widget.pageContent);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'AI Assistant',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const Divider(),
          Expanded(
            child: BlocBuilder<AiAssistantCubit, AiAssistantState>(
              builder: (context, state) {
                return ListView(
                  children: [
                    if (state.summary != null) ...[
                      const Text(
                        'Summary (Bengali):',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                      const SizedBox(height: 8),
                      Text(state.summary!),
                      const Divider(height: 32),
                    ],
                    ...state.chatHistory.map((content) {
                      final isUser = content.role == 'user';
                      final text = content.textContent;
                      return Align(
                        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isUser
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            text,
                            style: TextStyle(
                              color: isUser ? Colors.white : null,
                            ),
                          ),
                        ),
                      );
                    }),
                    if (state.status == AiAssistantStatus.loading)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _questionController,
                  decoration: const InputDecoration(
                    hintText: 'Ask a question about this page...',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (val) => _handleSend(),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: _handleSend,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleSend() {
    if (_questionController.text.trim().isNotEmpty) {
      context.read<AiAssistantCubit>().askQuestion(_questionController.text.trim());
      _questionController.clear();
    }
  }

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }
}
