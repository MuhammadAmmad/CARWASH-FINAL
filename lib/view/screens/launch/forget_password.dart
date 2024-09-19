import 'package:car_wash_light/constants/app_colors.dart';
import 'package:car_wash_light/controllers/auth_controller.dart';
import 'package:car_wash_light/services/Authservice.dart';
import 'package:car_wash_light/view/widget/toast_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPassword extends StatelessWidget {
  final String appBarText;
  final String bodyText;
  const ForgetPassword(
      {super.key, required this.appBarText, required this.bodyText});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    TextEditingController email = TextEditingController();
    final AuthService authService = AuthService();

    Future<void> resetPassword() async {
      try {
        await authService.resetPassword(email.text.trim());
        showToast("Password reset email sent! Check your inbox",
            Colors.green.shade600);
      } on FirebaseAuthException catch (e) {
        showToast(e.message.toString(), Colors.red);
      }
    }

    final AuthController auth = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          appBarText,
          style: GoogleFonts.ubuntu(
            color: Colors.white,
            fontWeight: FontWeight.normal,
            letterSpacing: 2,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        backgroundColor: kTertiaryColor,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.2,
            ),
            Text(
              bodyText,
              style: GoogleFonts.ubuntu(
                  color: Colors.grey[600], fontSize: screenHeight * 0.03),
            ),
            //ADDING A TEXTFIELD FOR VALIDATING AN EMAIL ADDRESS

            Container(
              margin: EdgeInsets.only(
                  top: screenHeight * 0.04, left: 40, right: 40),
              child: TextField(
                controller: email,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      width: 5.0,
                      color: Colors.green.shade200,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.green[600],
                  ),
                  hintText: "Enter a valid email address",
                  hintStyle: GoogleFonts.ubuntu(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    letterSpacing: 3.0,
                    color: Colors.grey.shade500, // Adjust text color
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.1,
            ),
            //ADDING THE RECOVER-PASSWORD BUTTON
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green[600]),
                  minimumSize: MaterialStateProperty.all(
                      Size(screenWidth * 0.5, screenHeight * 0.07))),
              child: Text(
                "LOGIN",
                style: GoogleFonts.ubuntu(
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              onPressed: () async {
                String message = await auth.resetPassword(email.text.trim());
                showToast(message, Colors.amber.shade300);
              },
            ),
          ],
        ),
      ),
    );
  }
}
