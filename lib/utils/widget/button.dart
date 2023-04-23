import 'package:flutter/material.dart';

import '../color.dart';
import '../utils.dart';

class Button extends StatelessWidget {
  final String text;
  final double? height, width;
  final Function() onTap;
  const Button({
    super.key,
    required this.text,
    required this.onTap,
    this.height,
    this.width
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        height:height ?? 40,
        width:width ?? size.width,
        decoration: BoxDecoration(
            color: blackColor, borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: whiteColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
