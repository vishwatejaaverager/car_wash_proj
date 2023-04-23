import 'dart:developer';

import 'package:car_wash_proj/bottom_nav/providers/booking_provider.dart';
import 'package:car_wash_proj/features/cars/components/car_appbar.dart';
import 'package:car_wash_proj/models/car_model.dart';
import 'package:car_wash_proj/models/user_model.dart';
import 'package:car_wash_proj/utils/indicator/loader_indicator.dart';
import 'package:car_wash_proj/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/controllers/auth_provider.dart';
import '../components/car_tile.dart';
import '../provider/car_provider.dart';

class CarModelScreen extends ConsumerStatefulWidget {
  static const id = AppRoutes.carModelsScreen;
  final String docid;
  const CarModelScreen(this.docid, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CarModelScreenState();
}

class _CarModelScreenState extends ConsumerState<CarModelScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authRepoProvider);
    final carPro = ref.watch(carProvider);
    //  final a = ref.watch(carComp);
    // final c = ref.watch<FutureProvider>(carModels);
    final b = ref.watch(carProvider);
    return Scaffold(
      appBar: CarAppBar(
        height: 100,
        text: "Search for Model",
        onChanged: (v) {
          log("hit");
          b.getFilteredCarComp(v, isModels: true);
        },
        controller: _controller,
      ),
      body: FutureBuilder(
        initialData: const [],
        future: b.getCarCompaniesModels(widget.docid),
        builder: (context, snapshot) {
          return GridView.builder(
              itemCount: _controller.text.isNotEmpty
                  ? b.filteredModels.length
                  : snapshot.data!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 0),
              itemBuilder: (context, index) {
                if (snapshot.hasData) {
                  if (_controller.text.isNotEmpty &&
                      b.filteredModels.isNotEmpty) {
                    return InkWell(
                        onTap: () {
                          UserModel userModel = UserModel(
                              name: auth.user!.displayName ?? "Name",
                              profile: auth.user!.photoURL ??
                                  "https://firebasestorage.googleapis.com/v0/b/carwash-b17c6.appspot.com/o/car_companies%2Fprofile.png?alt=media&token=e9eda448-92a3-4e1b-9e7b-96bb472bfc3f",
                              phone: auth.user!.phoneNumber!,
                              userId: auth.user!.uid);

                          CarModel carModel = CarModel(
                            carComp: carPro.carComp,
                            carImage: b.filteredModels[index]['car_image'],
                            carName: b.filteredModels[index]['car_name'],
                          );
                          //  Navigation.instance.navigateTo(CarModelScreen.id.path);
                          auth.saveUserToDb(userModel, carModel);
                        },
                        child: CarCompModel(
                          image: b.filteredModels[index]['car_image'],
                          name: b.filteredModels[index]['car_name'],
                        ));
                  } else if (b.filteredModels.isEmpty &&
                      _controller.text.isNotEmpty) {
                    return const Text("No cars");
                  } else {
                    return InkWell(
                        onTap: () {
                          log("message");

                          CarModel carModel = CarModel(
                              carComp: carPro.carComp,
                              carImage: snapshot.data![index]['car_image'],
                              carName: snapshot.data![index]['car_name'],
                              isPrime: true);

                          if (b.isStartSelection) {
                            UserModel userModel = UserModel(
                                name: auth.user!.displayName ?? "Name",
                                profile: auth.user!.photoURL ??
                                    "https://firebasestorage.googleapis.com/v0/b/carwash-b17c6.appspot.com/o/car_companies%2Fprofile.png?alt=media&token=e9eda448-92a3-4e1b-9e7b-96bb472bfc3f",
                                phone: auth.user!.phoneNumber!,
                                userId: auth.user!.uid);
                            auth.saveUserToDb(userModel, carModel);
                          } else {
                            String a = ref.read(bookingProv).userModel!.userId;
                            b.addCarToDb(carModel, a);
                            Loading().witIndicator(
                                context: context, title: 'Adding A Car');
                          }

                          //  Navigation.instance.navigateTo(CarModelScreen.id.path);
                          // auth.saveUserToDb(, carModel)
                        },
                        child: CarCompModel(
                          image: snapshot.data![index]['car_image'],
                          name: snapshot.data![index]['car_name'],
                        ));
                  }
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  return const Text("data");
                }
              });
        },
      ),
    );
  }
}
