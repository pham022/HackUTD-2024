import 'package:flutter/material.dart';

class ExpensesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Placeholder data for expenses
    final List<Map<String, dynamic>> expenses = [
      {"description": "Groceries", "amount": 150.00, "date": "2023-11-01"},
      {"description": "Transport", "amount": 50.00, "date": "2023-11-02"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses'),
      ),
      body: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          var expense = expenses[index];
          return ListTile(
            title: Text(expense['description']),
            subtitle: Text('${expense['amount']} on ${expense['date']}'),
            trailing: Icon(Icons.edit), // Icon to edit the expense
            onTap: () {
              // Here you might open a new screen to edit the expense
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action to add a new expense
        },
        child: Icon(Icons.add),
        tooltip: 'Add Expense',
      ),
    );
  }
}
