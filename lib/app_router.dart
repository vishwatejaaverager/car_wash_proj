import 'package:car_wash_proj/bottom_nav/screens/home_screen/screens/home_screen.dart';
import 'package:car_wash_proj/features/auth/screens/login_screen.dart';
import 'package:car_wash_proj/features/auth/screens/otp_screen.dart';
import 'package:car_wash_proj/features/cars/companies/car_company.dart';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'features/cars/models/car_model_screen.dart';

class AppRouter {
  static Route generateRoute(RouteSettings route) {
    const PageTransitionType style = PageTransitionType.fade;

    PageTransition pageTransition(Widget child) {
      return PageTransition(child: child, type: style);
    }

    if (route.name == LoginScreen.id.path) {
      return pageTransition(const LoginScreen());
    } else if (route.name == OtpScreen.id.path) {
      return pageTransition(const OtpScreen());
    } else if (route.name == CarCompanies.id.path) {
      return pageTransition(const CarCompanies());
    } else if (route.name == HomeScreen.id.path) {
      return pageTransition(const HomeScreen());
    } else if (route.name == CarModelScreen.id.path) {
      String id = route.arguments as String;
      return pageTransition(CarModelScreen(id));
    } else {
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('No view defined for this route'),
          ),
        ),
      );
    }
  }
}
