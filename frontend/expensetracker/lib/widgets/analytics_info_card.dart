import 'package:flutter/material.dart';

class AnalyticsInfoCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const AnalyticsInfoCard({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      borderOnForeground: true,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 6),
            Text(value, style: TextStyle(fontSize: 16, color: color)),
          ],
        ),
      ),
    );
  }
}
