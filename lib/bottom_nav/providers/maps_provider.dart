import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_geocoder/location_geocoder.dart';

import '../../utils/navigation/navigator.dart';

final mapsProvider = ChangeNotifierProvider((ref) {
  return MapsProvider();
});

class MapsProvider with ChangeNotifier {
  final CameraPosition _initialPosition =
      const CameraPosition(target: LatLng(17.4326, 78.4071), zoom: 20);

  CameraPosition get intialPosition => _initialPosition;

  LatLng _latLng = const LatLng(17.4326, 78.4071);
  LatLng get latlng => _latLng;

  Future getUserCurrentLocation(
      Completer<GoogleMapController> completer) async {
    await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    ).then((value) async {
      _latLng = LatLng(value.latitude, value.longitude);
      GoogleMapController controller = await completer.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(value.latitude, value.longitude), zoom: 20)));
    });
    notifyListeners();
  }

  List<dynamic> _placesData = [];
  List<dynamic> get placesData => _placesData;

  placeAutocomplete(String query) async {
    log(query.toString());
    Uri uri = Uri.https(
        "maps.googleapis.com",
        '/maps/api/place/autocomplete/json',
        {"input": query, "key": "AIzaSyD2KTqh2cJBIeMKfb6aB_-hgWRO5hpVsuo"});
    await fetchUrl(uri);
    // if (res != null) {
    //   log(res.toString());
    // }
  }

  fetchUrl(Uri uri, {Map<String, String>? headers}) async {
    try {
      final res = await http.get(uri, headers: headers);
      if (res.statusCode == 200) {
        log(res.body.toString());
        _placesData = jsonDecode(res.body.toString())['predictions'];
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          notifyListeners();
        });
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // Future<GBData> getNameFromCoOrdinates(LatLng latLng) async {
  //   GBLatLng gbLatLng = GBLatLng(lat: latlng.latitude, lng: latlng.longitude);
  //   GBData a = await GeocoderBuddy.findDetails(gbLatLng);
  //   return a;
  // }

  Future<Address> getNameAndCordinates(LatLng latLng) async {
    log("came");

    const apiKey = 'AIzaSyD2KTqh2cJBIeMKfb6aB_-hgWRO5hpVsuo';
    final LocatitonGeocoder geocoder = LocatitonGeocoder(apiKey);
    final address = await geocoder.findAddressesFromCoordinates(
        Coordinates(latLng.latitude, latLng.longitude));

    return address[0];
  }

  Address? _address;
  Address? get adress => _address;

  Future<Address> getCoordinates(
      String a, Completer<GoogleMapController> completer) async {
    const apiKey = 'AIzaSyD2KTqh2cJBIeMKfb6aB_-hgWRO5hpVsuo';
    final LocatitonGeocoder geocoder = LocatitonGeocoder(apiKey);
    await geocoder.findAddressesFromQuery(a).then((value) async {
      Navigation.instance.pushBack();
      _latLng = LatLng(
          value[0].coordinates.latitude!, value[0].coordinates.longitude!);
      GoogleMapController controller = await completer.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(_latLng.latitude, _latLng.longitude), zoom: 20)));
      _address = value[0];
    });

    //Navigation.instance.pushBack();
    clearPlacesList();
    notifyListeners();
    return _address!;
  }

  clearPlacesList() {
    _placesData.clear();
    notifyListeners();
  }
}
