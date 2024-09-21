// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    this.controller,
    this.validator,
    this.onChanged,
  });
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        validator: validator,
        style: TextStyle(
          fontSize: 14,
          color: kSecondaryColor,
        ),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 15),
          filled: true,
          fillColor: kSecondaryColor.withOpacity(0.10),
          hintText: "Search Here...",
          hintStyle: TextStyle(
            fontSize: 14,
            color: kSecondaryColor.withOpacity(0.56),
          ),
          prefixIcon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(
              //   Assets.imagesSearch,
              //   height: 18,
              //   color: kSecondaryColor,
              // ),
            ],
          ),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
        ),
      ),
    );
  }
}
