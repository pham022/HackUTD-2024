import 'package:flutter/material.dart';
import '../repositories/data_repository.dart';
import '../models/expense.dart';

class ExpensesProvider with ChangeNotifier {
  List<Expense> _expenses = [];

  List<Expense> get expenses => _expenses;

  Future<void> loadExpenses() async {
    _expenses = await DataRepository().loadExpenses();
    notifyListeners();
  }
}
