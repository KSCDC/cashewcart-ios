import 'package:flutter/material.dart';

class SlidingImageTile extends StatelessWidget {
  const SlidingImageTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: FittedBox(
        child: Image.asset(
          "lib/core/assets/images/other/offer_image1.jpg",
        ),
        fit: BoxFit.fill,
      ),
    );
  }
}
