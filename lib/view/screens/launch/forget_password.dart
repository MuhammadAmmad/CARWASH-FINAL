import 'package:car_wash_light/constants/app_colors.dart';
import 'package:car_wash_light/controllers/auth_controller.dart';
import 'package:car_wash_light/view/widget/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPassword extends StatelessWidget {
  final String appBarText;
  final String bodyText;
  final String buttonString;

  const ForgetPassword({
    Key? key,
    required this.appBarText,
    required this.bodyText,
    required this.buttonString,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final email = TextEditingController();
    final AuthController auth = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          appBarText,
          style: GoogleFonts.ubuntu(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: darkGreen,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.08),
                Text(
                  bodyText,
                  style: GoogleFonts.ubuntu(
                    color: Colors.grey[800],
                    fontSize: screenHeight * 0.028,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Enter your email address",
                    hintStyle: GoogleFonts.ubuntu(
                      color: Colors.grey[400],
                      fontSize: 16,
                    ),
                    prefixIcon: Icon(Icons.email, color: darkGreen),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: darkGreen, width: 2),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.06),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                    minimumSize: Size(screenWidth, 0),
                  ),
                  child: Text(
                    buttonString,
                    style: GoogleFonts.ubuntu(
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () async {
                    if (email.text.trim().isNotEmpty) {
                      String message =
                          await auth.resetPassword(email.text.trim());
                      showToast(message, Colors.amber.shade300);
                    } else {
                      showToast("Please enter your email", Colors.red);
                    }
                  },
                ),
                SizedBox(height: screenHeight * 0.04),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Back to Login",
                      style: GoogleFonts.ubuntu(
                        color: darkGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
