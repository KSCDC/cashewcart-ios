import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internship_sample/presentation/policies_and_T&C/widgets/heading.dart';
import 'package:internship_sample/presentation/policies_and_T&C/widgets/paragraph.dart';
import 'package:internship_sample/presentation/widgets/custom_appbar.dart';
import 'package:internship_sample/presentation/widgets/custom_text_widget.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Terms & Conditions",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Heading(heading: "User Agreement"),
              CustomTextWidget(
                text:
                    "The Terms and Conditions (T&C.S) contained herein along with the Privacy Policy and Terms of Use form an Agreement regulating our relationship with regard to the use of Kerala State Cashew Development Corporation Ltd., “CDC Online Shopping” Platform (Site) by you. Please read this Agreement carefully. This Agreement is effective only upon due agreement / acceptance by you, through the “I Agree” button. You are advised to regularly check for any amendments or updates to the terms and conditions from time to time.",
                fontSize: 12.sp,
                textAlign: TextAlign.justify,
              ),
              Heading(heading: "Definitions"),
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Column(
                  children: [
                    Paragraph(
                      paragraph:
                          "1. “Agreement” means the Terms and Conditions (T&C.S) contained herein along with the Privacy Policy and Terms of Use including other T&C at Kerala State Cashew Development Corporation Ltd., “CDC Online Shopping” Platform (Site).",
                    ),
                    Paragraph(
                        paragraph:
                            "2. Site” means the Kerala State Cashew Development Corporation Ltd., “CDC Online Shopping” Platform (Site) owned and operated by which provides a venue to the users of www.cashewcorporation.com to buy the products listed / displayed at CDC Online Shopping."),
                    Paragraph(
                        paragraph:
                            "3. “Vendor” means Kerala State Cashew Development Corporation Ltd. Or its authorized agents who offers for sale, sells the products through “CDC Online Shopping ” Platform."),
                    Paragraph(
                        paragraph:
                            "4. “User” means and includes any Customer / Buyer who accept the offer for sale of the Vendor / Seller, through “CDC Online Shopping” Platform (Site) by placing an order on the Site."),
                    Paragraph(paragraph: "5. “Product/s” connotes the goods, services promoted / displayed on “CDC Online Shopping” Platform (Site) and offered for any use / sale."),
                  ],
                ),
              ),
              Heading(heading: "Terms and Conditions"),
              Paragraph(
                  paragraph:
                      "The Vendor/www.cashewcorporation.com reserves the right to accept or reject any offer without assigning any reason whatsoever. Products/services and information displayed on www.cashewcorporation.com “CDC Online Shopping” Platform (Site) constitute an “invitation to offer”. Your order for purchase constitutes your “offer” which shall be subject to the terms and conditions as listed below. The agreement between you and www.cashewcorporation.com shall be subject to the following terms and conditions:"),
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Column(
                  children: [
                    Paragraph(
                      paragraph: "The User certifies that he/she is at least 18 (eighteen) years of age.",
                      showBullet: true,
                    ),
                    Paragraph(
                      paragraph:
                          "These terms and conditions supersede all previous representations, understandings, or agreements and shall prevail notwithstanding any variance with any other terms of any order submitted. By using the Shopping services of the Kerala Cashew Development Corporation Ltd you agree to be bound by the Terms and Conditions.",
                      showBullet: true,
                    ),
                    Paragraph(
                      paragraph: "All prices, unless indicated otherwise are in Indian Rupees",
                      showBullet: true,
                    ),
                    Paragraph(
                      paragraph:
                          "The Kerala State Cashew Development Corporation Ltd reserves the right to refuse or cancel any order placed for a product that is listed at an incorrect price. This shall be regardless of whether the order has been confirmed and/or payment levied. In the event the payment has been processed by www.cashewcorporation.com the same shall be credited to your account and duly notified to you by email.",
                      showBullet: true,
                    ),
                    Paragraph(
                      paragraph:
                          "In a credit card transaction, you must use your own credit card. The Kerala State Cashew Development Corporation Ltd. will not be liable for any credit card fraud. The liability to use a card fraudulently will be on the user and the onus to “prove otherwise” shall be exclusively on the user.",
                      showBullet: true,
                    ),
                    Paragraph(
                      paragraph:
                          "In the event that a non-delivery occurs on account of a mistake by you (eg. wrong name or address) any extra cost incurred by the Kerala State Cashew Development Corporation Ltd for redelivery shall be claimed from the User placing the order.",
                      showBullet: true,
                    ),
                    Paragraph(
                      paragraph:
                          "The Kerala State Cashew Development Corporation Ltd shall not be liable for any delay / non-delivery of purchased goods due to flood, fire, wars, acts of God or any cause that is beyond the control of the Kerala State Cashew Development Corporation Ltd.",
                      showBullet: true,
                    ),
                    Paragraph(
                      paragraph:
                          "The User agrees to provide authentic and true information. The Kerala State Cashew Development Corporation Ltd., reserves the right to confirm and validate the information and other details provided by the User at any point of time. If upon confirmation such User details are found not to be true (wholly or partly), Kerala State Cashew Development Corporation Ltd has the right in its sole discretion to reject the registration and debar the User from using the Services of the Kerala State Cashew Development Corporation Ltd, “CDC Online Shopping” Platform (Site) and recover the damages caused.",
                      showBullet: true,
                    ),
                    Paragraph(
                      paragraph:
                          "The Kerala State Cashew Development Corporation Ltd. will not be responsible for any damage suffered by users from use of the services on this site. This without limitation includes loss of revenue/data resulting from delays, non-deliveries, missed deliveries, or service interruptions. This disclaimer of liability also applies to any damages or injury caused by any failure of performance, error, omission, interruption, deletion, defect, delay in operation or transmission, computer virus, communication line failure, theft or destruction or unauthorized access to, alteration of, or use of record, whether for breach of contract, tortuous behavior, negligence, or under any other cause of action.",
                      showBullet: true,
                    ),
                    Paragraph(
                      paragraph:
                          "THE USER EXPRESSLY AGREES THAT THE USE OF THE KERALA CASHEW DEVELOPMENT CORPORATION LTD., ONLINE SHOPPING IS AT THE USER’S SOLE RISK. THE KERALA STATE CASHEW DEVELOPMENT CORPORATION LTD., ONLINE SHOPPING IS PROVIDED ON AN “AS IS” BASIS WITHOUT WARRANTIES OF ANY KIND, WHETHER EXPRESS OR IMPLIED. THE KERALA STATE CASHEW DEVELOPMENT CORPORATION LTD., ITS AFFILIATES, EMPLOYEES, AGENTS, CONSULTANTS, CONTRACTED COMPANIES MAKE NO WARRANTIES OF ANY KIND, WHETHER EXPRESSED OR IMPLIED, FOR THE SERVICE IT IS PROVIDING OR AS TO THE RESULTS THAT MAY BE OBTAINED FROM USE OF THE SERVICE, OR AS TO THE ACCURACY, RELIABILITY OR CONTENT OF ANY INFORMATION, SERVICE, OR MERCHANDISE PROVIDED THROUGH THIS SERVICE. THE KERALA STATE CASHEW DEVELOPMENT CORPORATION LTD. DOES NOT REPRESENT OR WARRANT TO MAINTAIN THE CONFIDENTIALITY OF INFORMATION; ALTHOUGH THE KERALA STATE CASHEW DEVELOPMENT CORPORATION LTD. CURRENT PRACTICE IS TO UTILISE REASONABLE EFFORTS TO MAINTAIN SUCH CONFIDENTIALITY.",
                      showBullet: true,
                    ),
                    Paragraph(
                      paragraph:
                          "This agreement shall be construed in accordance with the applicable laws of India. The Courts at Kollam shall have exclusive jurisdiction in any disputes arising out or pertaining hereto.",
                      showBullet: true,
                    ),
                  ],
                ),
              ),
              Paragraph(
                  paragraph:
                      "Customers using foreign and international cards should note that this online payment gateway accepts payments only in Indian Rupees. Therefore, the amount charged is the Indian Rupee value of the product displayed on the site which is converted into US Dollars or any other foreign currency at the actual prevailing conversion rate while passing on the order to the payment gateway. Similarly for any applicable refunds the full Indian Rupee amount, which has been charged, is refunded which is converted into US Dollars or any other foreign currency at the actual prevailing conversion rate. The difference, if any, in the refund and amount charged is due to the fluctuation of the conversion rate. In some cases where an international credit card has been used, the Credit Card Issuing Company levies a transaction charge for any charge / refund issued. The applicable charge is decided by the issuing bank. The Kerala State Cashew Development Corporation Ltd. is not responsible for any charge levied by the credit card issuing bank for the foreign transaction or charge or tax levied by the credit card Issuing Bank or Gateway provider Slot Online."),
              Paragraph(
                  paragraph:
                      "Effort has been made to display the color of products and goods. However colors may vary according to monitor used by you; the Kerala State Cashew Development Corporation Ltd. cannot guarantee that your monitor’s display of color will be accurate or same as the one uploaded.")
            ],
          ),
        ),
      ),
    );
  }
}
