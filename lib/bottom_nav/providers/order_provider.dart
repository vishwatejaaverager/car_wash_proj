import 'package:car_wash_proj/core/constants/constants.dart';
import 'package:car_wash_proj/utils/streams.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderProv = ChangeNotifierProvider((ref) {
  return OrderProvider();
});

class OrderProvider with ChangeNotifier {
  final Streams _streams = Streams();

  String orderIcon(String serv) {
    if (serv == 'Car Wash') {
      return Constants.carWash;
    } else if (serv == 'Interior Cleaning') {
      return Constants.interior;
    } else if (serv == 'Carwash & Interior') {
      return Constants.intWash;
    } else {
      return Constants.deepInt;
    }
  }

  int configActiveState(String stat) {
    if (stat == 'ordered') {
      return 0;
    } else if (stat == 'confirmed') {
      return 1;
    } else if (stat == 'arrived') {
      return 2;
    } else if (stat == 'cleaning') {
      return 2;
    } else if (stat == 'completed') {
      return 4;
    } else {
      return 5;
    }
  }

  bool _loadingOrder = false;
  bool get loadigOrder => _loadingOrder;

  final List<QueryDocumentSnapshot<Map<String, dynamic>>> _onGoingOrders = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> get onGoingOrders =>
      _onGoingOrders;

  final List<QueryDocumentSnapshot<Map<String, dynamic>>> _completedOrders = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> get completedOrders =>
      _completedOrders;

  final List<QueryDocumentSnapshot<Map<String, dynamic>>> _canceledOrders = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> get canceledOrders =>
      _canceledOrders;

  getAndfilterOrders(String userId) async {
    _loadingOrder = true;
    var a =
        await _streams.userQuery.doc(userId).collection(Streams.orders).get();
    var b = a.docs;
    if (_onGoingOrders.isEmpty &&
        _completedOrders.isEmpty &&
        _canceledOrders.isEmpty) {
      for (var i = 0; i < b.length; i++) {
        if (b[i].data()['orderStat'] == 'completed') {
          _completedOrders.add(b[i]);
        } else if (b[i].data()['orderStat'] == 'cancelled') {
          _canceledOrders.add(b[i]);
        } else {
          _onGoingOrders.add(b[i]);
        }
      }
    }
    _loadingOrder = false;
    notifyListeners();
  }
}
