import 'package:expensetracker/constants/sizes.dart';
import 'package:flutter/material.dart';

class PercentageCard extends StatelessWidget {
  final bool isIncome;
  final double percentage;

  const PercentageCard({
    super.key,
    required this.isIncome,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    final Color iconColor = isIncome ? Colors.green : Colors.red;
    final Color bgColor = isIncome ? Colors.green.shade50 : Colors.red.shade50;
    final IconData icon = isIncome ? Icons.arrow_upward : Icons.arrow_downward;
    final String label = isIncome ? "Income" : "Expenses";
    final String percentText =
        "${isIncome ? '+' : '-'}${percentage.toStringAsFixed(0)}%";

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: AppSizes.smallGap, vertical: AppSizes.smallGap),
      margin: EdgeInsets.all(AppSizes.smallGap * .5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppSizes.smallGap),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: AppSizes.smallIconSize),
          SizedBox(width: AppSizes.smallGap),
          Text(
            '$percentText $label',
            style: TextStyle(
              color: iconColor,
              fontWeight: FontWeight.bold,
              fontSize: AppSizes.tertiaryFontSize,
            ),
          ),
        ],
      ),
    );
  }
}
