import 'package:car_wash_light/constants/app_colors.dart';
import 'package:car_wash_light/view/screens/condition/Custom_Color_Selection_Widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:car_wash_light/controllers/light_controller.dart';

class TestingEdit extends StatelessWidget {
  const TestingEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LightController light = Get.find<LightController>();
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Control Lights",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: darkGreen,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [kTertiaryColor.withOpacity(0.1), Colors.white],
          ),
        ),
        child: Obx(() {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            itemCount: light.lightForATunnel.length,
            itemBuilder: (context, index) {
              final currentLight = light.lightForATunnel[index];
              return _buildLightCard(context, currentLight, light);
            },
          );
        }),
      ),
    );
  }

  Widget _buildLightCard(
      BuildContext context, dynamic currentLight, LightController light) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue.withOpacity(0.1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentLight.id,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kTertiaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Tap to control',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              _buildToggleSwitch(currentLight, light),
              const SizedBox(width: 16),
              _buildColorButton(context, currentLight),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleSwitch(dynamic currentLight, LightController light) {
    return Obx(() {
      bool isToggled = light.toggleStates[currentLight.id] ?? false;
      return GestureDetector(
        onTap: () => _handleToggle(currentLight, light),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 36,
          width: 64,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: isToggled ? Colors.green : Colors.grey[300],
            boxShadow: [
              BoxShadow(
                color: isToggled
                    ? Colors.green.withOpacity(0.5)
                    : Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                top: 2,
                left: isToggled ? 30 : 2,
                right: isToggled ? 2 : 30,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildColorButton(BuildContext context, dynamic currentLight) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 24,
        child: IconButton(
          icon: const Icon(Icons.palette, color: kTertiaryColor),
          onPressed: () => _showColorPicker(context, currentLight),
        ),
      ),
    );
  }

  void _handleToggle(dynamic currentLight, LightController light) async {
    light.toggleLight(currentLight.id);
    bool updatedState = light.toggleStates[currentLight.id] ?? false;
    print(
        "Toggle button pressed for ${currentLight.id}. New state: $updatedState");

    final DatabaseReference colorController = FirebaseDatabase.instance.ref().child(
        'con/${light.controllerName.value}/${light.tunnelName.value}/${currentLight.id}');

    String newBrightness = updatedState ? '255' : '00';
    String state = updatedState ? 'on' : 'off';

    await colorController.update({
      'brightness': newBrightness,
      'state': state,
    });
  }

  void _showColorPicker(BuildContext context, dynamic currentLight) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: CustomColorSelection(
            ledId: currentLight.id,
            onClose: () => Navigator.of(context).pop(),
          ),
        );
      },
    );
  }
}
