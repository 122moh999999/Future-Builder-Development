import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController_fst = TextEditingController();
  final _passwordController_sec = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Future<void> signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        final user = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController_fst.text.trim(),
        );
        await user.user!.sendEmailVerification();

        ScaffoldMessenger.of(context).showSnackBar(

          SnackBar(
              backgroundColor: Colors.green,
              content: Text("Verification email sent!")),
        );
        print('Verification email sent!');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
        print(e.toString());
      }
    }
  }
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
                            'Create Your',
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

                            'Account'
                              ,

                            style: TextStyle(
                                fontSize: screenHeight / 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            )

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
                          top: 20, left: 40, right: 40),
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: (value) =>
                        value!.isEmpty ? "Enter a valid email" : null,

                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 20, left: 40, right: 40),
                        child: TextFormField(
                          controller: _passwordController_fst,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a password.";
                            } else if (value.length < 6) {
                              return "Password must be at least 6 characters.";
                            }
                            return null;
                          },

                        )),
                    Container(
                        margin: EdgeInsets.only(top: 20, left: 40, right: 40),
                        child: TextFormField(
                          controller: _passwordController_sec,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Confirm password',
                            prefixIcon: Icon(Icons.lock),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please confirm your password.";
                            } else if (value != _passwordController_fst.text) {
                              return "Passwords do not match.";
                            }
                            return null;
                          },

                        )),
                    InkWell(
                      onTap: signUp,
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
                            child: Text('Create account',
                                style: TextStyle(
                                    fontSize: screenWidth / 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('I Have account :',style: TextStyle(color: Colors.grey),),
                        TextButton(onPressed: (){
                          Navigator.pushNamed(context, 'login');
                        }, child: Text('Sign in',style: TextStyle(color: Color(0xff0f2a63))))
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
