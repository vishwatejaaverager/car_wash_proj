import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class FrequencyTabs extends StatelessWidget {
  final TabController controller;
  final List tags;
  final List<Widget> tabs;
  const FrequencyTabs(
      {super.key,
      required this.controller,
      required this.tags,
      required this.tabs});

  @override
  Widget build(BuildContext context) {
    return Container(
        //margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.all(2),
        height: 50,
        width: size.width,
        // decoration: BoxDecoration(
        //     color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: TabBar(
              controller: controller,
              // indicator: BoxDecoration(
              //     color: Colors.red.withOpacity(0.8),
              //     borderRadius: BorderRadius.circular(12),
              //     border: Border.all(color: Colors.redAccent.withOpacity(0.5))),
              isScrollable: true,
              indicatorWeight: 3.5,
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Colors.black,
              tabs: tabs),
        ));
  }
}
