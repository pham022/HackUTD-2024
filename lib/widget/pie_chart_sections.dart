import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../data/pie_chart_data.dart'; // Adjust the path to match your project structure

class PieChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pie Chart Example'),
      ),
      body: SfCircularChart(
        title: ChartTitle(text: 'Pie Chart Example'),
        legend: Legend(isVisible: true),
        series: <CircularSeries>[
          PieSeries<Data, String>(
            dataSource: PieData.data, // Use your PieData.data here
            xValueMapper: (Data data, _) => data.name, // Map the name for x-axis
            yValueMapper: (Data data, _) => data.percent, // Map the percentage for y-axis
            dataLabelMapper: (Data data, _) => '${data.percent}%', // Map the label
            dataLabelSettings: DataLabelSettings(isVisible: true), // Show data labels
            explode: true, // Enable explode effect
            explodeIndex: 0, // Explode the first segment
          ),
        ],
      ),
    );
  }
}
