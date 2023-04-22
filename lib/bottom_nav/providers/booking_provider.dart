import 'package:car_wash_proj/models/order_model.dart';
import 'package:car_wash_proj/models/service_model.dart';
import 'package:car_wash_proj/models/user_model.dart';
import 'package:car_wash_proj/utils/streams.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

final bookingProv = ChangeNotifierProvider((ref) {
  return BookingProvider();
});

class BookingProvider with ChangeNotifier {
  final Streams _streams = Streams();

  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  configUserModel(UserModel userModels) {
    // Logger().e(userModels.userId);
    _userModel = userModels;
  }

  OrderModel? _orderModel;
  OrderModel? get orderModel => _orderModel;

  configOrderModel(OrderModel orderModel) {
    _orderModel = orderModel;
  }

  ServiceModel? _serviceModel;
  ServiceModel? get serviceModel => _serviceModel;

  configServiceModel(ServiceModel serviceModels) {
    // log(serviceModel.serviceNames);
    _serviceModel = serviceModels;
  }

  Map<String, dynamic> _slotTiming = {'time': '', 'zone': ''};
  Map<String, dynamic> get slotTiming => _slotTiming;

  configSlotTiming(slot) {
    // print(slot);
    _slotTiming = slot;
    //  print(_slotTiming);
  }

  LatLng? _latLng;
  LatLng? get latlng => _latLng;

  configLatlng(LatLng latLngs) {
    _latLng = latLngs;
    // print(_latLng);
  }

  String _placeDes = '';
  String get placeDes => _placeDes;

  configPlaceDes(String a) {
    _placeDes = a;
    // print(_placeDes);
  }

  String _date = DateFormat(DateFormat.MONTH_DAY).format(DateTime.now());
  String get date => _date;

  configDate(String dates) {
    _date = dates;
  }

  createOrder(OrderModel orderModel)async {
    _streams.orderQuery.doc(orderModel.orderId).set(orderModel.toMap());
    _streams.userQuery
        .doc(_userModel!.userId)
        .collection(Streams.orders)
        .doc(orderModel.orderId)
        .set(orderModel.toMap());
  }
}
