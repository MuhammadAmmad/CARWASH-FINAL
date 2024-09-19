import 'package:car_wash_light/controllers/auth_controller.dart';
import 'package:car_wash_light/controllers/light_controller.dart';
import 'package:car_wash_light/controllers/location_controller.dart';
import 'package:car_wash_light/view/screens/testing/Fetch_controllers.dart';
import 'package:get/get.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(LightController());
    Get.put(AuthController());
    Get.put(LocationController());
    Get.put(TestingLedController());
    // Get.put(HomeController());
    // Get.put(ChatController());
    // Get.put(ProfileController());
  }
}

//
// class BottomBarBindings implements Bindings {
//   @override
//   void dependencies() {
//     // TODO: implement dependencies
//     Get.put(SellingController());
//     Get.put(HomeController());
//     Get.put(ChatController());
//     // Get.put(HomeController());
//     // Get.put(ChatController());
//     // Get.put(ProfileController());
//   }
// }
//
//
// class EditProfileBindings implements Bindings {
//   @override
//   void dependencies() {
//     // TODO: implement dependencies
//     Get.put(ProfileController());
//     // Get.put(HomeController());
//     // Get.put(ChatController());
//     // Get.put(ProfileController());
//   }
// }
