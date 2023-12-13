import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class LineChartSample extends StatelessWidget {
  LineChartSample({super.key});

  final List<Map<String, dynamic>> data = [
    {"id": 1, "price": 200.0, "date": "2023-12-10T14:33:42.883072+05:30"},
    {"id": 2, "price": 300.0, "date": "2023-12-10T14:34:04.435360+05:30"},
    {"id": 3, "price": 400.0, "date": "2023-12-10T14:34:08.793907+05:30"},
    {"id": 4, "price": 50.0, "date": "2023-12-10T14:34:12.750465+05:30"},
    {"id": 5, "price": 500.0, "date": "2023-12-10T14:34:17.097821+05:30"},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LineChart(
        LineChartData(
          // titlesData: FlTitlesData(
          //   leftTitles: const AxisTitles(
          //       sideTitles: SideTitles(reservedSize: 44, showTitles: true)),
          //   bottomTitles: AxisTitles(
          //     sideTitles: SideTitles(
          //       showTitles: true,
          //       reservedSize: 22,
          //       getTitlesWidget: (value, meta) {
          //         return data[value.toInt()]["date"];
          //       },
          //     ),
          //   ),
          // ),
          titlesData: FlTitlesData(
            show: true,
            topTitles: const AxisTitles(
                sideTitles: SideTitles(reservedSize: 30, showTitles: false)),
            rightTitles: const AxisTitles(
                sideTitles: SideTitles(reservedSize: 44, showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 22,
                  getTitlesWidget: ((value, meta) {
                    return Text(data[value.toInt()]["date"].substring(0, 10));
                  })),
            ),
          ),
          gridData: const FlGridData(
            show: true,
            horizontalInterval: 1.0,
          ),
          borderData: FlBorderData(
            show: true,
          ),
          minX: 0,
          maxX: data.length.toDouble() - 1,
          minY: 0,
          maxY: getMaxYValue(),
          lineBarsData: [
            LineChartBarData(
              spots: getSpots(),
              isCurved: true,
              color: Colors.blue,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
      ),
    );
  }

  List<FlSpot> getSpots() {
    return data
        .asMap()
        .map((index, item) =>
            MapEntry(index.toDouble(), FlSpot(index.toDouble(), item['price'])))
        .values
        .toList();
  }

  double getMaxYValue() {
    double max = 0.0;
    for (var item in data) {
      if (item['price'] > max) {
        max = item['price'];
      }
    }
    return max;
  }
}
