// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OrderModel {
  String orderName;
  String orderTime;
  String orderActualPrice;
  String orderPrice;
  String orderDate;
  // String orderTime;
  String orderLat;
  String orderLong;
  String orderLoc;
  OrderModel({
    required this.orderName,
    required this.orderTime,
    required this.orderActualPrice,
    required this.orderPrice,
    required this.orderDate,
    required this.orderLat,
    required this.orderLong,
    required this.orderLoc,
  });

  OrderModel copyWith({
    String? orderName,
    String? orderTime,
    String? orderActualPrice,
    String? orderPrice,
    String? orderDate,
    String? orderLat,
    String? orderLong,
    String? orderLoc,
  }) {
    return OrderModel(
      orderName: orderName ?? this.orderName,
      orderTime: orderTime ?? this.orderTime,
      orderActualPrice: orderActualPrice ?? this.orderActualPrice,
      orderPrice: orderPrice ?? this.orderPrice,
      orderDate: orderDate ?? this.orderDate,
      orderLat: orderLat ?? this.orderLat,
      orderLong: orderLong ?? this.orderLong,
      orderLoc: orderLoc ?? this.orderLoc,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderName': orderName,
      'orderTime': orderTime,
      'orderActualPrice': orderActualPrice,
      'orderPrice': orderPrice,
      'orderDate': orderDate,
      'orderLat': orderLat,
      'orderLong': orderLong,
      'orderLoc': orderLoc,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderName: map['orderName'] as String,
      orderTime: map['orderTime'] as String,
      orderActualPrice: map['orderActualPrice'] as String,
      orderPrice: map['orderPrice'] as String,
      orderDate: map['orderDate'] as String,
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
    return 'OrderModel(orderName: $orderName, orderTime: $orderTime, orderActualPrice: $orderActualPrice, orderPrice: $orderPrice, orderDate: $orderDate, orderLat: $orderLat, orderLong: $orderLong, orderLoc: $orderLoc)';
  }

  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;

    return other.orderName == orderName &&
        other.orderTime == orderTime &&
        other.orderActualPrice == orderActualPrice &&
        other.orderPrice == orderPrice &&
        other.orderDate == orderDate &&
        other.orderLat == orderLat &&
        other.orderLong == orderLong &&
        other.orderLoc == orderLoc;
  }

  @override
  int get hashCode {
    return orderName.hashCode ^
        orderTime.hashCode ^
        orderActualPrice.hashCode ^
        orderPrice.hashCode ^
        orderDate.hashCode ^
        orderLat.hashCode ^
        orderLong.hashCode ^
        orderLoc.hashCode;
  }
}
