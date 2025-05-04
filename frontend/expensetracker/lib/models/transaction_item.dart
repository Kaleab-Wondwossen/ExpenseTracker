enum TransactionType { income, expense }

class TransactionItem {
  final String id;
  final double amount;
  final String label;
  final String description;
  final DateTime date;
  final TransactionType type;

  TransactionItem({
    required this.id,
    required this.amount,
    required this.label,
    required this.description,
    required this.date,
    required this.type,
  });
}
