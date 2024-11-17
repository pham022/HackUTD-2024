import 'package:flutter/material.dart';
import '../repositories/data_repository.dart';
import '../models/expense.dart';  // Ensure this is pointing to your Expense model correctly

class TransactionsScreen extends StatelessWidget {
  // List of US states and major cities for comparison
  final List<String> usLocations = [
    "Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut",
    "Delaware", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa",
    "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan",
    "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire",
    "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio",
    "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota",
    "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia",
    "Wisconsin", "Wyoming", "Philadelphia", "San Jose", "San Antonio", "San Diego", "Dallas",
    "New York", "Los Angeles", "Chicago", "Phoenix", "Houston"
  ];

  bool _isInternational(String location) {
    // Check if the location string contains any of the US locations
    return !usLocations.any((usLocation) => location.contains(usLocation));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: FutureBuilder<List<Expense>>(
        future: DataRepository().loadExpenses(),  // Fetches all transaction data
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
                bool isInternational = _isInternational(expense.location);
                return ListTile(
                  title: Text('${expense.description} at ${expense.location}',
                    style: TextStyle(color: isInternational ? Colors.red : Colors.black),
                  ),
                  subtitle: Text('${expense.amount.toStringAsFixed(2)} on ${expense.date}',
                    style: TextStyle(color: isInternational ? Colors.red : Colors.black),
                  ),
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
