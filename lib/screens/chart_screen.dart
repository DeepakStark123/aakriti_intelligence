import 'package:aakriti_inteligence/widgets/cart_widget.dart';
import 'package:flutter/material.dart';

class MycartScreen extends StatelessWidget {
  MycartScreen({super.key});

  final List<Mobile> mobiles = [
    Mobile("mobile1", DateTime(2023, 1, 1), 500.0),
    Mobile("mobile2", DateTime(2023, 2, 5), 700.0),
    Mobile("mobile3", DateTime(2023, 3, 8), 600.0),
    Mobile("mobile1", DateTime(2023, 4, 1), 900.0),
    Mobile("mobile2", DateTime(2023, 6, 3), 700.0),
    Mobile("mobile3", DateTime(2023, 7, 2), 1000.0),
  ];

  @override
  Widget build(BuildContext context) {
    return ChartWidget(mobilesList: mobiles);
  }
}
