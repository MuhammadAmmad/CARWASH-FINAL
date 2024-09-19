import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_styling.dart';

class CustomDivider extends StatelessWidget {
  final Color color;

  const CustomDivider({
    Key? key,
    this.color = klightGreyColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color,
      thickness: h(context, 1),
    );
  }
}
