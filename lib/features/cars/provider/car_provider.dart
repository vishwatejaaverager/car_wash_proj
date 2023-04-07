import 'dart:developer';

import 'package:car_wash_proj/utils/streams.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final carComp = FutureProvider(((ref) {
  return CarProvider().getCarCompanies();
}));

final carModels = FutureProvider.family(
  (ref, arg) {
    return CarProvider().getCarCompaniesModels(arg.toString());
  },
);

// final carModels = FutureProvider(((ref,) {
//   return CarProvider().getCarCompaniesModels();
// }));

final carProvider = ChangeNotifierProvider(((ref) {
  return CarProvider();
}));

class CarProvider with ChangeNotifier {
  final Streams _streams = Streams();

  String _carComp = '';
  String get carComp => _carComp;

  configCompanyName(String carComp) {
    _carComp = carComp;
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> _allCars = [];

  List<QueryDocumentSnapshot<Map<String, dynamic>>> _filterCars = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> get filtered => _filterCars;

  List<QueryDocumentSnapshot<Map<String, dynamic>>> _filterModels = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> get filteredModels =>
      _filterModels;

  setAllCars(List<QueryDocumentSnapshot<Map<String, dynamic>>> cars) {
    _allCars = cars;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getCarCompanies() async {
    //  List<QueryDocumentSnapshot<Map<String, dynamic>>> comp = [];
    var a = await _streams.carsQuery.get();
    var b = a.docs;
    _allCars = a.docs;

    return b;
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> _allModels = [];

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getCarCompaniesModels(String id) async {
    var a = await _streams.carsQuery.doc(id).collection("models").get();
    var b = a.docs;
    _allModels = b;

    return b;
  }

  getFilteredCarComp(String query, {bool isModels = false}) {
    _filterCars = [];
    _filterModels = [];
    log(_allCars.length.toString());
    if (!isModels) {
      for (var i = 0; i < _allCars.length; i++) {
        log("cmng");
        if (_allCars[i]['company_name']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase())) {
          log("message");
          _filterCars.add(_allCars[i]);
          notifyListeners();
        }
      }
    } else {
      for (var i = 0; i < _allModels.length; i++) {
        //  log("cmng in models");
        if (_allModels[i]['car_name']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase())) {
          //log("message");
          // log(_filterCars.length.toString());
          // log(_allModels[i]['car_name'].toString());
          _filterModels.add(_allModels[i]);
          //   log(_filterCars[i]['car_name']);
          //SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          notifyListeners();
          // });
        }
      }
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        notifyListeners();
      });
    }
  }

  // saveUserToFirebase(){
  //   _streams.userQuery.doc()
  // }
}
