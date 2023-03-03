import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class sliderimages extends StatelessWidget {
  final bool type;
  final List images;
  const sliderimages({super.key, required this.images, this.type = true});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: type
          ? images.map(
              (e) {
                return Image.file(
                  e,
                  fit: BoxFit.cover,
                  height: 200,
                );
              },
            ).toList()
          : images.map(
              (e) {
                return Image.network(
                  e,
                  fit: BoxFit.cover,
                  height: 200,
                );
              },
            ).toList(),
      options: CarouselOptions(
        viewportFraction: 1,
        height: 200,
      ),
    );
  }
}
