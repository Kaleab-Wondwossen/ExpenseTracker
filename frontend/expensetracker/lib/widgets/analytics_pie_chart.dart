import 'package:expensetracker/constants/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AnalyticsPieChart extends StatelessWidget {
  const AnalyticsPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Expense Breakdown", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(value: 40, title: 'Rent', color: Colors.blue),
                PieChartSectionData(value: 30, title: 'Food', color: AppColors.primaryColor),
                PieChartSectionData(value: 20, title: 'Transport', color: const Color.fromARGB(255, 139, 108, 233)),
                PieChartSectionData(value: 10, title: 'Others', color: AppColors.secondaryColor),
              ],
              sectionsSpace: 4,
              centerSpaceRadius: 40,
            ),
          ),
        ),
      ],
    );
  }
}
