import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/constants.dart';
import '../../../../utils/utils.dart';
import '../../../providers/home_provider.dart';

class ServiceTiles extends StatelessWidget {
  final List services;
  const ServiceTiles({
    super.key,
    required this.services,
  });

  @override
  Widget build(BuildContext context) {
    List servicesName = [
      "Carwash",
      "Interior Cleaning",
      "Carwash & Interior",
      "Deep Interior Cleaning",
    ];
    List serviceImage = [
      Constants.carWash,
      Constants.interior,
      Constants.intWash,
      Constants.deepInt,
    ];
    return Consumer(
      builder: (context, ref, child) {
        //  log("built tiles");
        final homePros = ref.watch(homeProv);
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: servicesName.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 32,
                childAspectRatio: 1.6),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  homePros.configServ(index);
                },
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 8, bottom: 0, top: 0, right: 0),
                  decoration: BoxDecoration(
                      color: homePros.selectedServ[index] == ''
                          ? const Color(0xfff4f6fe)
                          : const Color(0xff0269eb),
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        services[index]['serviceName'],
                        style: TextStyle(
                            color: homePros.selectedServ[index] == ''
                                ? Colors.black
                                : Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      sbh(16),
                      Image.asset(
                        serviceImage[index],
                        scale: index == 2 ? 8 : 10,
                        color: homePros.selectedServ[index] == ''
                            ? const Color(0xff0269eb)
                            : Colors.white,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
