class Expense {
  final String description;
  final double amount;
  final DateTime date;
  final String location;  // Field to store transaction location

  Expense({required this.description, required this.amount, required this.date, required this.location});
}
