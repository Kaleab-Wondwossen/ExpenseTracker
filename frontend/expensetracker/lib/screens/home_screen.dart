import 'package:expensetracker/constants/colors.dart';
import 'package:expensetracker/constants/sizes.dart';
import 'package:expensetracker/widgets/bottom_nav_bar.dart';
import 'package:expensetracker/widgets/card_container.dart';
import 'package:flutter/material.dart';

import '../models/transaction_item.dart';
import '../services/api_service.dart';
import '../widgets/percentage_card.dart';
import '../widgets/transaction_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  Future<List<TransactionItem>> loadTransactions(String userId) async {
    final incomeList = await ApiService.fetchIncomes(userId);
    final expenseList = await ApiService.fetchExpenses(userId);

    List<TransactionItem> all = [
      ...incomeList.map((inc) => TransactionItem(
            id: inc.id,
            amount: inc.amount,
            label: inc.source,
            description: inc.description,
            date: DateTime.parse(inc.date),
            type: TransactionType.income,
          )),
      ...expenseList.map((exp) => TransactionItem(
            id: exp.id,
            amount: exp.amount,
            label: exp.category,
            description: exp.description,
            date: DateTime.parse(exp.date),
            type: TransactionType.expense,
          )),
    ];

    all.sort((a, b) => b.date.compareTo(a.date));
    return all.take(20).toList();
  }

  @override
  Widget build(BuildContext context) {
    AppSizes.init(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: AppSizes.largeGap * 1.5, // increase the AppBar height
        flexibleSpace: Padding(
          padding: EdgeInsets.only(top: AppSizes.largeGap*.65, left: 0),
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
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    // SizedBox(height: AppSizes.smallGap),
                    BalanceFlipCard(
                      balance: balance,
                      saturation: totalIncome == 0
                          ? 0
                          : (totalExpense / totalIncome).clamp(0.0, 1.0),
                      cardHolder: "Kalab Wondwossen",
                      cardNumber: "1234 5678 9012 3456",
                      expiryDate: "08/26",
                    ),
                    SizedBox(height: AppSizes.smallGap),
                    Padding(
                      padding:
                          EdgeInsets.fromLTRB(0, 0, AppSizes.largeGap * 7.5, 0),
                      child: Text("Transactions",
                          style: TextStyle(
                              fontSize: AppSizes.secondaryFontSize,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryText)),
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
                          percentage: (totalExpense == 0
                              ? 0
                              : (totalIncome / totalExpense)),
                        ),
                      ],
                    ),
                    FutureBuilder<List<TransactionItem>>(
                      future: loadTransactions("660f8cf5c92e4b1211fcfd84"),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
                        }

                        final transactions = snapshot.data!;
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: transactions.length,
                          itemBuilder: (context, index) {
                            return TransactionTile(item: transactions[index]);
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
      ),
      bottomNavigationBar: const MyNavBar(index: 0),
    );
  }
}
