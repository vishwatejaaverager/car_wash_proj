import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderProv = ChangeNotifierProvider((ref) {
  return OrderProvider();
});

class OrderProvider with ChangeNotifier {
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
}
