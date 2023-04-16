import 'dart:async';
import 'dart:developer';

import 'package:car_wash_proj/bottom_nav/providers/booking_provider.dart';
import 'package:car_wash_proj/bottom_nav/providers/maps_provider.dart';
import 'package:car_wash_proj/bottom_nav/screens/payment_screen.dart';
import 'package:car_wash_proj/utils/color.dart';
import 'package:car_wash_proj/utils/routes.dart';
import 'package:car_wash_proj/utils/utils.dart';
import 'package:car_wash_proj/utils/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_geocoder/location_geocoder.dart';

import '../../utils/indicator/loader_indicator.dart';
import '../../utils/navigation/navigator.dart';
//import 'package:location/location.dart';

class LocationScreen extends ConsumerStatefulWidget {
  static const id = AppRoutes.locationScreen;
  const LocationScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LocationScreenState();
}

class _LocationScreenState extends ConsumerState<LocationScreen> {
  // ignore: unused_field
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final gMap = ref.watch(mapsProvider);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            GoogleMap(
                onTap: (argument) {
                  gMap.clearPlacesList();
                  FocusScope.of(context).unfocus();
                },
                markers: {
                  Marker(
                    markerId: const MarkerId("marker1"),
                    position:
                        LatLng(gMap.latlng.latitude, gMap.latlng.longitude),
                    draggable: true,
                    onDragEnd: (value) {
                      // value is the new position
                    },
                    icon: BitmapDescriptor.defaultMarker,
                  ),
                },
                circles: {
                  Circle(
                    strokeWidth: 0,
                    fillColor: blackColor.withOpacity(0.1),
                    circleId: const CircleId('0'),
                    center: LatLng(gMap.latlng.latitude, gMap.latlng.longitude),
                    radius: 20,
                  )
                },
                mapType: MapType.normal,
                onMapCreated: (controller) {
                  _controller.complete(controller);
                },
                initialCameraPosition: const CameraPosition(
                    target: LatLng(17.4326, 78.4071), zoom: 20)),
            Positioned(
                left: 16,
                right: 16,
                bottom: 15,
                child: Button(
                    text: "Locate ME",
                    onTap: () async {
                      log("message");
                      //var b = _controller;
                      //  var a = await Location.instance.getLocation();
                      //gMap.getNameAndCordinates();
                      Loading()
                          .witIndicator(context: context, title: "just a sec");
                      gMap.getUserCurrentLocation(_controller).whenComplete(() {
                        Navigation.instance.pushBack();

                        gMap.getNameAndCordinates(gMap.latlng).then((value) {
                          return showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return LocBottomSheet(address: value);
                            },
                          );
                        });
                      });

                      // setState(() {});
                    })),
            Positioned(
                top: 20,
                child: Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.2),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12))),
                        width: size.width / 1.1,
                        child: TextField(
                          onChanged: (value) {
                            if (value.length > 2) {
                              gMap.placeAutocomplete(value);
                            }
                          },
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search Your Location",
                              suffixIcon: Icon(Icons.search),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        )),
                    SizedBox(
                      width: size.width / 1.1,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: gMap.placesData.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              //  gMap.clearPlacesList();
                              FocusScope.of(context).unfocus();
                              Loading().witIndicator(
                                  context: context, title: "just a sec");

                              gMap
                                  .getCoordinates(
                                      gMap.placesData[index]['description'],
                                      _controller)
                                  .then((value) {
                                return showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return LocBottomSheet(address: value);
                                  },
                                );
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              decoration: BoxDecoration(
                                  color: primaryColor.withOpacity(0.2)),
                              child: Text(
                                gMap.placesData[index]['description'],
                                maxLines: 2,
                                style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class LocBottomSheet extends ConsumerWidget {
  final Address address;
  const LocBottomSheet({super.key, required this.address});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'SELECTED SERVICE LOCATION',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              sbh(16),
              Row(
                children: [
                  Icon(
                    Icons.gps_fixed,
                    color: primaryColor,
                  ),
                  sbw(8),
                  Text(
                    address.addressLine.toString().split(',').first,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                width: size.width / 1.2,
                child: Text(address.addressLine.toString()),
              ),
              sbh(24),
            ],
          ),
        ),
        Button(
            text: 'Confirm Location',
            onTap: () {
              LatLng latLng = ref.read(mapsProvider).latlng;
              ref.read(bookingProv).configLatlng(latLng);
              ref.read(bookingProv).configPlaceDes(address.addressLine!);
              Navigation.instance.navigateTo(PaymentScreen.id.path);
            }),
        sbh(12)
      ],
    );
  }
}
