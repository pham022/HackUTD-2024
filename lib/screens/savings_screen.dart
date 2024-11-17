import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../repositories/data_repository.dart';
import 'pie_chart_painter.dart';

class SavingsScreen extends StatelessWidget {
  final DataRepository repository = DataRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Savings Goals'),
      ),
      body: FutureBuilder<List<Expense>>(
        future: repository.loadExpenses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            double credits = snapshot.data!
                .where((expense) => expense.description.toLowerCase().contains('credit'))
                .fold(0.0, (sum, current) => sum + current.amount);
            double debits = snapshot.data!
                .where((expense) => expense.description.toLowerCase().contains('debit'))
                .fold(0.0, (sum, current) => sum + current.amount);

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  CustomPaint(
                    size: Size(MediaQuery.of(context).size.width, 200),
                    painter: PieChartPainter(credits: credits, debits: debits),
                  ),
                  Text('Credits: \$${credits.toStringAsFixed(2)}', style: TextStyle(color: Colors.green)),
                  Text('Debits: \$${debits.toStringAsFixed(2)}', style: TextStyle(color: Colors.red)),
                  Text('You saved \$${(credits - debits).toStringAsFixed(2)} this month!',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: (credits - debits) >= 0 ? Colors.green : Colors.red)),
                  SizedBox(height: 50),
                  _buildBuyingGoals(),
                ],
              ),
            );
          } else {
            return Center(child: Text('No transactions data available'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action to add a new savings goal
        },
        child: Icon(Icons.add),
        tooltip: 'Add New Goal',
      ),
    );
  }

  Widget _buildBuyingGoals() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Buying Goals', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ListTile(
          leading: Icon(Icons.home, color: Colors.blue),
          title: Text('House Down Payment'),
          subtitle: Text('Goal: \$50,000'),
          trailing: Icon(Icons.chevron_right),
        ),
        ListTile(
          leading: Icon(Icons.car_rental, color: Colors.green),
          title: Text('Car Purchase'),
          subtitle: Text('Goal: \$20,000'),
          trailing: Icon(Icons.chevron_right),
        ),
        ListTile(
          leading: Icon(Icons.laptop_mac, color: Colors.deepOrange),
          title: Text('New Laptop'),
          subtitle: Text('Goal: \$1,500'),
          trailing: Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}
