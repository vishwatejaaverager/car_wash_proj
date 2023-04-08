import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/constants.dart';
import '../../../../utils/utils.dart';
import '../../../providers/home_provider.dart';



class ServiceTiles extends StatelessWidget {
  const ServiceTiles({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        //  log("built tiles");
        final homePros = ref.watch(homeProv);
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 16,
                crossAxisSpacing: 8,
                childAspectRatio: 0.8),
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
                        "Regular Car\nWash",
                        style: TextStyle(
                            color: homePros.selectedServ[index] == ''
                                ? Colors.black
                                : Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                      sbh(16),
                      Image.asset(
                        Constants.carWash,
                        scale: 10,
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
