import 'package:aakriti_inteligence/models/product_price_list_model.dart';
import 'package:aakriti_inteligence/utils/api_service.dart';
import 'package:aakriti_inteligence/utils/app_string.dart';
import 'package:aakriti_inteligence/utils/colors.dart';
import 'package:aakriti_inteligence/utils/my_utitlity.dart';
import 'package:aakriti_inteligence/widgets/custom_btn.dart';
import 'package:aakriti_inteligence/widgets/custom_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class MyLineChart extends StatefulWidget {
  const MyLineChart({super.key});

  @override
  State<MyLineChart> createState() => _MyLineChartState();
}

class _MyLineChartState extends State<MyLineChart> {
  List<ProductsData> productsPriceList = [];
  List<double> prices = [];
  List<double> dates = [];
  bool pageLoading = true;
  bool isDetailScreen = true;
  bool isNewsScreen = false;
  bool isLogsScreen = false;

  setLoading(bool value) {
    setState(() {
      pageLoading = value;
    });
  }

  getproductsPrice(int productId) async {
    setLoading(true);
    var data = {"product_id": productId};
    try {
      final response = await ApiService.postApi(
        endpoint: AppStrings.productsPriceApi,
        body: data,
        context: context,
      );
      debugPrint('productsPrice Res: ${response.statusCode} ${response.body}');
      productsPriceList = [];
      if (response.statusCode == 200) {
        var res = productPriceListModelFromJson(response.body.toString());
        productsPriceList = [];
        if (res.status == 200) {
          productsPriceList = res.productsData;
          int maxCount = productsPriceList.length;
          for (int i = 0; i < (maxCount > 7 ? 7 : maxCount); i++) {
            setState(() {
              // Price List
              prices.add(productsPriceList[i].price);
              DateTime date = productsPriceList[i].date;
              String ecoTimeStamp = "${date.millisecondsSinceEpoch}";
              // Dates List
              dates.add(double.parse(ecoTimeStamp));
            });
          }
        } else {
          if (context.mounted) {
            Utility.showCustomSnackbar(context, res.message ?? "Fail", false);
          }
        }
      } else {
        debugPrint("Error = ${response.statusCode} message = ${response.body}");
      }
    } catch (e) {
      debugPrint('Exception Caught: $e');
    } finally {
      setLoading(false);
    }
  }

  @override
  void initState() {
    getproductsPrice(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomTextWidget(
          text: "Chart View",
        ),
      ),
      body: dates.isEmpty || prices.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 6),
                      child: CustomTextWidget(
                        text: 'Price History Chart',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    SizedBox(
                      height: 0.5.sh,
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
                                  right: BorderSide(
                                    color: Color(0xff37434d),
                                    width: 1,
                                  ),
                                ),
                              ),
                              minX: dates.isNotEmpty ? dates.first : 0.0,
                              maxX: dates.isNotEmpty ? dates.last : 0.0,
                              minY: prices.isNotEmpty
                                  ? prices.reduce((a, b) => a < b ? a : b)
                                  : 0.0,
                              maxY: prices.isNotEmpty
                                  ? prices.reduce((a, b) => a > b ? a : b)
                                  : 0.0,
                              lineBarsData: [
                                LineChartBarData(
                                  spots: List.generate(
                                    dates.isNotEmpty ? dates.length : 0,
                                    (index) => FlSpot(
                                      dates.isNotEmpty ? dates[index] : 0,
                                      prices.isNotEmpty ? prices[index] : 0,
                                    ),
                                  ),
                                  isCurved: true,
                                  belowBarData: BarAreaData(
                                    show: true,
                                    color: AppColors.kChartAreaColor,
                                  ),
                                  // color: AppColors.kprimaryColor,
                                  shadow:
                                      const Shadow(color: Colors.transparent),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.1.sh,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: CustomElevatedButton(
                                      backgroundColor: isDetailScreen
                                          ? AppColors.kbuttonColor
                                          : AppColors.kprimaryColor,
                                      child: const CustomTextWidget(
                                        text: 'Details',
                                      ),
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
                                      child: const CustomTextWidget(
                                        text: 'News',
                                      ),
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
                                      child: const CustomTextWidget(
                                        text: 'Logs',
                                      ),
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
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (isLogsScreen) ...[
                      productsPriceList.isEmpty
                          ? const SizedBox()
                          : SizedBox(
                              height: 0.8.sh,
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: productsPriceList.length,
                                itemBuilder: (context, index) {
                                  final historyItem = productsPriceList[index];
                                  final price = historyItem.price;
                                  final date = historyItem.date;
                                  return Card(
                                    elevation: 5,
                                    margin: const EdgeInsets.all(8),
                                    child: ListTile(
                                      title: CustomTextWidget(
                                        text: 'Price: $price',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      subtitle: CustomTextWidget(
                                        text:
                                            'Date: ${DateFormat('dd-MMM-yyyy').format(date)}',
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                    ],
                  ],
                ),
              ),
            ),
    );
  }
}
