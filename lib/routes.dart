import 'package:get/route_manager.dart';

import 'package:zwc/screens/app_structure_screen.dart';

import 'package:zwc/screens/auth/login.dart';
import 'package:zwc/screens/splash_screen.dart';

class ZWCRoutes {
  static const toLoginScreen = "/loginScreen",
      toWelcomeScreen = "/welcomeScreen",
      toRegistrationScreen = "/registrationScreen",
      toHomeScreen = "/homeScreen",
      toNewUserProfile = "/newUserProfile",
      toUpdateUserProfile = "/updateUserProfile";

  static final List<GetPage> getPages = [
    GetPage(
      name: "/",
      page: () => SplashScreen(),
    ),
    
    GetPage(
      name: ZWCRoutes.toLoginScreen,
      page: () => const LoginScreen(),
      transition: Transition.rightToLeft,
    ),
   
    
    GetPage(
      name: ZWCRoutes.toHomeScreen,
      page: () => const AppStructureScreen(),
    ),
  ];
}
