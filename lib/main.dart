import 'package:flutter/material.dart';
import 'Aboutus/About_us.dart';
import 'Auth/Change_pass.dart';
import 'Auth/Login.dart';
import 'Auth/Signup.dart';
import 'Auth/Startpage.dart';
import 'Call_archive/Calls.dart';
import 'Onboard/Onboarding.dart';
import 'home/zoomdrawer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
            headlineLarge: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xff0f2a63),
            ),
            headlineMedium: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),

            bodyMedium: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.white,
            ),
            bodySmall: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),

      debugShowCheckedModeBanner: false,

      initialRoute: 'login',

      routes: {

        'onboarding'    :(context)=> OnboardingPage(),
        'start'         :(context)=> Start(),
        'login'         :(context)=> LogIn(),
        'signup'        :(context)=> SignUp(),
        'resetpassword' :(context)=> ChangePass(),
        'home'          :(context)=> ZoomDrawerScreen(),
        'calls'         :(context)=> Calls(),
        'aboutus'       :(context)=> AboutUsPage(),

      }
    );
  }
}


