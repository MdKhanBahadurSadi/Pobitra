import 'package:flutter/material.dart';

class FactCheckBadge extends StatelessWidget {
  final String result;

  const FactCheckBadge({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final parts = result.split('\n');
    final classification = parts.first.trim();
    final explanation = parts.skip(1).join('\n').trim();

    Color badgeColor;
    IconData icon;

    if (classification.contains('True')) {
      badgeColor = Colors.green;
      icon = Icons.check_circle;
    } else if (classification.contains('False')) {
      badgeColor = Colors.red;
      icon = Icons.cancel;
    } else {
      badgeColor = Colors.amber;
      icon = Icons.warning;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: badgeColor, size: 24),
              const SizedBox(width: 8),
              Text(
                classification,
                style: TextStyle(
                  color: badgeColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          if (explanation.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              explanation,
              style: const TextStyle(fontSize: 14, height: 1.4),
            ),
          ],
        ],
      ),
    );
  }
}
