import 'package:expensetracker/constants/sizes.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../utils/expense_utils.dart';

class ExpensePieChart extends StatelessWidget {
  final List<Expense> expenses;

  const ExpensePieChart({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    if (expenses.isEmpty) return const Text("No data");

    final categoryTotals = groupExpensesByCategory(expenses);
    final total = categoryTotals.values.fold(0.0, (a, b) => a + b);

    final sections = categoryTotals.entries.map((entry) {
      final index = categoryTotals.keys.toList().indexOf(entry.key);
      final color = Colors.primaries[index % Colors.primaries.length];
      final percent = (entry.value / total) * 100;

      return PieChartSectionData(
        title: "${percent.toStringAsFixed(0)}%",
        value: entry.value,
        color: color,
        radius: 70,
        titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      );
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Analytics", style: TextStyle(fontWeight: FontWeight.bold, fontSize: AppSizes.secondaryFontSize)),
              const Text("See All", style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        SizedBox(
          height: 250,
          child: PieChart(
            PieChartData(
              sections: sections,
              centerSpaceRadius: 40,
              sectionsSpace: 2,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: categoryTotals.entries.map((entry) {
              final index = categoryTotals.keys.toList().indexOf(entry.key);
              final color = Colors.primaries[index % Colors.primaries.length];

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(entry.key, style: TextStyle(color: color, fontWeight: FontWeight.w500)),
                    Text("\$${entry.value.toStringAsFixed(0)}", style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
