import 'package:car_wash_light/view/screens/bottombar/bottombar.dart';
import 'package:car_wash_light/view/screens/launch/signIn.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return const Bottombar();
        } else {
          return const SignIn();
        }
      }),
    );
  }
}
