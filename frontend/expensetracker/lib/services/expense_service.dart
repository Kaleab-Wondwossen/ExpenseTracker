import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/expense.dart';

Future<List<Expense>> fetchExpensesByUser(String userId) async {
  final uri = Uri.parse("https://expensetracker-8s9l.onrender.com/api/expenses?user_id=$userId");

  final response = await http.get(uri);

  if (response.statusCode == 200) {
    final List data = jsonDecode(response.body);
    return data.map((e) => Expense.fromJson(e)).toList();
  } else {
    print("🔴 ERROR: ${response.statusCode} - ${response.body}");
    throw Exception("Failed to load expenses");
  }
}
