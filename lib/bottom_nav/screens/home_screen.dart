import 'dart:developer';

import 'package:car_wash_proj/bottom_nav/navigation_drawer.dart';
import 'package:car_wash_proj/bottom_nav/providers/home_provider.dart';
import 'package:car_wash_proj/bottom_nav/screens/service_det_screen.dart';

import 'package:car_wash_proj/models/service_model.dart';
import 'package:car_wash_proj/utils/routes.dart';
import 'package:car_wash_proj/utils/utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  Widget build(BuildContext context) {
    log("built");
    //final homePro = ref.watch(homeProv);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(),
          backgroundColor: Colors.white,
          elevation: 0,
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
