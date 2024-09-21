import 'package:car_wash_light/view/screens/testing/testing_homeScreen.dart';
import 'package:get/get.dart';
import '../../view/screens/launch/splash_screen.dart';

class AppRoutes {
  static final List<GetPage> pages = [
    GetPage(
      name: AppLinks.splash_screen,
      page: () => SplashScreen(),
      //REPLACE ABOVE ROUTE WITH THIS WHEN DONE WITH TESTING: SplashScreen(),
      // TestingHomeScreen(),
    ),
  ];
}

class AppLinks {
  static const splash_screen = '/splash_screen';
}
