import 'package:expensetracker/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthlySpendCard extends StatelessWidget {
  final double percentSpent; // e.g. 0.8654
  final double totalSpent;
  final DateTime monthDate;

  const MonthlySpendCard({
    super.key,
    required this.percentSpent,
    required this.totalSpent,
    required this.monthDate,
  });

  @override
  Widget build(BuildContext context) {
    final monthLabel = DateFormat.yMMM().format(monthDate); // Jan, 2022
    final leftPercent = (percentSpent * 100).toStringAsFixed(2);
    final rightPercent = (100 - (percentSpent * 100)).toStringAsFixed(2);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.mediumGap),
      margin: const EdgeInsets.symmetric(horizontal: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Your spend this", style: TextStyle(fontWeight: FontWeight.w500)),
              Text(monthLabel, style: const TextStyle(color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            "Month is \$${totalSpent.toStringAsFixed(0)} ",
            style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Stack(
            children: [
              Container(
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              FractionallySizedBox(
                widthFactor: percentSpent.clamp(0.0, 1.0),
                child: Container(
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("$leftPercent%", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      Text("$rightPercent%", style: const TextStyle(color: Colors.black54)),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
