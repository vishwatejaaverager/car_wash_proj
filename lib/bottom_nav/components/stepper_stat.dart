import 'package:flutter/material.dart';

import '../../models/order_model.dart';
import '../../utils/color.dart';
import '../../utils/utils.dart';

class StepperWidget extends StatelessWidget {
  const StepperWidget({
    super.key,
    required this.orderModel,
  });

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            orderModel.orderStat == 'confirmed' ||
                    orderModel.orderStat == 'arrived' ||
                    orderModel.orderStat == 'cleaning' ||
                    orderModel.orderStat == 'completed'
                ? 'Agent Has Confirmed The Order  :)'
                : "Waiting For Agent Confirmation",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: orderModel.orderStat == 'confirmed' ||
                        orderModel.orderStat == 'arrived' ||
                        orderModel.orderStat == 'cleaning' ||
                        orderModel.orderStat == 'completed'
                    ? primaryColor
                    : Colors.grey),
          ),
        ),
        sbh(24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Text(
            orderModel.orderStat == 'arrived' ||
                    orderModel.orderStat == 'cleaning' ||
                    orderModel.orderStat == 'completed'
                ? 'Agent Arrived At Your Door Step'
                : "Agent Will Come At Your Door Step",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: orderModel.orderStat == 'arrived' ||
                        orderModel.orderStat == 'confirmed' ||
                        orderModel.orderStat == 'cleaning' ||
                        orderModel.orderStat == 'completed'
                    ? primaryColor
                    : Colors.grey),
          ),
        ),
        sbh(30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text(
            orderModel.orderStat == 'cleaning'
                ? 'Agent Washing Your Car  This may take \n a while'
                : orderModel.orderStat == 'completed'
                    ? 'Car Washed :)'
                    : 'CarWash',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: orderModel.orderStat == 'cleaning' ||
                        orderModel.orderStat == 'completed'
                    ? primaryColor
                    : Colors.grey),
          ),
        ),
        sbh(30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text(
            orderModel.orderStat == 'completed'
                ? "Order Completed"
                : 'Order Completion',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: orderModel.orderStat == 'completed'
                    ? primaryColor
                    : Colors.grey),
          ),
        ),
      ],
    );
  }
}
