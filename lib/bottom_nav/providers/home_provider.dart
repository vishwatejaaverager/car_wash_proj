import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeProv = ChangeNotifierProvider((ref) {
  return HomeProvider();
});

class HomeProvider with ChangeNotifier {
  int _activeImage = 0;
  int get activeImage => _activeImage;

  configActiveImage(int a) {
    _activeImage = a;
    notifyListeners();
  }
}
