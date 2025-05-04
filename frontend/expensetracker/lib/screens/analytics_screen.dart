import 'package:expensetracker/widgets/bottom_nav_bar.dart';
import 'package:expensetracker/widgets/calendar.dart';
import 'package:expensetracker/widgets/monthly_spend_card.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/sizes.dart';
import '../models/expense.dart';
import '../services/api_service.dart';
import '../services/expense_service.dart';
import '../widgets/expense_pie_chart.dart';
import '../widgets/percentage_card.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
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
      backgroundColor: AppColors.backgroundColor,
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
      body: SingleChildScrollView(
        padding:
            EdgeInsets.fromLTRB(AppSizes.smallGap, 0, AppSizes.smallGap, 0),
        child: Column(
          children: [
            const HorizontalDatePicker(),
            SizedBox(
              height: AppSizes.smallGap,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PercentageCard(
                  isIncome: true,
                  percentage: (totalIncome == 0
                      ? 0
                      : (totalExpense / totalIncome) * 100),
                ),
                PercentageCard(
                  isIncome: false,
                  percentage:
                      (totalExpense == 0 ? 0 : (totalIncome / totalExpense)),
                ),
              ],
            ),
            SizedBox(height: AppSizes.smallGap),
            // AnalyticsPieChart(),
            MonthlySpendCard(
                percentSpent: (totalExpense / totalIncome),
                totalSpent: totalExpense,
                monthDate: DateTime(2022, 1, 20)),
            SizedBox(height: AppSizes.smallGap),
            FutureBuilder<List<Expense>>(
              future: fetchExpensesByUser(
                  "660f8cf5c92e4b1211fcfd84"), // your API call
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }

                final expenses = snapshot.data!;
                return ExpensePieChart(expenses: expenses);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MyNavBar(index: 2),
    );
  }
}
