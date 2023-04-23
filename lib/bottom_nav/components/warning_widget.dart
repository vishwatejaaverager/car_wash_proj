import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';




class WarningWidget extends StatelessWidget {
  final String tex;
  const WarningWidget({super.key, required this.tex});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Image.asset(
          Constants.emptyImage,
          scale: 1.4,
        )),
        Text(
          tex,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
