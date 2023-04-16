import 'package:car_wash_proj/bottom_nav/navigation_drawer.dart';
import 'package:car_wash_proj/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math'as math;
import '../../core/constants/constants.dart';
import '../../utils/color.dart';
import '../../utils/navigation/navigator.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  static const id = AppRoutes.paymentScreen;
  const PaymentScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(),
        backgroundColor: Colors.white,
        elevation: 0,
        // title: const Text("Home"),
      ),
      drawer: const CustomNavigation(),
      body: Column(
        children: [
          ListTile(
             leading: Transform.rotate(
              angle: -math.pi,
              child: InkWell(
                onTap: () {
                  Navigation.instance.pushBack();
                },
                child: Image.asset(
                  Constants.arow,
                  scale: 15,
                  color: primaryColor,
                ),
              ),
            ),
            minLeadingWidth: 0,
            minVerticalPadding: 0,
            horizontalTitleGap: 2,
          )
        ],
      ),
    );
  }
}
