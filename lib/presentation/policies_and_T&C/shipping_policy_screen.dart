import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cashew_cart/presentation/policies_and_T&C/widgets/heading.dart';
import 'package:cashew_cart/presentation/policies_and_T&C/widgets/paragraph.dart';
import 'package:cashew_cart/presentation/widgets/custom_appbar.dart';

class ShippingPolicyScreen extends StatelessWidget {
  const ShippingPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Shipping Policy",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              Paragraph(paragraph: "All custom products ship within 2-3 weeks of receiving the final design agreement or verbal agreement."),
              Heading(
                heading: "Damages to items resulting from shipping",
                underline: false,
              ),
              Paragraph(
                  paragraph:
                      "Any damage to items in transit will be the sole responsibility of the shipping/forwarding company (carrier) and customer and NOT the responsibility of The Kerala Cashew Development Corporation Limited."),
            ],
          ),
        ),
      ),
    );
  }
}
