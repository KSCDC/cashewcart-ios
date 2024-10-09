import 'package:flutter/material.dart';
import 'package:cashew_cart/core/colors.dart';
import 'package:cashew_cart/presentation/widgets/custom_text_widget.dart';
import 'package:timeline_tile/timeline_tile.dart';

class CustomTimelineTile extends StatelessWidget {
  const CustomTimelineTile({
    super.key,
    this.isFirst = false,
    this.isLast = false,
    this.isCompleted = false,
    required this.cardTitle,
    required this.dateAndTime,
  });
  final bool isFirst;
  final bool isLast;
  final bool isCompleted;
  final String cardTitle;
  final String dateAndTime;

  final Color dullColor = const Color.fromARGB(255, 255, 205, 214);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,
        beforeLineStyle: LineStyle(
          color: isCompleted ? kMainThemeColor : dullColor,
        ),
        indicatorStyle: IndicatorStyle(
          width: 30,
          color: isCompleted ? kMainThemeColor : dullColor,
          iconStyle: IconStyle(
            iconData: Icons.done,
            color: isCompleted ? Colors.white : dullColor,
            fontSize: 25,
          ),
        ),
        endChild: Container(
          margin: EdgeInsets.only(left: 10),
          padding: EdgeInsets.all(10),
          height: 70,
          decoration: BoxDecoration(
            color: isCompleted ? kMainThemeColor : dullColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextWidget(
                text: cardTitle,
                fontSize: 16,
                fontColor: isCompleted ? Colors.white : Colors.grey,
                fontweight: FontWeight.w600,
              ),
              CustomTextWidget(
                text: dateAndTime,
                fontColor: isCompleted ? Colors.white : Colors.grey,
                fontSize: 14,
              )
            ],
          ),
        ),
      ),
    );
  }
}
