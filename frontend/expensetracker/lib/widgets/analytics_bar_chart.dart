import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AnalyticsBarChart extends StatelessWidget {
  const AnalyticsBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Monthly Overview", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 10000,
              barTouchData: BarTouchData(enabled: true),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: true, interval: 2000),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May'];
                      return Text(months[value.toInt()]);
                    },
                    interval: 1,
                  ),
                ),
              ),
              barGroups: [
                makeGroupData(0, 4000, 2000),
                makeGroupData(1, 5000, 3000),
                makeGroupData(2, 7000, 3500),
                makeGroupData(3, 6500, 4500),
                makeGroupData(4, 8000, 5000),
              ],
            ),
          ),
        ),
      ],
    );
  }

  BarChartGroupData makeGroupData(int x, double income, double expense) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(toY: income, color: Colors.green, width: 8),
        BarChartRodData(toY: expense, color: Colors.red, width: 8),
      ],
    );
  }
}
