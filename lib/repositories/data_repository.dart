import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import '../models/expense.dart'; // Ensure you have updated your Expense model as shown above

class DataRepository {
  Future<List<Expense>> loadExpenses() async {
    try {
      final rawData = await rootBundle.loadString('assets/Generated_Transactions.csv');
      List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);
      return listData.sublist(1).map((data) {
        try {
          final description = data[4] as String; // Assuming 5th column is the detailed description
          final amount = double.parse(data[2].toString()); // Assuming 3rd column is the amount
          final date = DateTime.tryParse(data[3]) ?? DateTime.now(); // Assuming 4th column is the date
          final location = data[5] as String; // Assuming 6th column is the location
          return Expense(description: description, amount: amount, date: date, location: location);
        } catch (e) {
          print("Error parsing line: $data, Error: $e");
          return null; // Return null if any parsing error, filter out later
        }
      }).where((expense) => expense != null).cast<Expense>().toList(); // Filtering out null values
    } catch (e) {
      print("Failed to load or parse the CSV file: $e");
      return []; // Return an empty list on failure to load or parse CSV
    }
  }
}
