import 'package:cloud_firestore/cloud_firestore.dart';

class Streams {
  static const cars = "cars";
  static const cust = "customers";
  static const custCars = "custCars";
  static const services = 'services';

  final carsQuery = FirebaseFirestore.instance.collection(cars);
  final userQuery = FirebaseFirestore.instance.collection(cust);
  final serviceQuery = FirebaseFirestore.instance.collection(services);
}
