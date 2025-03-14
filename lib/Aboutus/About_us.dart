import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  final List<Map<String, String>> teamMembers = [
    {
      "name": "M.ELSH@BR@WY",
      "role": "Lead Developer",
      "image": "images/mhomd_shbrawy.jpeg",
      "description":
          "Mohamed is an experienced Flutter developer who leads the team with innovation."
    },
    {
      "name": "M.ELSH@BR@WY",
      "role": "UI/UX Designer",
      "image": "images/mhomd_shbrawy.jpeg",
      "description":
          "Mohamed is passionate about creating intuitive and beautiful app designs."
    },
    {
      "name": "M.ELSH@BR@WY",
      "role": "Backend Engineer",
      "image": "images/mhomd_shbrawy.jpeg",
      "description":
          "Mohamed ensures the app's backend runs smoothly and efficiently."
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('About Us',
            style: Theme.of(context).textTheme.headlineLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo Section
              Center(
                  child: Image(
                image: AssetImage('images/nav_logo.png'),
              )),
              SizedBox(height: 16),

              // Title
              Center(
                child: Text(
                  "FutureBuilder",
                  style: TextStyle(
                      fontSize: 24,
                      color: Color(0xff0f2a63),
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 16),

              // Description
              Text(
                "Welcome to Future Builder, your trusted companion for finding your dream home or investment property. "
                "Our mission is to simplify the real estate journey for everyone.",
                style: TextStyle(fontSize: 16, height: 1.5,color: Colors.black),
              ),
              SizedBox(height: 16),

              // Features Section
              Text(
                "What We Offer",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff0f2a63),
                ),
              ),
              SizedBox(height: 8),
              Text(
                "✓ Comprehensive property listings.\n"
                "✓ Advanced search filters.\n"
                "✓ Secure communication between users.\n"
                "✓ Expert real estate advice.",
                style: TextStyle(fontSize: 16, height: 1.5,color: Colors.black),
              ),
              SizedBox(height: 16),

              // Team Section
              Text(
                "Meet Our Team",
                style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff0f2a63),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              ...teamMembers.map((member) {
                return Card(
                  
                  color: Colors.white54,
                  margin: EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(member["image"]!),
                      radius: 30,
                    ),
                    title: Text(member["name"]!,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(member["role"]!),
                        SizedBox(height: 4),
                        Text(
                          member["description"]!,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),

              // Contact Section
              SizedBox(height: 16),
              Text(
                "Contact Us",
                style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff0f2a63),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "Email: m.elshebrawy428@gmail.com\nPhone: +20 106 9412 004",
                style: TextStyle(fontSize: 16,color: Colors.black),
              ),
              SizedBox(height: 16),

              // Footer
              Center(
                child: Text(
                  "© 2024 FutureBuilder. All rights reserved.",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
