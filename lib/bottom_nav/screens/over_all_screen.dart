import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/order_model.dart';
import '../../utils/color.dart';
import '../../utils/navigation/navigator.dart';
import '../components/warning_widget.dart';
import '../providers/order_provider.dart';
import 'order_stat_screen.dart';

class OverAllOrders extends ConsumerWidget {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> orders;
  final String warningText;
  const OverAllOrders({
    super.key,
    required this.orders,
    required this.warningText
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    if (orders.isNotEmpty) {
      return ListView.builder(
        itemCount: orders.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          OrderModel orderModel = OrderModel.fromMap(orders[index].data());
          return InkWell(
            onTap: () {
              Navigation.instance.navigateTo(OrderStatusScreen.id.path,
                  args: orderModel.orderId);
            },
            child: Card(
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset(
                          ref.read(orderProv).orderIcon(orderModel.orderName),
                          scale: 8,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                        child: VerticalDivider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            orderModel.orderName,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(orderModel.orderDate)
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(
                          'Rs ${orderModel.orderPrice}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      )
                    ],
                  ))
                ],
              ),
            ),
          );
        },
      );
    } else {
      return  WarningWidget(
        tex: warningText,
      );
    }
  }
}
