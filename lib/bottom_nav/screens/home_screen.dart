import 'dart:developer';

import 'package:car_wash_proj/bottom_nav/navigation_drawer.dart';
import 'package:car_wash_proj/bottom_nav/providers/booking_provider.dart';
import 'package:car_wash_proj/bottom_nav/providers/home_provider.dart';
import 'package:car_wash_proj/bottom_nav/screens/service_det_screen.dart';
import 'package:car_wash_proj/features/cars/companies/car_company.dart';
import 'package:car_wash_proj/features/cars/provider/car_provider.dart';
import 'package:car_wash_proj/models/car_model.dart';

import 'package:car_wash_proj/models/service_model.dart';
import 'package:car_wash_proj/utils/color.dart';
import 'package:car_wash_proj/utils/indicator/loader_indicator.dart';
import 'package:car_wash_proj/utils/routes.dart';
import 'package:car_wash_proj/utils/utils.dart';
import 'package:car_wash_proj/utils/widget/cache_image.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../utils/navigation/navigator.dart';
import '../../utils/widget/button.dart';
import '../components/service_tile.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const id = AppRoutes.homeScreen;
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int activeIndex = 0;
  final List images = [
    "https://d168jcr2cillca.cloudfront.net/uploadimages/coupons/10810-SpeedCarWash_Banner.jpg",
    "https://d168jcr2cillca.cloudfront.net/uploadimages/coupons/10810-SpeedCarWash_Banner.jpg",
    "https://d168jcr2cillca.cloudfront.net/uploadimages/coupons/10810-SpeedCarWash_Banner.jpg",
    "https://d168jcr2cillca.cloudfront.net/uploadimages/coupons/10810-SpeedCarWash_Banner.jpg"
  ];

  @override
  void initState() {
    ref
        .read(carProvider)
        .configCarModel(ref.read(bookingProv).userModel!.userId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Logger().i("built");
    //final homePro = ref.watch(homeProv);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            Consumer(
              builder: (context, ref, child) {
                ref.read(carProvider).configStartCarSelection(false);
                final carPro = ref.watch(carProvider);
                final car = carPro.selectedCar;
                final cars = carPro.custCars;
                return InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12))),
                      builder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomerCars(cars: cars),
                            InkWell(
                              onTap: () {
                                Navigation.instance
                                    .navigateTo(CarCompanies.id.path);
                              },
                              child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    'Add Vehicle',
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )),
                            )
                          ],
                        );
                      },
                    );
                  },
                  child: carPro.loadingCar
                      ? const SizedBox()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32))),
                            elevation: 10,
                            child: CacheImage(
                              image: car!.carImage!,
                              height: 60,
                              width: 60,
                            ),
                          ),
                        ),
                );
              },
            )
          ],
          // title: const Text("Home"),
        ),
        drawer: const CustomNavigation(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tex
            // sbh(12),
            const Padding(
              padding: EdgeInsets.only(left: 24.0, bottom: 0),
              child: Text(
                "Good Morning",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),

            CarouselSlider(
                items: List.generate(images.length, (index) {
                  return Image.network(images[index]);
                }),
                options: CarouselOptions(
                  height: 250,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  onPageChanged: (a, b) {
                    ref.read(homeProv).configActiveImage(a);
                  },
                  scrollDirection: Axis.horizontal,
                )),

            Consumer(
              builder: (context, ref, child) {
                //    log("built simple indicator");
                final homePros = ref.watch(homeProv);
                return Center(
                  child: AnimatedSmoothIndicator(
                    effect: const ExpandingDotsEffect(
                        expansionFactor: 3,
                        dotHeight: 6,
                        activeDotColor: Colors.blueGrey),
                    activeIndex: homePros.activeImage,
                    count: images.length,
                    curve: Curves.linear,
                  ),
                );
              },
            ),
            sbh(12),
            Consumer(builder: (context, ref, child) {
              return ref.watch(services).when(data: (data) {
                ref.read(homeProv).configServices(data);
                List services = data;
                return ServiceTiles(
                  services: services,
                );
              }, error: (error, stackTrace) {
                return const Text("Error");
              }, loading: () {
                return const CircularProgressIndicator();
              });
            }),

            Consumer(
              builder: (context, ref, child) {
                final home = ref.watch(homeProv);
                return Visibility(
                  visible: ref.watch(homeProv).selectedServ.contains('0'),
                  child: Button(
                    text: "Proceed",
                    onTap: () {
                      ref.read(homeProv).configActiveImage(0);
                      log(ref.read(homeProv).loadedServices.length.toString());

                      ServiceModel serviceModel = ServiceModel.fromMap(
                          home.loadedServices[home.selectedTile].data());
                      ref.read(bookingProv).configServiceModel(serviceModel);
                      Navigation.instance.navigateTo(
                          ServiceDetailScreen.id.path,
                          args: serviceModel);
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class CustomerCars extends ConsumerWidget {
  const CustomerCars({
    super.key,
    required this.cars,
  });

  final List<QueryDocumentSnapshot<Map<String, dynamic>>> cars;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: cars.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        CarModel carModel = CarModel.fromMap(cars[index].data());
        return ListTile(
            leading: Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32))),
              elevation: 10,
              child: CacheImage(
                image: carModel.carImage!,
                height: 60,
                width: 60,
              ),
            ),
            title: Text(
              carModel.carName!.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              carModel.carComp!.toUpperCase(),
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            trailing: carModel.isPrime!
                ? Icon(
                    CarbonIcons.pin,
                    color: primaryColor,
                  )
                : Button(
                    text: 'Select',
                    onTap: () {
                      String a = ref.read(bookingProv).userModel!.userId;
                      Loading().witIndicator(
                          context: context, title: 'Pining Vehicle');
                      log(cars[index].id);
                       ref.read(carProvider).pinCar(a, cars[index].id);
                    },
                    width: 80,
                    height: 30,
                  ));
      },
    );
  }
}
