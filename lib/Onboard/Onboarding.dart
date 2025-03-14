import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "image": "images/iconlogo.png",
      "title": "Welcome to MyApp",
      "description": "Discover amazing features to enhance your experience."
    },

    {
      "image": "images/dow.jpg",
      "title": "Discover our world",
      "description": "We have many real estate in the application where you can communicate with their owners."
    },

    {
      "image": "images/AA.jpg",
      "title": "Achieve Yor Aim",
      "description": "Our application will help you achieve your aim and find the right real estate."
    },

    {
      "image": "images/HSH.jpg",
      "title": "Trust In Owners",
      "description": "The application displays properties for sale from the original owners and there are no agencies."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Progress Indicator Bar
          LinearProgressIndicator(
            value: (_currentPage + 1) / onboardingData.length,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xff0f2a63))),

          Expanded(
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (index) => setState(() => _currentPage = index),
              itemCount: onboardingData.length,
              itemBuilder: (context, index) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    onboardingData[index]["image"]!,
                    height: 300,
                  ),
                  SizedBox(height: 20),
                  Text(
                    onboardingData[index]["title"]!,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold     ,
                        color: Color(0xff0f2a63)),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      onboardingData[index]["description"]!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16

                              ,
                        color: Color(0xff0f2a63)
                      ),

                    ),
                  ),
                ],
              ),
            ),
          ),
          // Navigation Dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              onboardingData.length,
                  (index) => AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 4),
                width: _currentPage == index ? 12 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentPage == index ?  Color(0xff0f2a63) : Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          // Navigation Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (_currentPage > 0)
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),

                  color: Color(0xff0f2a63),
                  onPressed: () {
                    _controller.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  },
                  child: Text("Back",style: TextStyle(color:Colors.white)),
                ),

             MaterialButton(
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(20)
               ),
                 color: Color(0xff0f2a63),
                onPressed: () {
                  if (_currentPage < onboardingData.length - 1) {
                    _controller.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  }
                  else {
                    Navigator.pushNamed(context, 'start');
                  }

                },
                child: Text(_currentPage == onboardingData.length - 1
                    ? "Get Started"
                    : "Next",style: TextStyle(color: Colors.white)),

              ),
            ],
          ),
          // Skip Button
          TextButton(
            onPressed: (){
              Navigator.pushNamed(context, 'start');
            },
            child: Text("Skip",style: TextStyle(color:   Color(0xff0f2a63)),),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
