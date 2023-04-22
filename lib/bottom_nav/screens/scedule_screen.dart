import 'dart:developer';

import 'package:car_wash_proj/bottom_nav/navigation_drawer.dart';
import 'package:car_wash_proj/bottom_nav/providers/booking_provider.dart';
import 'package:car_wash_proj/bottom_nav/providers/slots_provider.dart';
import 'package:car_wash_proj/bottom_nav/screens/location_screen.dart';
import 'package:car_wash_proj/core/constants/constants.dart';
import 'package:car_wash_proj/models/service_model.dart';
import 'package:car_wash_proj/utils/color.dart';
import 'package:car_wash_proj/utils/navigation/navigator.dart';
import 'package:car_wash_proj/utils/routes.dart';
import 'package:car_wash_proj/utils/utils.dart';
import 'package:car_wash_proj/utils/widget/button.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horizontal_center_date_picker/datepicker_controller.dart';
import 'package:horizontal_center_date_picker/horizontal_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class ScheduleScreen extends ConsumerStatefulWidget {
  final ServiceModel serviceModel;
  static const id = AppRoutes.scheduleScreen;
  const ScheduleScreen({super.key, required this.serviceModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends ConsumerState<ScheduleScreen> {
  final DatePickerController _datePickerController = DatePickerController();

  @override
  void initState() {
    configDate();
    super.initState();
  }

  configDate() {
    ref.read(slotProvider).getFiltered(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(),
        backgroundColor: Colors.white,
        elevation: 0,
        // title: const Text("Home"),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8),
        child: Button(
          text: "Choose Location",
          onTap: () async {
            //log("message");
            try {
              await Permission.location.request().then((value) {
                if (value == PermissionStatus.granted) {
                  Navigation.instance.navigateTo(LocationScreen.id.path);
                } else if (value == PermissionStatus.permanentlyDenied) {
                  appToast(
                      "You have permenantly denied give permssion from settings");
                } else if (value == PermissionStatus.denied) {
                  appToast("Please do grant location service");
                }
              });
            } catch (e) {
              log(e.toString());
            }
          },
        ),
      ),
      drawer: const CustomNavigation(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Transform.rotate(
              angle: -math.pi,
              child: InkWell(
                onTap: () {
                  Navigation.instance.pushBack();
                },
                child: Image.asset(
                  Constants.arow,
                  scale: 15,
                  color: primaryColor,
                ),
              ),
            ),
            minLeadingWidth: 0,
            minVerticalPadding: 0,
            horizontalTitleGap: 2,
            title: Text(
              widget.serviceModel.serviceName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "Service Time :${widget.serviceModel.serviceTime}",
              style: const TextStyle(fontSize: 12),
            ),
            trailing: Text(
              "Rs${widget.serviceModel.servicePrice}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              thickness: 2,
            ),
          ),
          sbh(16),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Schedule Pickup",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          sbh(16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Date",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(16),
            color: Colors.grey,
            alignment: Alignment.center,
            child: HorizontalDatePickerWidget(
              disabledColor: primaryColor.withOpacity(0.1),
              normalColor: primaryColor.withOpacity(0.1),
              selectedColor: primaryColor,
              // locale: 'ja_JP',
              startDate: DateTime.now(),
              endDate: DateTime.now().add(const Duration(days: 30)),
              selectedDate: DateTime.now(),
              widgetWidth: MediaQuery.of(context).size.width,
              datePickerController: _datePickerController,
              onValueSelected: (date) {
                ref.read(slotProvider).getFiltered(date);
                ref
                    .read(bookingProv)
                    .configDate(DateFormat(DateFormat.MONTH_DAY).format(date));
                // log('selected = ${date.toIso8601String()}');
              },
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              final prov = ref.watch(slotProvider);
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: prov.timings.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 32,
                              childAspectRatio: 2),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            prov.selectSlot(index, ref);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: prov.timings[index]['selected'] &&
                                        prov.timings[index]['active']
                                    ? primaryColor
                                    : primaryColor.withOpacity(0.1)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  prov.timings[index]['time'].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: prov.timings[index]['active'] &&
                                              !prov.timings[index]['selected']
                                          ? Colors.black
                                          : prov.timings[index]['selected']
                                              ? whiteColor
                                              : Colors.grey),
                                ),
                                Text(
                                  prov.timings[index]['zone'].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: prov.timings[index]['active'] &&
                                              !prov.timings[index]['selected']
                                          ? Colors.black
                                          : prov.timings[index]['selected']
                                              ? whiteColor
                                              : Colors.grey),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  //  const Spacer(),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
