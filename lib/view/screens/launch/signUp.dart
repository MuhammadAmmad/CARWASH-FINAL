import 'package:car_wash_light/controllers/auth_controller.dart';
import 'package:car_wash_light/services/Authservice.dart';
import 'package:car_wash_light/view/widget/toast_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../widget/Custom_Textfield_widget.dart';
import '../../widget/Custom_button_widget.dart';
import 'signIn.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final AuthService authService = AuthService();

  //ADDING THE METHOD OF SIGNUP
  void signUp() async {
    User? user = await authService.signUpWithEmailPassword(
        email.text.trim(), password.text.trim());

    if (user != null) {
      showToast('SignUp successfully!', Colors.green.shade600);
      Get.offAll(() => SignIn());
    } else {
      showToast('SignUp failed!', Colors.red.shade600);
    }
  }

  @override
  Widget build(BuildContext context) {
    final AuthController auth = Get.find<AuthController>();
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Register",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: kTertiaryColor,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 35,
          vertical: 35,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image(
                image: const AssetImage('assets/images/logo1.png'),
                height: screenHeight * 0.3,
              ),
            ),
            CustomTextField(
              hintText: "Username",
              textEditingController: username,
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            CustomTextField(
              hintText: "Email",
              textEditingController: email,
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            CustomTextField(
              hintText: "Password",
              textEditingController: password,
            ),
            Obx(() {
              return Container(
                margin: EdgeInsets.only(
                    top: screenHeight * 0.02, bottom: screenHeight * 0.02),
                child: Text(
                  auth.message.value,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        auth.colorController.value ? Colors.green : Colors.red,
                  ),
                ),
              );
            }),
            Obx(() {
              return CustomButton(
                buttonText: auth.regLoading.value ? 'Signing Up...' : 'Sign Up',
                textColor: kSecondaryColor,
                backgroundColor: kTertiaryColor,
                onTap: () async {
                  if (username.text.toString().isEmpty ||
                      password.text.toString().isEmpty ||
                      email.text.toString().isEmpty) {
                    auth.message.value = 'Please complete all fields';
                    auth.colorController.value = false;
                  } else {
                    auth.changeRegLoading(true);
                    User? user = await auth.signUpWithEmailPassword(
                      email.text.trim(),
                      password.text.trim(),
                      username.text.trim(),
                    );
                    if (user != null) {
                      auth.message.value = "All fields are mandatory!";
                      auth.colorController.value = true;
                      showToast("Signup successfully!", Colors.green);
                      Get.off(const SignIn());
                    } else {
                      showToast('Registration Failed!', Colors.red);
                    }
                    auth.changeRegLoading(false);
                  }
                },
              );
            })
          ],
        ),
      ),
    );
  }
}
