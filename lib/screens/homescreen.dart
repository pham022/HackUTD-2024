import 'package:flutter/material.dart';
import 'expenses_screen.dart';
import 'savings_screen.dart';
import 'reports_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Budget Planner'),
      ),
      body: Column(
        children: [
          _buildSummaryWidget(),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                _buildCategoryCard('Expenses', Icons.monetization_on, Colors.red, context, () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ExpensesScreen()));
                }),
                _buildCategoryCard('Savings', Icons.savings, Colors.green, context, () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SavingsScreen()));
                }),
                _buildCategoryCard('Reports', Icons.bar_chart, Colors.blue, context, () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ReportsScreen()));
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryWidget() {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text('Welcome Back!', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white)),
          Text('You have \$1,200 in savings.', style: TextStyle(fontSize: 16.0, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData iconData, Color color, BuildContext context, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 4.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Icon(iconData, size: 50.0, color: color),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
