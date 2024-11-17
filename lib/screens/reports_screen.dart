import 'package:flutter/material.dart';
import '/screens/pie_chart.dart'; 

class ReportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Financial Reports',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: PieChartPage(), // Include the PieChartPage widget here
          ),
        ],
      ),
    );
  }
}
