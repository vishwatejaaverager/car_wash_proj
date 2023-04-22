import 'package:flutter/material.dart';

import '../../models/order_model.dart';
import '../../models/user_model.dart';
import '../../utils/utils.dart';
import '../../utils/widget/cache_image.dart';
import '../screens/order_stat_screen.dart';

class OrderHeader extends StatelessWidget {
  const OrderHeader({
    super.key,
    required this.widget,
    required this.userModel,
    required this.orderModel,
  });

  final OrderStatusScreen widget;
  final UserModel userModel;
  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Order Id :${widget.orderId}',
                  style: TextStyle(color: Colors.grey.shade600),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  radius: 30,
                  child: CacheImage(
                    image: userModel.profile,
                    height: 50,
                    width: 50,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      orderModel.orderName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    Text(
                      "Time : ${orderModel.orderTime['time']} ${orderModel.orderTime['zone']}",
                      style: const TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      width: size.width / 1.4,
                      child: Text(
                        orderModel.orderLoc,
                        style: const TextStyle(
                            color: Colors.grey,
                            overflow: TextOverflow.ellipsis),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          sbh(20)
        ],
      ),
    );
  }
}
