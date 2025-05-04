import 'package:flutter/material.dart';


class FinanceSummaryCards extends StatelessWidget {
  final double totalIncome;
  final double totalExpense;

  const FinanceSummaryCards({
    super.key,
    required this.totalIncome,
    required this.totalExpense,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: _buildCard(
          isIncome: true,
          title: 'Total Icome',
          amount: totalIncome,
          color: const Color(0xFF8A4FFF), // light purple
        )),
        const SizedBox(width: 12),
        Expanded(
            child: _buildCard(
          isIncome: false,
          title: 'Total Expense',
          amount: totalExpense,
          color: const Color(0xFF5D3FD3), // dark purple
        )),
      ],
    );
  }

  Widget _buildCard({
    required bool isIncome,
    required String title,
    required double amount,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                color: Colors.white,
              ),
              const Spacer(),
              const Icon(Icons.more_vert, color: Colors.white),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 4),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "Bank Account",
            style: TextStyle(color: Colors.white60, fontSize: 12),
          ),
          const Text(
            "**** **** **** 1234",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
