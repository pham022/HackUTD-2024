import 'package:flutter/material.dart';

class SavingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Placeholder data for savings goals
    final List<Map<String, dynamic>> savings = [
      {"goal": "Emergency Fund", "amount": 1000.00, "progress": 800.00},
      {"goal": "Vacation", "amount": 2000.00, "progress": 500.00},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Savings'),
      ),
      body: ListView.builder(
        itemCount: savings.length,
        itemBuilder: (context, index) {
          var saving = savings[index];
          return ListTile(
            title: Text(saving['goal']),
            subtitle: Text('Saved ${saving['progress']} of ${saving['amount']}'),
            trailing: Icon(Icons.show_chart), // Icon to show savings progress
            onTap: () {
              // Action when tapping on a savings goal
            },
          );
        },
      ),
    );
  }
}
