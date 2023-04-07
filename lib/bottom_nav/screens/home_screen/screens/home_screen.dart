import 'package:car_wash_proj/bottom_nav/providers/home_provider.dart';
import 'package:car_wash_proj/core/constants/constants.dart';
import 'package:car_wash_proj/utils/routes.dart';
import 'package:car_wash_proj/utils/utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
    final homePro = ref.watch(homeProv);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(),
          backgroundColor: Colors.white,
          elevation: 0,
          // title: const Text("Home"),
        ),
        drawer: const NavigationDrawer(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tex
            // sbh(12),
            const Padding(
              padding: EdgeInsets.all(16.0),
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
                  height: 200,
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
                    homePro.configActiveImage(a);
                  },
                  scrollDirection: Axis.horizontal,
                )),

            Center(
              child: AnimatedSmoothIndicator(
                effect: const ExpandingDotsEffect(
                    expansionFactor: 3,
                    dotHeight: 6,
                    activeDotColor: Colors.blueGrey),
                activeIndex: homePro.activeImage,
                count: images.length,
                curve: Curves.linear,
              ),
            ),
            sbh(12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Select Type of Car Wash",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}

class NavigationDrawer extends ConsumerWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.only(top: 48, left: 0, right: 0),
      height: double.infinity,
      width: size.width / 1.3,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ListTile(
                leading: CircleAvatar(
                  // radius: 40,
                  child: Image.network(
                      "https://firebasestorage.googleapis.com/v0/b/carwash-b17c6.appspot.com/o/car_companies%2Fprofile.png?alt=media&token=e9eda448-92a3-4e1b-9e7b-96bb472bfc3f"),
                ),
                title: const Text(
                  "Vishwa",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                  "+91 8712066555",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.black),
                ),
                trailing: Image.asset(
                  Constants.arow,
                  scale: 24,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          sbh(12),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 48),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      Constants.clock,
                      scale: 24,
                      color: Colors.grey,
                    ),
                    sbw(24),
                    const Text(
                      "My Requests",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                sbh(24),
                Row(
                  children: [
                    Image.asset(
                      Constants.card,
                      scale: 20,
                      color: Colors.blueGrey,
                    ),
                    sbw(24),
                    const Text(
                      "Payments",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                sbh(24),
                Row(
                  children: [
                    Image.asset(
                      Constants.shield,
                      scale: 20,
                      color: Colors.blueGrey,
                    ),
                    sbw(24),
                    const Text(
                      "Support",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                sbh(24),
                Row(
                  children: [
                    Image.asset(
                      Constants.info,
                      scale: 20,
                      color: Colors.blueGrey,
                    ),
                    sbw(24),
                    const Text(
                      "About",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
