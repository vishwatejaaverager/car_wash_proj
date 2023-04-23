import 'package:car_wash_proj/bottom_nav/screens/about_screen.dart';
import 'package:car_wash_proj/bottom_nav/screens/orders_screen.dart';
import 'package:car_wash_proj/utils/color.dart';
import 'package:car_wash_proj/utils/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants/constants.dart';
import '../utils/utils.dart';

class CustomNavigation extends ConsumerWidget {
  const CustomNavigation({super.key});

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
                  color: primaryColor,
                ),
              ),
            ),
          ),
          sbh(12),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 48),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigation.instance.navigateTo(
                      OrdersScreen.id.path,
                    );
                  },
                  child: Row(
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
                InkWell(
                  onTap: () {
                    Navigation.instance.navigateTo(ShowerAnimation.id.path);
                  },
                  child: Row(
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
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
