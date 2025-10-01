import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:future_builder_app/Core/services/notification_service.dart';

// شاشاتك
import 'Feature/Aboutus/About_us.dart';
import 'Feature/Auth/Change_pass.dart';
import 'Feature/Auth/Login.dart';
import 'Feature/Auth/Signup.dart';
import 'Feature/Auth/Startpage.dart';
import 'Feature/Call_archive/Calls.dart';
import 'Feature/Onboard/Onboarding.dart';
import 'Feature/home/zoomdrawer.dart';

// ده المفتاح اللي هنستخدمه بدل context
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
User? user = FirebaseAuth.instance.currentUser;

late bool islogin;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // تهيئة الاشعارات
  await NotificationService().init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (user == null) {
      islogin = false;
    } else {
      islogin = true;
    }
    return MaterialApp(
      navigatorKey: navigatorKey, // هنا استدعينا المفتاح
      home: islogin == false ? OnboardingPage() : ZoomDrawerScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        'onboarding': (context) => OnboardingPage(),
        'start': (context) => Start(),
        'login': (context) => LogIn(),
        'signup': (context) => SignUp(),
        'resetpassword': (context) => ChangePass(),
        'home': (context) => ZoomDrawerScreen(),
        'calls': (context) => Calls(),
        'aboutus': (context) => AboutUsPage(),
      },
    );
  }
}
