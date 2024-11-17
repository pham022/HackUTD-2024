import 'package:flutter/material.dart';
import '../repositories/data_repository.dart';
import '../models/expense.dart';  // Ensure this is pointing to your Expense model correctly

class TransactionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: FutureBuilder<List<Expense>>(
        future: DataRepository().loadExpenses(),  // This assumes your DataRepository is set up as shown previously
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error loading data: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Expense expense = snapshot.data![index];
                return ListTile(
                  title: Text('${expense.description} at ${expense.location}'), // Modified to include location
                  subtitle: Text('${expense.amount.toStringAsFixed(2)} on ${expense.date.toString()}'),
                );
              },
            );
          } else {
            return Center(child: Text('No transactions found'));
          }
        },
      ),
    );
  }
}
