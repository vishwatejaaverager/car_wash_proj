import 'dart:developer';

import 'package:car_wash_proj/features/cars/models/car_model_screen.dart';
import 'package:car_wash_proj/features/cars/provider/car_provider.dart';
import 'package:car_wash_proj/utils/navigation/navigator.dart';
import 'package:car_wash_proj/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/car_appbar.dart';
import '../components/car_tile.dart';

class CarCompanies extends ConsumerStatefulWidget {
  static const id = AppRoutes.carCompScreen;
  const CarCompanies({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CarCompaniesState();
}

class _CarCompaniesState extends ConsumerState<CarCompanies> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final a = ref.watch(carComp);
    // final c = ref.watch<FutureProvider>(carModels);
    final b = ref.watch(carProvider);
    return SafeArea(
      child: Scaffold(
          appBar: CarAppBar(
            height: 100,
            text: "Search for Company",
            onChanged: (v) {
              log("hit");
              b.getFilteredCarComp(v);
            },
            controller: _controller,
          ),
          // appBar: AppBar(
          //   title: const Text("Select Your Company"),
          // ),
          body: a.when(data: ((data) {
            b.setAllCars(data);
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 5, crossAxisSpacing: 5),
              itemCount:
                  _controller.text.isNotEmpty ? b.filtered.length : data.length,
              itemBuilder: (BuildContext context, int index) {
                if (_controller.text.isNotEmpty && b.filtered.isNotEmpty) {
                  return InkWell(
                      onTap: () {
                        log("message");
                        b.configCompanyName(b.filtered[index]['company_name']);
                        Navigation.instance.navigateTo(CarModelScreen.id.path,
                            args: b.filtered[index]['doc_id']);
                      },
                      child: CarCompModel(
                          image: b.filtered[index]['company_logo']));
                } else if (b.filtered.isEmpty && _controller.text.isNotEmpty) {
                  return const Text("No cars");
                } else {
                  return InkWell(
                      onTap: () {
                        log("message here");
                        b.configCompanyName(data[index]['company_name']);
                        Navigation.instance.navigateTo(CarModelScreen.id.path,
                            args: data[index]['doc_id']);
                      },
                      child: CarCompModel(image: data[index]['company_logo']));
                }
              },
            );
          }), error: ((error, stackTrace) {
            return null;
          }), loading: (() {
            return null;
          }))),
    );
  }
}
