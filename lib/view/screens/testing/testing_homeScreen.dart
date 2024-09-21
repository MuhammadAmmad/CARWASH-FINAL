import 'package:car_wash_light/view/screens/testing/Fetch_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestingHomeScreen extends StatelessWidget {
  const TestingHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TestingLedController testing = Get.put(TestingLedController());
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    await testing.fetchLedData();
                  },
                  child: const Text("controllers"))
            ],
          ),
        ),
      ),
    );
  }
}
