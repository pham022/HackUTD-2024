import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../data/pie_chart_data.dart';
import '../widget/indicator_widget.dart';

class PieChartPage extends StatefulWidget {
  @override
  _PieChartPageState createState() => _PieChartPageState();
}

class _PieChartPageState extends State<PieChartPage> {
  int? touchedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Removed the AppBar to eliminate the back arrow and title
      body: Card(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SfCircularChart(
                legend: Legend(isVisible: false), // Disable default legend
                series: <CircularSeries>[
                  PieSeries<Data, String>(
                    dataSource: PieData.data,
                    xValueMapper: (Data data, _) => data.name,
                    yValueMapper: (Data data, _) => data.percent,
                    pointColorMapper: (Data data, _) => data.color, // Map colors explicitly
                    dataLabelMapper: (Data data, _) => '${data.percent}%',
                    dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                      ),
                    explode: true,
                    explodeIndex: touchedIndex ?? -1,
                    onPointTap: (ChartPointDetails details) {
                      setState(() {
                        touchedIndex = details.pointIndex;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: IndicatorsWidget(), // Use the custom indicators
            ),
          ],
        ),
      ),
    );
  }
}
