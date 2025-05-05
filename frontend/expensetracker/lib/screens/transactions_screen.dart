import 'package:expensetracker/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/sizes.dart';
import '../models/expense.dart';
import '../services/api_service.dart';
import '../services/expense_service.dart';
import '../widgets/calendar.dart';
import '../widgets/category_spending_card.dart';
import '../widgets/finance_summary_cards.dart';
import 'edit_transaction_screen.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  double totalIncome = 0;
  double totalExpense = 0;
  double balance = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadFinancialData();
  }

  Future<void> loadFinancialData() async {
    try {
      final incomes = await ApiService.fetchIncomes("660f8cf5c92e4b1211fcfd84");
      final expenses =
          await ApiService.fetchExpenses("660f8cf5c92e4b1211fcfd84");

      totalIncome = incomes.fold(0, (sum, item) => sum + item.amount);
      totalExpense = expenses.fold(0, (sum, item) => sum + item.amount);

      setState(() {
        balance = totalIncome - totalExpense;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading financial data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: AppSizes.largeGap * 1.5, // increase the AppBar height
        flexibleSpace: Padding(
          padding: EdgeInsets.only(top: AppSizes.largeGap * .65, left: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'images/logo.png',
                width: AppSizes.largeGap * 4.5,
                height: AppSizes.largeGap * 6.5,
              ),
              //const Spacer(),
              SizedBox(
                width: AppSizes.largeGap * 4.95,
              ),
              const CircleAvatar(
                backgroundColor: AppColors.primaryIconColor,
                child: Icon(Icons.person, color: Colors.white),
              ),
              SizedBox(width: AppSizes.largeGap),
            ],
          ),
        ),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
          child: RefreshIndicator(
        onRefresh: loadFinancialData, // 🔁 Triggers on swipe-down
        color: AppColors.primaryIconColor, // Progress spinner color
        backgroundColor: AppColors.cardBackgroundColor,
        child: SingleChildScrollView(
          physics:
              const AlwaysScrollableScrollPhysics(), // ✅ Required for pull even when list is short
          child: Padding(
            padding:
                EdgeInsets.fromLTRB(AppSizes.smallGap, 0, AppSizes.smallGap, 0),
            child: Column(
              children: [
                const HorizontalDatePicker(),
                SizedBox(
                  height: AppSizes.smallGap,
                ),
                FinanceSummaryCards(
                  totalIncome: totalIncome,
                  totalExpense: totalExpense,
                ),
                SizedBox(
                  height: AppSizes.smallGap,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, AppSizes.largeGap * 8, 0),
                  child: Text("Expenses",
                      style: TextStyle(
                          fontSize: AppSizes.secondaryFontSize,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText)),
                ),
                FutureBuilder<List<Expense>>(
                  future: fetchExpensesByUser("660f8cf5c92e4b1211fcfd84"),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    }

                    final expenses = snapshot.data!;

                    // ✅ Sort expenses by date (descending)
                    expenses.sort((a, b) => DateTime.parse(b.date)
                        .compareTo(DateTime.parse(a.date)));

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: expenses.length,
                      itemBuilder: (context, index) {
                        final expense = expenses[index];

                        return Dismissible(
                          key: Key(expense.id),
                          background: Container(
                            color: Colors.green,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: const Icon(Icons.edit, color: Colors.white),
                          ),
                          secondaryBackground: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child:
                                const Icon(Icons.delete, color: Colors.white),
                          ),
                          confirmDismiss: (direction) async {
                            if (direction == DismissDirection.endToStart) {
                              await ApiService.deleteExpense(expense.id);
                              setState(() => expenses.removeAt(index));
                              return true;
                            } else if (direction ==
                                DismissDirection.startToEnd) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditTransactionScreen(expense: expense),
                                ),
                              ).then((updated) {
                                if (updated == true) {
                                  setState(() {}); // Refresh the list
                                }
                              });

                              return false;
                            }
                            return false;
                          },
                          child: CategorySpendingCard(
                            category: expense.category,
                            paymentMethod: "Credit Card",
                            date: DateTime.tryParse(expense.date) ??
                                DateTime.now(),
                            totalSpent: expense.amount,
                            totalBudget: 3000,
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      )),
      bottomNavigationBar: const MyNavBar(index: 1),
    );
  }
}
