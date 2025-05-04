import 'package:expensetracker/utils/date_formatter.dart';
import 'package:expensetracker/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/api_service.dart';

class AddTransactionScreen extends StatefulWidget {
  final String type; // 'income' or 'expense'

  const AddTransactionScreen({super.key, required this.type});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final String _userId = "660f8cf5c92e4b1211fcfd84";

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String _selectedCategory = 'Grocery';
  DateTime _selectedDate = DateTime.now();

  final List<String> categories = [
    'Grocery',
    'Entertainment',
    'Health',
    'Transport',
    'Food',
    'Bills',
    'Salary',
    'Other'
  ];

  Future<void> _submit() async {
  if (_formKey.currentState!.validate()) {
    final amount = double.tryParse(_amountController.text) ?? 0.0;

    final payload = {
      "amount": amount,
      widget.type == 'expense' ? "category" : "source": _selectedCategory,
      "description": _descriptionController.text,
      "date": _selectedDate.toIso8601String(),
      "user_id": _userId
    };

    try {
      if (widget.type == 'expense') {
        await ApiService.addExpense(payload);
      } else {
        await ApiService.addIncome(payload);
      }

      // ✅ Show success snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${widget.type.capitalize()} added successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context); // Return to previous screen
    } catch (e) {
      // ❌ Show error snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add ${widget.type}: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    final title = widget.type == 'expense' ? 'Add Expense' : 'Add Income';

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter amount' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: _selectedCategory,
                decoration: const InputDecoration(labelText: 'Category'),
                onChanged: (value) => _selectedCategory = value,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Enter a category' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text("Date: ${DateFormat.yMMMd().format(_selectedDate)}"),
                  const Spacer(),
                  TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {
                        setState(() => _selectedDate = picked);
                      }
                    },
                    child: const Text("Change"),
                  )
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text('Add ${widget.type}'),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const MyNavBar(
        index: 3,
      ),
    );
  }
}
