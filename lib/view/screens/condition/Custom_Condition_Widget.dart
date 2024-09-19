import 'package:car_wash_light/constants/app_styling.dart';
import 'package:flutter/material.dart';
import '../../../constants/app_images.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/common_image_view_widget.dart';

class CustomCondition extends StatelessWidget {
  final String condition;
  final String description;
  final VoidCallback onEditTap;

  const CustomCondition({
    required this.condition,
    required this.description,
    required this.onEditTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: h(context, 15),
              ),
              CustomText(
                text: condition,
                textAlign: TextAlign.center,
                size: 14.5,
              ),
            ],
          ),
        ),
        SizedBox(
          width: w(context, 15),
        ),
        Expanded(
          child: Column(
            children: [
              SizedBox(
                height: h(context, 15),
              ),
              CustomText(
                text: description,
                size: description == 'Motion Sensor' ? 13 : 14.5,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        SizedBox(
          width: w(context, 15),
        ),
        Expanded(
          child: Column(
            children: [
              SizedBox(
                height: h(context, 15),
              ),
              CustomText(
                text: "Edit Name",
                size: 14.5,
              ),
            ],
          ),
        ),
        SizedBox(
          width: w(context, 15),
        ),
        Column(
          children: [
            SizedBox(
              height: h(context, 15),
            ),
            GestureDetector(
              onTap: onEditTap,
              child: CommonImageView(
                imagePath: Assets.imagesEdit,
                height: 20,
                width: 20,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
