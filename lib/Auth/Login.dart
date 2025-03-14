import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  late UserCredential? response = null ;
 late UserCredential? userCredential = null ;
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  signIn() async {
    var formdata = _formKey.currentState;
    formdata!.save();
    if (_formKey.currentState!.validate()) {
    try {
      userCredential = await _auth.signInWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim(),);
      Navigator.pushReplacementNamed(context, 'home');
      // Navigate to the home screen if successful
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.red,content: Text("No user found for that email.")),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(

          SnackBar(backgroundColor: Colors.red,content: Text("Wrong password provided for that user.")),
        );
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.red,
              content: Text("make sure that you enter valid email and password")),
        );
      }
    }
    }
  }

  Future<void> resetPassword() async {

    if (_formKey.currentState!.validate() || _emailController !=null || _emailController != "") {
      try {
        await _auth.sendPasswordResetEmail(
          email: _emailController.text.trim(),
        );
        ScaffoldMessenger.of(context).showSnackBar(

          SnackBar(content:
          Text("check your email and reset password"),backgroundColor: Colors.green,),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
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
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return "Please enter a valid email.";
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 30, left: 40, right: 40),
                    child: TextFormField(

                      controller: _passwordController,
                      validator: (val){
                        if(val == null||val.isEmpty){
                        return 'please enter password';
                      }
                        },
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                      ),
                    )),
                InkWell(
                  onTap: () async {
                    response = await signIn();
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        top: 50,
                        left: 40,
                        right: 40,
                        bottom: 50),
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
                    Text('Dont Have account :',style: TextStyle(color: Colors.grey),),
                    TextButton(onPressed: (){
                      Navigator.pushNamed(context, 'signup');
                    }, child: Text('Sign up',style: TextStyle(color: Color(0xff0f2a63))))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed:resetPassword
                      ,
                      child: Text('Forget Password',style: TextStyle(color: Colors.blue),),
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
