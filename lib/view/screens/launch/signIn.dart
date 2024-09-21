// ignore_for_file: prefer_const_constructors

import 'package:car_wash_light/constants/app_styling.dart';
import 'package:car_wash_light/controllers/auth_controller.dart';
import 'package:car_wash_light/services/Authservice.dart';
import 'package:car_wash_light/view/screens/home/home.dart';
import 'package:car_wash_light/view/screens/launch/forget_password.dart';
import 'package:car_wash_light/view/widget/toast_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../widget/Custom_Textfield_widget.dart';
import '../../widget/Custom_button_widget.dart';
import '../../widget/Custom_text_widget.dart';
import 'signUp.dart';
import 'welcome_screen.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();

  // Method to handle sign-in functionality
  Future<void> signIn() async {
    final user = await authService.login(
      emailController.text.trim(),
      passwordController.text.trim(),
    );
    if (user != null) {
      showToast("Successfully Signed In!!", Colors.green.shade600);
      Get.offAll(() => WelcomeScreen());
    } else {
      showToast("Incorrect email or password!", Colors.red.shade600);
    }
  }

  @override
  Widget build(BuildContext context) {
    final AuthController auth = Get.find<AuthController>();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: kTertiaryColor,
          image: DecorationImage(
            image: AssetImage(Assets.imagesSigninbg),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: h(context, 390),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(h(context, 50)),
                  bottomRight: Radius.circular(h(context, 50)),
                ),
                color: kSecondaryColor,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(Assets.imagesLogo, height: h(context, 139)),
                    CustomText(
                      text: "CAR WASH",
                      size: 24,
                      color: Color(0xff115E35),
                    ),
                    CustomText(
                      text: "LIGHTS",
                      size: 24,
                      color: Color(0xff115E35),
                    ),
                    CustomText(
                      text: "FORMERLY “MILE HIGH LED SYSTEMS”",
                      size: 12,
                      weight: FontWeight.w700,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: h(context, 46),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: symmetric(
                    context,
                    horizontal: 34,
                  ),
                  child: Column(
                    children: [
                      CustomTextField(
                        hintText: "Email",
                        textEditingController: emailController,
                      ),
                      SizedBox(
                        height: h(context, 15),
                      ),
                      CustomTextField(
                        hintText: "Password",
                        isPassword: true,
                        textEditingController: passwordController,
                      ),
                      Obx(() {
                        return Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              auth.loginMessage.value,
                              style: TextStyle(
                                color: auth.loginColor.value
                                    ? Colors.white
                                    : Colors.red,
                                fontWeight: FontWeight.w900,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        );
                      }),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: CustomText(
                          text: "Forgot Password?",
                          size: 14,
                          color: kSecondaryColor,
                          textAlign: TextAlign.right,
                          paddingTop: 20,
                          paddingBottom: 30,
                          onTap: () {
                            Get.to(() => ForgetPassword(
                                  appBarText: "Forget Password",
                                  bodyText: 'Recover your password',
                                  buttonString: 'Reset',
                                ));
                          },
                        ),
                      ),
                      Obx(() {
                        return CustomButton(
                          buttonText: auth.isLoading.value ? '' : 'Sign in',
                          circularProgressIndicator: auth.isLoading.value
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : null,
                          onTap: () async {
                            if (emailController.text.toString().isEmpty ||
                                passwordController.text.toString().isEmpty) {
                              auth.loginMessage.value =
                                  "Please complete all fields!";
                              auth.loginColor.value = false;
                            } else {
                              auth.loginMessage.value = "In Processing...";
                              auth.loginColor.value = true;
                              auth.changeIsLoading(true);
                              User? user = await auth.login(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              );
                              if (user != null) {
                                showToast('Login successfully!', Colors.green);
                                auth.loginMessage.value =
                                    "Please complete all fields !";
                                auth.loginColor.value = true;
                                Get.offAll(WelcomeScreen());
                              }
                              auth.changeIsLoading(false);
                            }
                          },
                        );
                      }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: "Don’t have an account? ",
                            size: 14,
                            color: kSecondaryColor,
                            textAlign: TextAlign.center,
                            paddingTop: 10,
                            paddingBottom: 15,
                          ),
                          CustomText(
                            text: " Sign Up",
                            size: 14,
                            color: Color(0xff8CD918),
                            textAlign: TextAlign.center,
                            paddingTop: 10,
                            paddingBottom: 15,
                            onTap: () {
                              Get.to(() => SignUp());
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
