import 'package:car_wash_proj/bottom_nav/navigation_drawer.dart';
import 'package:car_wash_proj/bottom_nav/providers/booking_provider.dart';
import 'package:car_wash_proj/models/order_model.dart';
import 'package:car_wash_proj/utils/routes.dart';
import 'package:car_wash_proj/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;
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
    // final serviceModel = ref.refresh(bookingProv).serviceModel;
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(),
          backgroundColor: Colors.white,
          elevation: 0,
          // title: const Text("Home"),
        ),
        drawer: const CustomNavigation(),
        body: Consumer(
          builder: (context, ref, child) {
            OrderModel orderModel = ref.read(bookingProv).orderModel!;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  title: const Text(
                    'Choose Payment',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  minLeadingWidth: 0,
                  minVerticalPadding: 0,
                  horizontalTitleGap: 8,
                ),
                Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Summary',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          sbh(12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    orderModel.orderName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${orderModel.orderTime['time'].toString()} ${orderModel.orderTime['zone'].toString()}, ${orderModel.orderDate}',
                                    style: const TextStyle(color: Colors.grey,fontSize: 12),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 25,
                                    child: VerticalDivider(
                                      thickness: 1,
                                      color: Colors.grey.withOpacity(0.5),
                                    ),
                                  ),
                                  sbw(12),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text(
                                        'cost',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.grey),
                                      ),
                                      Text(
                                        'Rs ${orderModel.orderPrice}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          )
                        ]),
                  ),
                ),
                
              ],
            );
          },
        ));
  }
}
