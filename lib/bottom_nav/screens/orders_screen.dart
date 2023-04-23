import 'package:car_wash_proj/bottom_nav/components/tabs.dart';
import 'package:car_wash_proj/bottom_nav/providers/booking_provider.dart';
import 'package:car_wash_proj/bottom_nav/providers/order_provider.dart';
import 'package:car_wash_proj/bottom_nav/screens/over_all_screen.dart';
import 'package:car_wash_proj/models/user_model.dart';
import 'package:car_wash_proj/utils/routes.dart';
import 'package:car_wash_proj/utils/utils.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/constants.dart';
import '../../utils/navigation/navigator.dart';

class OrdersScreen extends ConsumerStatefulWidget {
  static const id = AppRoutes.ordersScreen;
  const OrdersScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late UserModel _userModel;
  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 3);
    _userModel = ref.read(bookingProv).userModel!;
    ref.read(orderProv).getAndfilterOrders(_userModel.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderRef = ref.watch(orderProv);
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.white,
        //   iconTheme: const IconThemeData(),
        //   elevation: 0,
        // ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  Transform.rotate(
                    angle: -math.pi,
                    child: InkWell(
                      onTap: () {
                        Navigation.instance.pushBack();
                      },
                      child: Image.asset(
                        Constants.arow,
                        scale: 15,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  sbw(12),
                  const Text(
                    "My Requests",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ],
              ),
            ),
            FrequencyTabs(
                controller: _tabController,
                tags: const [],
                tabs: const [
                  SizedBox(child: Center(child: Text("On-Going"))),
                  SizedBox(child: Center(child: Text("Completed"))),
                  SizedBox(child: Center(child: Text("Cancelled"))),
                ]),
            Expanded(
                child: TabBarView(controller: _tabController, children: [
              OverAllOrders(
                orders: orderRef.onGoingOrders,
                warningText: 'No On Going Orders',
              ),
              OverAllOrders(
                orders: orderRef.completedOrders,
                warningText: 'No Completed Orders',
              ),
              OverAllOrders(
                orders: orderRef.canceledOrders,
                warningText: 'No Cancelled Orders',
              )
            ]))
          ],
        ),
      ),
    );
  }
}
