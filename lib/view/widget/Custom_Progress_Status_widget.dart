// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'Custom_text_widget.dart';

class CustomProgressStatus extends StatelessWidget {
  double progressValue;

  CustomProgressStatus({
    super.key,
    required this.progressValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      margin: EdgeInsets.all(
        10,
      ),
      color: kPrimaryColor,
      child: Column(
        children: [
          SizedBox(
            width: 116,
            height: 116,
            child: Stack(
              alignment: Alignment.center,
              children: [
                FittedBox(
                  child: Column(
                    children: [
                      CustomText(
                        text: "Average",
                        size: 12,
                        color: Color(0xffC0C7D9),
                        weight: FontWeight.w600,
                      ),
                      CustomText(
                        text: '${(progressValue * 100).toStringAsFixed(0)}%',
                        size: 20,
                        color: kQuaternaryColor,
                        weight: FontWeight.w500,
                        paddingTop: 5,
                        paddingBottom: 5,
                      ),
                      CustomText(
                        text: "Win",
                        size: 10,
                        color: Color(0xffC0C7D9),
                        weight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 116,
                  height: 116,
                  child: CircularProgressIndicator(
                    value: progressValue,
                    strokeWidth: 8,
                    backgroundColor: kTertiaryColor,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(kQuaternaryColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
