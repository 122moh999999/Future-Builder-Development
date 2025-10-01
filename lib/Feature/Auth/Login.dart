import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:future_builder_app/Core/services/auth_services.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  late UserCredential? response = null;
  late UserCredential? userCredential = null;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(
      children: [
        Container(
            width: screenWidth,
            height: screenHeight,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xff345e96),
              Color(0xff1d4873),
              Color(0xff0f2a63)
            ])),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 40, left: 40),
                      child: Text(
                        'Hello !',
                        style: TextStyle(
                            fontSize: screenHeight / 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 40),
                      child: Text(
                        'Sign in..',
                        style: TextStyle(
                            fontSize: screenHeight / 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            )),
        Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.only(top: screenHeight / 3.5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            width: screenWidth,
            height: double.infinity,
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: screenHeight / 10, left: 40, right: 40),
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email.";
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                          .hasMatch(value)) {
                        return "Please enter a valid email.";
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 30, left: 40, right: 40),
                    child: TextFormField(
                      maxLength: 8,
                      controller: _passwordController,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'please enter password';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                      ),
                    )),
                InkWell(
                  onTap: () async {
                    response = (await AuthService().myLogin(
                            _emailController.text, _passwordController.text))
                        as UserCredential?;
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        top: 50, left: 40, right: 40, bottom: 50),
                    height: screenHeight / 12,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color(0xff0f2a63),
                        Color(0xff1d4873),
                        Color(0xff345e96),
                      ]),

                      border: Border.all(
                        color: Colors.white, // Border color
                        width: 3.0, // Border width
                      ),
                      borderRadius: BorderRadius.circular(
                          50), // Optional: Rounded corners
                    ),
                    child: Center(
                        child: Text('sign in',
                            style: TextStyle(
                                fontSize: screenWidth / 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold))),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Dont Have account :',
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'signup');
                        },
                        child: Text('Sign up',
                            style: TextStyle(color: Color(0xff0f2a63))))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () async {
                        await AuthService()
                            .resetPassword(_emailController.text);
                      },
                      child: Text(
                        'Forget Password',
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
