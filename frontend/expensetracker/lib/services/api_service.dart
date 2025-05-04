import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/income.dart';
import '../models/expense.dart';

class ApiService {
  static const String baseUrl = 'https://expensetracker-8s9l.onrender.com/api';

  static Future<List<Income>> fetchIncomes(String userId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/incomes?user_id=$userId'));

    if (response.statusCode == 200) {
      final List decoded = json.decode(response.body);
      return decoded.map((item) => Income.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch incomes');
    }
  }

  static Future<List<Expense>> fetchExpenses(String userId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/expenses?user_id=$userId'));

    if (response.statusCode == 200) {
      final List decoded = json.decode(response.body);
      return decoded.map((item) => Expense.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch expenses');
    }
  }

  // ✅ POST: Add Income
  static Future<void> addIncome(Map<String, dynamic> incomeData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/incomes'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(incomeData),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add income: ${response.body}');
    }
  }

  // ✅ POST: Add Expense
  static Future<void> addExpense(Map<String, dynamic> expenseData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/expenses'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(expenseData),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add expense: ${response.body}');
    }
  }
}
