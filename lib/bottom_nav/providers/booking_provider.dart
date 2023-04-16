import 'package:car_wash_proj/models/order_model.dart';
import 'package:car_wash_proj/models/service_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final bookingProv = ChangeNotifierProvider((ref) {
  return BookingProvider();
});

class BookingProvider with ChangeNotifier {
  OrderModel? _orderModel;
  OrderModel? get orderModel => _orderModel;

  configOrderModel(OrderModel orderModel) {
    _orderModel = orderModel;
  }

  ServiceModel? _serviceModel;
  ServiceModel? get serviceModel => _serviceModel;

  configServiceModel(ServiceModel serviceModel) {
    _serviceModel = serviceModel;
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
    print(_latLng);
  }

  String _placeDes = '';
  String get placeDes => _placeDes;

  configPlaceDes(String a) {
    _placeDes = a;
    print(_placeDes);
  }
}
