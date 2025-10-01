import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import '../Onboard/Onboarding.dart';
import 'Home Page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ZoomDrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      menuScreen: MenuScreen(),
      mainScreen: Home_Page(),
      menuBackgroundColor: Colors.grey.shade300,
      borderRadius: 24.0,
      showShadow: true,
      angle: 0.0,
      slideWidth: MediaQuery.of(context).size.width * 0.50,
      openCurve: Curves.easeInOut,
      closeCurve: Curves.easeInOut,
    );
  }
}

class MenuScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> _signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.green,
            content: Text("Logged out successfully!")),
      );
      // Navigate to login screen or any other screen after logout
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => OnboardingPage()),
        (route) => false, // تحذف جميع الشاشات السابقة
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color(0xff345e96)),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Column(
                children: [
                  Icon(Icons.home, color: Colors.red, size: 25),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Home",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              onTap: () {
                ZoomDrawer.of(context)?.close();
                Navigator.pushNamed(context, 'home');
              },
            ),
            ListTile(
              title: Column(
                children: [
                  Icon(Icons.call, color: Colors.green, size: 25),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "History",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              onTap: () {
                ZoomDrawer.of(context)?.close();
                Navigator.pushNamed(
                  context,
                  'calls',
                );
              },
            ),
            ListTile(
              title: Column(
                children: [
                  Icon(Icons.groups, color: Colors.yellow, size: 25),
                  SizedBox(
                    width: 10,
                  ),
                  Text("About Us",
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
              onTap: () {
                ZoomDrawer.of(context)?.close();
                Navigator.pushNamed(context, 'aboutus');
              },
            ),
            ListTile(
              title: Column(
                children: [
                  Icon(Icons.lock_reset, color: Color(0xff19ccb2), size: 25),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Password",
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
              onTap: () {
                ZoomDrawer.of(context)?.close();
                Navigator.pushNamed(
                  context,
                  'resetpassword',
                );
              },
            ),
            ListTile(
              title: Column(
                children: [
                  Icon(Icons.login, color: Colors.grey.shade400, size: 25),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Log Out",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              onTap: () {
                ZoomDrawer.of(context)?.close();
                _signOut(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}


//resetpassword