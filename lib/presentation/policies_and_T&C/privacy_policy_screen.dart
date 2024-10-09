import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cashew_cart/presentation/policies_and_T&C/widgets/heading.dart';
import 'package:cashew_cart/presentation/policies_and_T&C/widgets/paragraph.dart';
import 'package:cashew_cart/presentation/widgets/custom_appbar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Privacy Policy",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Paragraph(
                  paragraph: "We understand that privacy is important to you, and we promise to look after your personal information. We will not sell any information about you to any other party."),
              Heading(
                heading: "What information do we collect from you?",
                underline: false,
              ),
              Paragraph(
                  paragraph:
                      "We will only have information about you if you willingly provide it. The information you provide is referred to as personal information. Please make sure you update your personal information if any of your details change."),
              Paragraph(paragraph: "In order to do any of the following, you will need to provide us with certain details:"),
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Column(
                  children: [
                    Paragraph(
                      paragraph: "Place an order",
                      showBullet: true,
                    ),
                    Paragraph(
                      paragraph: "Sign up for e-newsletters, if any",
                      showBullet: true,
                    ),
                    Paragraph(
                      paragraph: "Enter competitions, if any",
                      showBullet: true,
                    ),
                    Paragraph(
                      paragraph: "Give feedback to us",
                      showBullet: true,
                    ),
                  ],
                ),
              ),
              Paragraph(paragraph: "The details you provide may include your name, email address, delivery address and telephone number"),
              Heading(
                heading: "How will we use it?",
                underline: false,
              ),
              Paragraph(paragraph: "We will use this information to fulfill any order and to communicate with you when necessary Slot Gacor."),
              Paragraph(
                  paragraph:
                      "We may also use your personal information to contact you about news and offers that we think may interest you, or to tell you if we change anything important about how the website works, or the terms of use of the website."),
              Paragraph(
                  paragraph:
                      "If you decide at any point that you no longer wish to receive messages of this nature, please contact us and send an email to let us know. Alternatively, click to unsubscribe at the bottom of any of the emails you receive."),
              Heading(
                heading: "Will we share your personal information with anyone else?",
                underline: false,
              ),
              Paragraph(paragraph: "We will never release your personal details to any outside company for mailing or marketing purposes."),
              Paragraph(
                  paragraph:
                      "Payments on the website are processed by a third party, which adheres to the privacy policy that is set out here. We have a non-disclosure agreement with this third party, and they are certified by all the major card issuers to hold details securely."),
              Heading(
                heading: "How long will we keep your information?",
                underline: false,
              ),
              Paragraph(
                  paragraph:
                      "We will only keep your personal information for as long as necessary and consistent with the purpose for which you have given it to us. Except where needed to respond to a query from you or fulfill an order, we will delete your personal information on request by you."),
            ],
          ),
        ),
      ),
    );
  }
}
