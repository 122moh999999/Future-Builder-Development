import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);
  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width:screenWidth ,height:screenheight ,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xff345e96),
          Color(0xff1d4873),
          Color(0xff0f2a63)
        ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: screenWidth / 1.3,
              height: screenWidth / 1.3,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/White_logo.png'),
                      fit: BoxFit.fill)),
            ),
            Text('WELCOME!',
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: screenWidth / 20,
            ),
            Column(
              children: [
                InkWell(
                  onTap: (){
                    //go to log in page acction
                    Navigator.pushNamed(context,'login');
                  },
                  child: Container(
                    height: screenWidth / 6,
                    width: screenWidth / 1.2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color(0xff345e96),
                        Color(0xff1d4873),
                        Color(0xff0f2a63)
                      ]),

                      border: Border.all(
                        color: Colors.white, // Border color
                        width: 3.0, // Border width
                      ),
                      borderRadius:
                          BorderRadius.circular(50), // Optional: Rounded corners
                    ),
                    child: Center(
                        child: Text('sign in',
                            style: TextStyle(
                                fontSize: screenWidth / 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold))),
                  ),
                ),
                SizedBox(
                  height: screenWidth / 20,
                ),
                InkWell(
                  onTap: (){
                    //go to sign up page acction

                    Navigator.pushNamed(context, 'signup');
                  },
                  child: Container(
                    height: screenWidth / 6,
                    width: screenWidth / 1.2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(50), // Optional: Rounded corners
                    ),
                    child: Center(
                        child: Text('sign up',
                            style: TextStyle(
                                fontSize: screenWidth/ 20,
                                color: Color(0xff0f2a63),
                                fontWeight: FontWeight.bold)
                        )
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenWidth / 20,
            ),
            Column(
              children: [
                Text('log in with social media',
                    style: TextStyle(
                        fontSize: screenWidth / 30,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.facebook,
                          color: Colors.grey,
                          size: screenWidth / 10,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.g_mobiledata_outlined,
                          color: Colors.grey,
                          size: screenWidth / 6,
                        ))
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
