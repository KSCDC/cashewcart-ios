import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_sample/presentation/policies_and_T&C/widgets/heading.dart';
import 'package:internship_sample/presentation/policies_and_T&C/widgets/paragraph.dart';
import 'package:internship_sample/presentation/widgets/custom_appbar.dart';

class CancellationPolicyScreen extends StatelessWidget {
  const CancellationPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Cancellation & Refund Policy",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Heading(heading: "Cancellation Policy"),
              Paragraph(
                  paragraph:
                      "All cancellation requests must be submitted to the accounts and billing department of The Kerala Cashew Development Corporation Limited (www.cashewcorporation.com). You may submit your cancellation requests by email, fax and/or direct mail or phone before the products shipped. Your request will not be considered valid unless and until you receive confirmation from our accounts or billing department. The confirmation email or number given by accounts department of The Kerala Cashew Development Corporation Limited (www.cashewcorporation.com) will act as a proof of the cancellation of the order. All cancellations will reduce 20% service charge from the actual order value."),
              Heading(heading: "Refund Policy"),
              Paragraph(paragraph: "We believe in helping its customers as far as possible, and have therefore a liberal cancellation and refund policy."),
              Paragraph(
                  paragraph:
                      "If you are, for any reason, not interested with your purchase, we will issue a refund, subject to deduction according to the services provided. To request a refund, simply contact us with your purchase details. Please include your order number (sent to you via email after ordering) and optionally tell us why you’re requesting a refund – we take customer feedback very seriously and use it to constantly improve our products and quality of service. Refunds are being processed within 30 days period."),
              Paragraph(
                  paragraph:
                      "The refund will be made through bank transfer or through your credit card, depending on the original method of purchase. Additionally, although Kerala Cashew Development Corporation Limited will instruct the bank to handle the crediting process immediately upon notification of cancellation, it could take from 4 to 6 weeks for the actual crediting to take place, depending on your Bank’s practice."),
              Paragraph(
                  paragraph:
                      "In case you feel that the product received is not the same mentioned on the site or as per your expectations, you must bring it to the notice of our customer service within 24 hours of receiving the product. The Customer Service Team after looking into your complaint will take an appropriate decision."),
              Heading(heading: "Modification"),
              Paragraph(paragraph: "The Kerala Cashew Development Corporation Limited reserves the right to modify any provisions of the cancellation or refund policy whatsoever without any notice."),
            ],
          ),
        ),
      ),
    );
  }
}
