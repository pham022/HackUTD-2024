import 'package:flutter/material.dart';
import '../repositories/data_repository.dart'; // Ensure correct path
import '../models/expense.dart'; // Ensure this model is correct and accessible

// Mock-up model for Expense
class Expense {
  final String description;
  final double amount;
  final DateTime date;
  final String location;

  Expense({required this.description, required this.amount, required this.date, required this.location});
}

class ExpensesScreen extends StatelessWidget {
  // Dummy data for expenses
  final List<Expense> expenses = [
    Expense(description: 'Groceries', amount: 150.00, date: DateTime.now(), location: 'Supermarket'),
    Expense(description: 'Utilities', amount: 120.00, date: DateTime.now(), location: 'Bills'),
    Expense(description: 'Rent', amount: 800.00, date: DateTime.now(), location: 'Housing'),
    Expense(description: 'Subscriptions', amount: 50.00, date: DateTime.now(), location: 'Entertainment'),
    Expense(description: 'Dining Out', amount: 75.00, date: DateTime.now(), location: 'Restaurant'),
    Expense(description: 'Car Payment', amount: 300.00, date: DateTime.now(), location: 'Auto'),
    Expense(description: 'Health Insurance', amount: 400.00, date: DateTime.now(), location: 'Medical'),
  ];

  @override
  Widget build(BuildContext context) {
    // Categorize expenses by types
    Map<String, double> categories = {};
    for (var expense in expenses) {
      categories.update(expense.location, (value) => value + expense.amount, ifAbsent: () => expense.amount);
    }

    // Calculate the total for scaling bars
    double total = categories.values.fold(0.0, (sum, amount) => sum + amount);

    // Determine top 3 expenses by amount
    List<Expense> topExpenses = expenses;
    topExpenses.sort((a, b) => b.amount.compareTo(a.amount));
    topExpenses = topExpenses.take(3).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses'),
      ),
      body: Column(
        children: [
          // Bar graph section
          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                String category = categories.keys.elementAt(index);
                double amount = categories[category]!;
                return ListTile(
                  title: Text(category),
                  subtitle: Row(
                    children: [
                      Expanded(
                        flex: (amount / total * 1000).round(),
                        child: Container(height: 20, color: Colors.blue),
                      ),
                      Expanded(
                        flex: (1000 - (amount / total * 1000).round()),
                        child: Container(height: 20, color: Colors.grey[200]),
                      ),
                    ],
                  ),
                  trailing: Text('\$${amount.toStringAsFixed(2)}'),
                );
              },
            ),
          ),
          Divider(),
          // Top Expenses section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Top Expenses',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                ...topExpenses.map((expense) => ListTile(
                      leading: Icon(Icons.arrow_forward, color: Colors.red),
                      title: Text('${expense.description}'),
                      subtitle: Text('${expense.location}'),
                      trailing: Text('\$${expense.amount.toStringAsFixed(2)}'),
                    )),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement action to add a new expense
        },
        child: Icon(Icons.add),
        tooltip: 'Add Expense',
      ),
    );
  }
}