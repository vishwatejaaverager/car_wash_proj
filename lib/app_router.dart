import 'package:car_wash_proj/bottom_nav/screens/about_screen.dart';
import 'package:car_wash_proj/bottom_nav/screens/home_screen.dart';
import 'package:car_wash_proj/bottom_nav/screens/location_screen.dart';
import 'package:car_wash_proj/bottom_nav/screens/order_stat_screen.dart';
import 'package:car_wash_proj/bottom_nav/screens/orders_screen.dart';
import 'package:car_wash_proj/bottom_nav/screens/payment_screen.dart';
import 'package:car_wash_proj/bottom_nav/screens/scedule_screen.dart';
import 'package:car_wash_proj/bottom_nav/screens/service_det_screen.dart';
import 'package:car_wash_proj/features/auth/screens/login_screen.dart';
import 'package:car_wash_proj/features/auth/screens/otp_screen.dart';
import 'package:car_wash_proj/features/cars/companies/car_company.dart';
import 'package:car_wash_proj/models/service_model.dart';

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
    } else if (route.name == PaymentScreen.id.path) {
      return pageTransition(const PaymentScreen());
    } else if (route.name == LocationScreen.id.path) {
      return pageTransition(const LocationScreen());
    } else if (route.name == OrdersScreen.id.path) {
      return pageTransition(const OrdersScreen());
    } else if (route.name == ShowerAnimation.id.path) {
      return pageTransition(const ShowerAnimation());
    } else if (route.name == OrderStatusScreen.id.path) {
      String orderId = route.arguments as String;
      return pageTransition(OrderStatusScreen(orderId: orderId));
    } else if (route.name == ScheduleScreen.id.path) {
      ServiceModel serviceModel = route.arguments as ServiceModel;
      return pageTransition(ScheduleScreen(
        serviceModel: serviceModel,
      ));
    } else if (route.name == HomeScreen.id.path) {
      return pageTransition(const HomeScreen());
    } else if (route.name == ServiceDetailScreen.id.path) {
      ServiceModel serviceModel = route.arguments as ServiceModel;
      return pageTransition(ServiceDetailScreen(
        serviceModel: serviceModel,
      ));
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
