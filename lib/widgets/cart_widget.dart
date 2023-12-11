import 'package:aakriti_inteligence/utils/colors.dart';
import 'package:aakriti_inteligence/widgets/custom_btn.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartWidget extends StatefulWidget {
  final List<Mobile> mobilesList;

  const ChartWidget({super.key, required this.mobilesList});

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  bool isDetailScreen = true;
  bool isNewsScreen = false;
  bool isLogsScreen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Price History'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 6),
              child: Text(
                'Price History Chart',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 2),
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: AppColors.kwhiteColor,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 24, bottom: 16, left: 4, right: 16),
                  child: LineChart(
                    LineChartData(
                      gridData: const FlGridData(show: true),
                      titlesData: const FlTitlesData(
                        show: true,
                        topTitles: AxisTitles(
                            sideTitles: SideTitles(
                                reservedSize: 30, showTitles: false)),
                        rightTitles: AxisTitles(
                            sideTitles: SideTitles(
                                reservedSize: 44, showTitles: false)),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: const Border(
                          left: BorderSide(
                            color: Color(0xff37434d),
                            width: 1,
                          ),
                          bottom: BorderSide(
                            color: Color(0xff37434d),
                            width: 1,
                          ),
                        ),
                      ),
                      minX: 0,
                      minY: 0,
                      maxX: widget.mobilesList.length.toDouble() - 1,
                      maxY: _calculateMaxPrice(),
                      lineBarsData: [
                        LineChartBarData(
                          spots: _generateSpots(),
                          shadow: const Shadow(color: AppColors.kwhiteColor),
                          isCurved: true,
                          color: AppColors.kappBarColorlight,
                          belowBarData: BarAreaData(
                            show: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: CustomElevatedButton(
                          backgroundColor: isDetailScreen
                              ? AppColors.kbuttonColor
                              : AppColors.kprimaryColor,
                          child: const Text("Details"),
                          onPressed: () {
                            setState(() {
                              isDetailScreen = true;
                              isNewsScreen = false;
                              isLogsScreen = false;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: CustomElevatedButton(
                          backgroundColor: isNewsScreen
                              ? AppColors.kbuttonColor
                              : AppColors.kprimaryColor,
                          child: const Text("News"),
                          onPressed: () {
                            setState(() {
                              isDetailScreen = false;
                              isNewsScreen = true;
                              isLogsScreen = false;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: CustomElevatedButton(
                          backgroundColor: isLogsScreen
                              ? AppColors.kbuttonColor
                              : AppColors.kprimaryColor,
                          child: const Text("Logs"),
                          onPressed: () {
                            setState(() {
                              isDetailScreen = false;
                              isNewsScreen = false;
                              isLogsScreen = true;
                            });
                          },
                        ),
                      ),
                    ],
                  )
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<FlSpot> _generateSpots() {
    return widget.mobilesList
        .asMap()
        .entries
        .map((entry) => FlSpot(entry.key.toDouble(), entry.value.price))
        .toList();
  }

  double _calculateMaxPrice() {
    return widget.mobilesList.isNotEmpty
        ? widget.mobilesList
            .map((mobile) => mobile.price)
            .reduce((a, b) => a > b ? a : b)
        : 1000.0;
  }
}

class Mobile {
  final String name;
  final DateTime timestamp;
  final double price;

  Mobile(
    this.name,
    this.timestamp,
    this.price,
  );
}
