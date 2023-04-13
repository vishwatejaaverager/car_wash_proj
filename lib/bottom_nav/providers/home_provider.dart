import 'dart:developer';

import 'package:car_wash_proj/utils/streams.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeProv = ChangeNotifierProvider((ref) {
  return HomeProvider();
});

final services = FutureProvider((ref) {
  return HomeProvider().getServicesFromDb();
});

class HomeProvider with ChangeNotifier {
  final Streams _streams = Streams();
  List<String> _selectedServ = ['', '', '', '', '', ''];
  List<String> get selectedServ => _selectedServ;

  int _selectedTile = 0;
  int get selectedTile => _selectedTile;

  configServ(int index) {
    _selectedTile = index;
    _selectedServ = ['', '', '', '', '', ''];
    _selectedServ[index] = '0';

    notifyListeners();
  }

  int _activeImage = 0;
  int get activeImage => _activeImage;

  configActiveImage(int a) {
    _activeImage = a;
    notifyListeners();
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> _services = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> get loadedServices =>
      _services;

  configServices(List<QueryDocumentSnapshot<Map<String, dynamic>>> a) {
    _services = a;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getServicesFromDb() async {
    log("came into services");
    var a = await _streams.serviceQuery.get();

    _services = a.docs;
    notifyListeners();
    log("${loadedServices.length} this is the length");
    return _services;
  }
}
