class Expense {
  final String id;
  final String userId;
  final double amount;
  final String category;
  final String description;
  final String date;

  Expense({
    required this.id,
    required this.userId,
    required this.amount,
    required this.category,
    required this.description,
    required this.date,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['_id'],
      userId: json['user_id'],
      amount: json['amount'].toDouble(),
      category: json['category'],
      description: json['description'],
      date: json['date'],
    );
  }
}
