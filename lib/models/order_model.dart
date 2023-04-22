// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class OrderModel {
  String orderId;
  String orderName;

  Map<String, dynamic> orderTime;
  String orderActualPrice;
  String orderPrice;
  String orderDate;
  String orderStat;
  // String orderTime;
  String orderLat;
  String orderLong;
  String orderLoc;
  OrderModel({
    required this.orderId,
    required this.orderName,
    required this.orderTime,
    required this.orderActualPrice,
    required this.orderPrice,
    required this.orderDate,
    required this.orderStat,
    required this.orderLat,
    required this.orderLong,
    required this.orderLoc,
  });

  OrderModel copyWith({
    String? orderId,
    String? orderName,
    Map<String, dynamic>? orderTime,
    String? orderActualPrice,
    String? orderPrice,
    String? orderDate,
    String? orderStat,
    String? orderLat,
    String? orderLong,
    String? orderLoc,
  }) {
    return OrderModel(
      orderId: orderId ?? this.orderId,
      orderName: orderName ?? this.orderName,
      orderTime: orderTime ?? this.orderTime,
      orderActualPrice: orderActualPrice ?? this.orderActualPrice,
      orderPrice: orderPrice ?? this.orderPrice,
      orderDate: orderDate ?? this.orderDate,
      orderStat: orderStat ?? this.orderStat,
      orderLat: orderLat ?? this.orderLat,
      orderLong: orderLong ?? this.orderLong,
      orderLoc: orderLoc ?? this.orderLoc,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'orderName': orderName,
      'orderTime': orderTime,
      'orderActualPrice': orderActualPrice,
      'orderPrice': orderPrice,
      'orderDate': orderDate,
      'orderStat': orderStat,
      'orderLat': orderLat,
      'orderLong': orderLong,
      'orderLoc': orderLoc,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['orderId'] as String,
      orderName: map['orderName'] as String,
      orderTime: Map<String, dynamic>.from((map['orderTime'] as Map<String, dynamic>)),
      orderActualPrice: map['orderActualPrice'] as String,
      orderPrice: map['orderPrice'] as String,
      orderDate: map['orderDate'] as String,
      orderStat: map['orderStat'] as String,
      orderLat: map['orderLat'] as String,
      orderLong: map['orderLong'] as String,
      orderLoc: map['orderLoc'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderModel(orderId: $orderId, orderName: $orderName, orderTime: $orderTime, orderActualPrice: $orderActualPrice, orderPrice: $orderPrice, orderDate: $orderDate, orderStat: $orderStat, orderLat: $orderLat, orderLong: $orderLong, orderLoc: $orderLoc)';
  }

  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.orderId == orderId &&
      other.orderName == orderName &&
      mapEquals(other.orderTime, orderTime) &&
      other.orderActualPrice == orderActualPrice &&
      other.orderPrice == orderPrice &&
      other.orderDate == orderDate &&
      other.orderStat == orderStat &&
      other.orderLat == orderLat &&
      other.orderLong == orderLong &&
      other.orderLoc == orderLoc;
  }

  @override
  int get hashCode {
    return orderId.hashCode ^
      orderName.hashCode ^
      orderTime.hashCode ^
      orderActualPrice.hashCode ^
      orderPrice.hashCode ^
      orderDate.hashCode ^
      orderStat.hashCode ^
      orderLat.hashCode ^
      orderLong.hashCode ^
      orderLoc.hashCode;
  }
}
