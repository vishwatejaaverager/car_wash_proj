import 'package:flutter/material.dart';




class CarAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final TextEditingController controller;
  final Function(String v) onChanged;
  final String text;

  const CarAppBar(
      {Key? key,
      this.height = kToolbarHeight,
      required this.controller,
      required this.onChanged,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey.shade200, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 1.0],
        ),
      ),
      child: Stack(
        children: [
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, height),
            painter: _CarPainter(),
          ),
          Positioned(
            top: height * 0.15,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: height * 0.7,
                  width: height * 0.7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade300,
                  ),
                ),
                Container(
                  height: height * 0.7,
                  width: height * 0.7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade300,
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Icon(
                Icons.directions_car,
                size: 32,
                color: Colors.black,
              ),
            ),
          ),
          Positioned(
            top: height * 0.4,
            left: 16,
            right: 16,
            child: Container(
              height: height * 0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: TextField(
                onChanged: onChanged,
                controller: controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  hintText: text,
                  suffixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _CarPainter extends CustomPainter {
  final _paint = Paint()
    ..color = Colors.grey.shade300
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, size.height * 0.7)
      ..quadraticBezierTo(
        size.width * 0.25,
        size.height * 0.55,
        size.width * 0.5,
        size.height * 0.55,
      )
      ..quadraticBezierTo(
        size.width * 0.75,
        size.height * 0.55,
        size.width,
        size.height * 0.7,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
