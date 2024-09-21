// ignore_for_file: sized_box_for_whitespace, must_be_immutable

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_styling.dart';

class CommonImageView extends StatefulWidget {
  String? url;
  String? imagePath;
  String? svgPath;
  File? file;
  double? height;
  double? width;
  double? radius;
  final Color? color;
  final BoxFit fit;
  final String placeHolder;

  CommonImageView({
    super.key,
    this.url,
    this.imagePath,
    this.svgPath,
    this.file,
    this.height,
    this.width,
    this.radius = 0.0,
    this.fit = BoxFit.cover,
    this.placeHolder = 'assets/images/no_image_found.png',
    this.color,
  });

  @override
  State<CommonImageView> createState() => _CommonImageViewState();
}

class _CommonImageViewState extends State<CommonImageView> {
  @override
  Widget build(BuildContext context) {
    return _buildImageView();
  }

  Widget _buildImageView() {
    if (widget.svgPath != null && widget.svgPath!.isNotEmpty) {
      return Container(
        height: h(context, widget.height ?? 0),
        width: w(context, widget.width ?? 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(h(context, widget.radius ?? 0)),
          child: SvgPicture.asset(
            widget.svgPath!,
            height: h(context, widget.height ?? 0),
            width: w(context, widget.width ?? 0),
            fit: widget.fit,
          ),
        ),
      );
    } else if (widget.file != null && widget.file!.path.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(h(context, widget.radius ?? 0)),
        child: Image.file(
          widget.file!,
          height: h(context, widget.height ?? 0),
          width: w(context, widget.width ?? 0),
          fit: widget.fit,
        ),
      );
    } else if (widget.url != null && widget.url!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(h(context, widget.radius ?? 0)),
        child: CachedNetworkImage(
          height: h(context, widget.height ?? 0),
          width: w(context, widget.width ?? 0),
          fit: widget.fit,
          imageUrl: widget.url!,
          placeholder: (context, url) => Container(
            height: h(context, 23),
            width: w(context, 23),
            child: Center(
              child: SizedBox(
                height: h(context, 20),
                width: w(context, 20),
                child: CircularProgressIndicator(
                  color: kSecondaryColor,
                  backgroundColor: Colors.grey.shade100,
                ),
              ),
            ),
          ),
          errorWidget: (context, url, error) => Image.asset(
            widget.placeHolder,
            height: h(context, widget.height ?? 0),
            width: w(context, widget.width ?? 0),
            fit: widget.fit,
          ),
        ),
      );
    } else if (widget.imagePath != null && widget.imagePath!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(h(context, widget.radius ?? 0)),
        child: Image.asset(
          color: widget.color,
          widget.imagePath!,
          height: h(context, widget.height ?? 0),
          width: w(context, widget.width ?? 0),
          fit: widget.fit,
        ),
      );
    }
    return const SizedBox();
  }
}
