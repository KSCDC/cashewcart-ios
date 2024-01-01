import 'package:flutter/material.dart';
import 'package:internship_sample/presentation/kart/widgets/kart_product_details_tile.dart';
import 'package:internship_sample/presentation/widgets/custom_appbar.dart';
import 'package:internship_sample/presentation/widgets/sliding_product_tile.dart';

class KartScreen extends StatelessWidget {
  const KartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actionWidget: GestureDetector(
          child: CircleAvatar(
            backgroundColor: Color(0xFFF2F2F2),
            child: Icon(
              Icons.shopping_cart_outlined,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SlidingProductTile(
              imagePath: "lib/core/assets/images/product_images/kart/shoe1.jpg",
              count: 5,
            ),
            KartProductDetailsTile(),
          ],
        ),
      ),
    );
  }
}
