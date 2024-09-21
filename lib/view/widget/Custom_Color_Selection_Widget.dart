// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class CustomColorChoose extends StatelessWidget {
  final List<String> imagePaths;
  final int selectedIndex;
  final Function(int) onImageTap;

  const CustomColorChoose({
    Key? key,
    required this.imagePaths,
    required this.selectedIndex,
    required this.onImageTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double gridWidth = (screenWidth - 60) / 3;
    double aspectRatio = gridWidth / 107;
    int crossAxisCount = 3;

    return Container(
      decoration: BoxDecoration(
        color: Color(0xff1A1F1B),
        borderRadius: BorderRadius.circular(15),
      ),
      child: GridView.count(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        childAspectRatio: aspectRatio,
        children: List.generate(imagePaths.length, (index) {
          // Determine the position of the image in the grid
          bool isLeft = index % crossAxisCount == 0;
          bool isRight = (index + 1) % crossAxisCount == 0;
          bool isTop = index < crossAxisCount;
          bool isBottom = index >= imagePaths.length - crossAxisCount;

          // Set the appropriate border radius for corners and selected image
          BorderRadius borderRadius = BorderRadius.only(
            topLeft: isTop && isLeft ? Radius.circular(15) : Radius.zero,
            topRight: isTop && isRight ? Radius.circular(15) : Radius.zero,
            bottomLeft: isBottom && isLeft ? Radius.circular(15) : Radius.zero,
            bottomRight:
                isBottom && isRight ? Radius.circular(15) : Radius.zero,
          );

          return GestureDetector(
            onTap: () => onImageTap(index),
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(
                  color: selectedIndex == index
                      ? kTertiaryColor
                      : Color(0xff252525),
                  width: selectedIndex == index ? 1 : 0,
                ),
                borderRadius: selectedIndex == index
                    ? BorderRadius.circular(15)
                    : borderRadius,
                color: selectedIndex == index
                    ? kTertiaryColor.withOpacity(0.21)
                    : Color(0xff1A1F1B),
              ),
              child: ClipRRect(
                borderRadius: selectedIndex == index
                    ? BorderRadius.circular(15)
                    : borderRadius,
                child: Image.asset(
                  imagePaths[index],
                  fit: BoxFit.contain,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
