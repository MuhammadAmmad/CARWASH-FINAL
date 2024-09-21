// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styling.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final double? height;
  final bool isPassword;
  final TextEditingController? textEditingController;

  CustomTextField({
    this.hintText = "",
    this.height,
    this.isPassword = false,
    this.textEditingController,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool hasFocus = false;
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? h(context, 48),
      padding: only(
        context,
        left: 20,
        right: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(h(context, 12)),
        border: Border.all(
          color: hasFocus ? kTertiaryColor : kPrimaryColor,
        ),
        color: kSecondaryColor,
      ),
      child: Focus(
        onFocusChange: (bool focus) {
          setState(() {
            hasFocus = focus;
          });
        },
        child: Center(
          child: TextField(
            controller: widget.textEditingController,
            obscureText: widget.isPassword && !isPasswordVisible,
            style: TextStyle(
              color: kPrimaryColor,
            ),
            decoration: InputDecoration(
              contentPadding: only(context, top: 10, bottom: 10),
              hintText: widget.hintText,
              hintStyle: TextStyle(color: kGreyColor),
              border: InputBorder.none,
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
