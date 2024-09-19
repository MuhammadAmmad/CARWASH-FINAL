import 'package:car_wash_light/controllers/light_controller.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

//TODO: these are the references to our controller
final tunnel49DatabaseReference = FirebaseDatabase.instance.ref().child('wled');

final LightController light = Get.find<LightController>();
DatabaseReference tunnelBay = FirebaseDatabase.instance
    .ref()
    .child('tunnelBay/${light.tunnelName.value}');
