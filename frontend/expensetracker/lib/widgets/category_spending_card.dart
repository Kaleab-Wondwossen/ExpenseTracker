import 'package:expensetracker/constants/sizes.dart';
import 'package:flutter/material.dart';

class CategorySpendingCard extends StatelessWidget {
  final String category;
  final String paymentMethod; // e.g. Credit Card
  final DateTime date;
  final double totalSpent;
  final double totalBudget;

  const CategorySpendingCard({
    super.key,
    required this.category,
    required this.paymentMethod,
    required this.date,
    required this.totalSpent,
    required this.totalBudget,
  });

  @override
  Widget build(BuildContext context) {
    final percentUsed = (totalSpent / totalBudget).clamp(0.0, 1.0);
    final formattedDate = "${date.day} ${_monthName(date.month)}, ${date.year}";
    final usedPercentage = (percentUsed * 100).toStringAsFixed(0);

    return Container(
      margin:  EdgeInsets.symmetric(horizontal: AppSizes.smallGap, vertical: AppSizes.smallGap),
      padding:  EdgeInsets.all(AppSizes.smallGap),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                const Icon(Icons.shopping_cart_outlined, color: Colors.deepPurple),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(category, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(paymentMethod, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ]),
              Text(formattedDate, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),

          const SizedBox(height: 16),

          /// Budget Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Total Budget", style: TextStyle(fontSize: 12, color: Colors.grey)),
              const Text("Total Spent", style: TextStyle(fontSize: 12, color: Colors.grey)),
              Text("$usedPercentage%", style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("\$${totalBudget.toStringAsFixed(0)}", style: const TextStyle(fontWeight: FontWeight.bold)),
              Text("\$${totalSpent.toStringAsFixed(0)}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple)),
              const SizedBox(width: 40),
            ],
          ),

          const SizedBox(height: 8),

          /// Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              minHeight: 10,
              value: percentUsed,
              backgroundColor: Colors.grey.shade300,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.deepPurple),
            ),
          ),
        ],
      ),
    );
  }

  String _monthName(int monthNumber) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[monthNumber - 1];
  }
}
