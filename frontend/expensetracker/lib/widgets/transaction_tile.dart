import 'package:flutter/material.dart';
import '../models/transaction_item.dart';

class TransactionTile extends StatelessWidget {
  final TransactionItem item;

  const TransactionTile({super.key, required this.item});

  IconData _getIcon() {
    if (item.type == TransactionType.income) {
      switch (item.label.toLowerCase()) {
        case 'salary': return Icons.payments;
        case 'freelance': return Icons.laptop_mac;
        case 'investment': return Icons.trending_up;
        case 'gift': return Icons.card_giftcard;
        case 'interest': return Icons.monetization_on;
        case 'other': return Icons.more_horiz;
        case 'bonus': return Icons.star;
        case 'refund': return Icons.monetization_on;
        case 'commission': return Icons.business_center;
        case 'sale': return Icons.sell;
        case 'reimbursement': return Icons.receipt;
        case 'dividend': return Icons.pie_chart;
        case 'royalty': return Icons.copyright;
        case 'rental': return Icons.home;
        case 'scholarship': return Icons.school;
        case 'allowance': return Icons.monetization_on;
        case 'prize': return Icons.emoji_events;
        case 'lottery': return Icons.casino;
        case 'inheritance': return Icons.family_restroom;
        default: return Icons.arrow_downward;
      }
    } else {
      switch (item.label.toLowerCase()) {
        case 'grocery': return Icons.shopping_cart;
        case 'rent': return Icons.home;
        case 'transport': return Icons.directions_car;
        case 'bills': return Icons.receipt;
        case 'entertainment': return Icons.movie;
        case 'food': return Icons.restaurant;
        case 'shopping': return Icons.shopping_bag;
        case 'health': return Icons.local_hospital;
        case 'travel': return Icons.flight;
        case 'education': return Icons.school;
        case 'insurance': return Icons.shield;
        case 'subscription': return Icons.subscriptions;
        case 'gift': return Icons.card_giftcard;
        case 'charity': return Icons.favorite;
        case 'repair': return Icons.build;
        case 'maintenance': return Icons.build;
        case 'pet': return Icons.pets;
        case 'cloth': return Icons.checkroom;
        case 'furniture': return Icons.chair;
        case 'electronics': return Icons.electrical_services;
        case 'beauty': return Icons.face;
        case 'sports': return Icons.sports;
        case 'hobby': return Icons.brush;
        case 'home': return Icons.home;
        default: return Icons.arrow_upward;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isIncome = item.type == TransactionType.income;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(20, 0, 0, 0),
            blurRadius: 5,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: isIncome ? Colors.green.shade100 : Colors.red.shade100,
            child: Icon(_getIcon(), color: isIncome ? Colors.green : Colors.red),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(item.description, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                const SizedBox(height: 2),
                Text("${item.date.day}/${item.date.month}/${item.date.year}", style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            "${isIncome ? '+' : '-'}\$${item.amount.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 16,
              color: isIncome ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
