import 'package:flutter/material.dart';

class CarCompModel extends StatelessWidget {
  final String image;
  final String? name;
  const CarCompModel({Key? key, required this.image, this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(8),
          elevation: 8,
          child: SizedBox(
            height: 100,
            width: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                image,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
        SizedBox(
        //  width: 100,
          
          child: Text(
            name ?? "",
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
