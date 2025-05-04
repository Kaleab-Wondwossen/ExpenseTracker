class Income {
  final String id;
  final String userId;
  final double amount;
  final String source;
  final String description;
  final String date;

  Income({
    required this.id,
    required this.userId,
    required this.amount,
    required this.source,
    required this.description,
    required this.date,
  });

  factory Income.fromJson(Map<String, dynamic> json) {
    return Income(
      id: json['_id'],
      userId: json['user_id'],
      amount: json['amount'].toDouble(),
      source: json['source'],
      description: json['description'],
      date: json['date'],
    );
  }
}
