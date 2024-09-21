import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../view/widget/custom_circular_indicator.dart';

void showSuccessSnackbar(
    {required String title, required String msg, int duration = 7}) {
  Get.snackbar(
    title,
    msg,
    duration: Duration(seconds: duration),
    backgroundColor: Colors.green,
    snackPosition: SnackPosition.BOTTOM,
    messageText: Text(
      msg,
      style: const TextStyle(color: Colors.white),
    ),
    titleText: Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    ),
  );
}

void showFailureSnackbar(
    {required String title, required String msg, int duration = 7}) {
  Get.snackbar(
    title,
    msg,
    duration: Duration(seconds: duration),
    backgroundColor: Colors.red,
    snackPosition: SnackPosition.BOTTOM,
    messageText: Text(
      msg,
      style: const TextStyle(color: Colors.white),
    ),
    titleText: Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    ),
  );
  //fetch res data from firebase
}

//please wait dialog box
void showPleaseWaitDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        surfaceTintColor: kGreenColor,
        backgroundColor: kSecondaryColor,
        content: Row(
          children: [
            CustomCircularIndicator(
              indicatorColor: kTertiaryColor,
              containerColor: Colors.transparent,
              //containerColor: kSecondaryColor,
            ),
            SizedBox(width: 10),
            const Text(
              'Please wait...',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    },
  );
}
