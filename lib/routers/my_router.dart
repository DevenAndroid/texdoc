import 'package:get/get.dart';
import 'package:texdoc/screens/Doctor%20Screens/add_medical_degrees_screen.dart';
import 'package:texdoc/screens/Doctor%20Screens/complete_profile.dart';
import 'package:texdoc/screens/Doctor%20Screens/create_health-tip_screen.dart';
import 'package:texdoc/screens/Doctor%20Screens/edit_specialist_screen.dart';
import 'package:texdoc/screens/Doctor%20Screens/set_time_screen.dart';
import 'package:texdoc/screens/Doctor%20Screens/bottom_navbar_custom.dart';
import 'package:texdoc/screens/chat_details_screen.dart';
import 'package:texdoc/screens/create_password.dart';
import 'package:texdoc/screens/forgot_password.dart';
import 'package:texdoc/screens/login.dart';
import 'package:texdoc/screens/chat_screen.dart';
import 'package:texdoc/screens/my_profile_screen.dart';
import 'package:texdoc/screens/notification_screen.dart';
import 'package:texdoc/screens/onboarding_screen.dart';
import 'package:texdoc/screens/package_and_payment.dart';
import 'package:texdoc/screens/plan_successfull_screen.dart';
import 'package:texdoc/screens/signup.dart';
import 'package:texdoc/screens/splash_screen.dart';
import 'package:texdoc/screens/verify_your_number_screen.dart';
class MyRouter {
  static var splashScreen = "/splashScreen";
  static var onBoardingScreen = "/onBoardingScreen";
  static var bottomNavBarCustom = "/bottomNavBarCustom";
  static var loginScreen = "/loginScreen";
  static var signUpScreen = "/signUpScreen";
  static var homeScreen = "/homeScreen";
  static var myProfileScreen = "/myProfileScreen";
  static var completeProfileScreen = "/completeProfileScreen";
  static var doctorsScreen = "/doctorsScreen";
  static var drProfileScreen = "/drProfileScreen";
  static var allCategoriesScreen = "/allCategoriesScreen";
  static var createPasswordScreen = "/createPasswordScreen";
  static var forgotPasswordScreen = "/forgotPasswordScreen";
  static var chatScreen = "/chatScreen";
  static var chatDetailScreen = "/chatDetailScreen";
  static var notificationScreen = "/notificationScreen";
  static var notificationDetail = "/notificationDetail";
  static var planSuccessFullScreen = "/planSuccessFullScreen";
  static var verifyYourNumberScreen = "/verifyYourNumberScreen";
  static var packageAndPaymentScreen = "/packageAndPaymentScreen";


  // doctor app Screens
  static var editSpecialistScreen = "/editSpecialistScreen";
  static var addMedicalDegreesScreen = "/addMedicalDegreesScreen";
  static var createHealthTipScreen = "/createHealthTipScreen";
  static var setTimeScreen = "/setTimeScreen";



  static var route = [
    GetPage(name: '/', page: () => const SplashScreen()),
    GetPage(name: MyRouter.onBoardingScreen, page: () => const OnBoardongScreen()),
    GetPage(name: MyRouter.bottomNavBarCustom, page: () => BottomNavBarCustom(1)),
    GetPage(name: MyRouter.loginScreen, page: () => const LoginScreen()),
    GetPage(name: MyRouter.forgotPasswordScreen, page: () => const ForgotPasswordScreen()),
    GetPage(name: MyRouter.signUpScreen, page: () => const SignUpScreen()),
    GetPage(name: MyRouter.myProfileScreen, page: () => const MyProfileScreen()),
    GetPage(name: MyRouter.completeProfileScreen, page: () => const CompleteProfileScreen()),
    // GetPage(name: MyRouter.drProfileScreen, page: () => DrProfileScreen()),
    GetPage(name: MyRouter.createPasswordScreen, page: () => const CreatePasswordScreen()),
    GetPage(name: MyRouter.chatScreen, page: () => const ChatScreen()),
    // GetPage(name: MyRouter.chatDetailScreen, page: () => ChatDetailScreen()),
    // GetPage(name: MyRouter.notificationDetail, page: () => const NotificationDetail()),
     GetPage(name: MyRouter.notificationScreen, page: () => const NotificationScreen()),
     GetPage(name: MyRouter.planSuccessFullScreen, page: () => const PlanSuccessFullScreen()),
     GetPage(name: MyRouter.verifyYourNumberScreen, page: () => const VerifyYourNumberScreen()),
     GetPage(name: MyRouter.packageAndPaymentScreen, page: () => const PackageAndPaymentScreen()),


  // doctor app Screens
  //   GetPage(name: MyRouter.editSpecialistScreen, page: () => const EditSpecialistScreen()),
    GetPage(name: MyRouter.addMedicalDegreesScreen, page: () => const AddMedicalDegreesScreen()),
    GetPage(name: MyRouter.createHealthTipScreen, page: () => const CreateHealthTipScreen()),
    GetPage(name: MyRouter.setTimeScreen, page: () => const SetTimeScreen()),

  ];
}
