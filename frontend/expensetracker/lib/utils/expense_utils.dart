import '../models/expense.dart';

Map<String, double> groupExpensesByCategory(List<Expense> expenses) {
  final Map<String, double> categoryTotals = {};

  for (var expense in expenses) {
    if (categoryTotals.containsKey(expense.category)) {
      categoryTotals[expense.category] = categoryTotals[expense.category]! + expense.amount;
    } else {
      categoryTotals[expense.category] = expense.amount;
    }
  }

  return categoryTotals;
}
