import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/income.dart';
import '../models/expense.dart';

class ApiService {
  static const String baseUrl = 'https://expensetracker-8s9l.onrender.com/api';

  static Future<List<Income>> fetchIncomes(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/incomes?user_id=$userId'));

    if (response.statusCode == 200) {
      final List decoded = json.decode(response.body);
      return decoded.map((item) => Income.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch incomes');
    }
  }

  static Future<List<Expense>> fetchExpenses(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/expenses?user_id=$userId'));

    if (response.statusCode == 200) {
      final List decoded = json.decode(response.body);
      return decoded.map((item) => Expense.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch expenses');
    }
  }
}
