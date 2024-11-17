import 'package:flutter/material.dart';
import '../repositories/data_repository.dart'; // Ensure correct path
import '../models/expense.dart'; // Ensure this model is correct and accessible

class ExpensesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses'),
      ),
      body: FutureBuilder<List<Expense>>(
        future: DataRepository().loadExpenses(), // Fetches all transactions
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            // Filtering to show only 'Debit' transactions
            var debitTransactions = snapshot.data!
              .where((expense) => expense.description.contains('Debit')) // Filter for 'Debit' in the description
              .toList();

            return ListView.builder(
              itemCount: debitTransactions.length,
              itemBuilder: (context, index) {
                Expense expense = debitTransactions[index];
                return ListTile(
                  title: Text('${expense.description} at ${expense.location}'), // Display location along with description
                  subtitle: Text('${expense.amount.toStringAsFixed(2)} on ${expense.date.toString()}'),
                  trailing: Icon(Icons.edit), // Icon to edit the expense
                  onTap: () {
                    // Here you might open a new screen to edit the expense
                  },
                );
              },
            );
          } else {
            return Center(child: Text('No expenses found'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action to add a new expense
          // This might open a form to submit a new expense
        },
        child: Icon(Icons.add),
        tooltip: 'Add Expense',
      ),
    );
  }
}
