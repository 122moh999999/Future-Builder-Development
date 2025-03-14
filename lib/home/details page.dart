

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Call_archive/SQFlite.dart';

class DetailPage extends StatelessWidget {

  final Map<String, dynamic> productData;

  final DatabaseHelper dbHelper = DatabaseHelper();

  DetailPage({Key? key, required this.productData}) : super(key: key);

  void _addItem(String x,String y,String z) async {
    await dbHelper.addItem(x,y,z);
  }

  void _makePhoneCall(String number) async {
    final Uri callUri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      throw "Could not launch $callUri";
    }
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final List<dynamic> imageList = productData['imageUrl'] ?? [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(productData['type'],

          style: Theme.of(context).textTheme.headlineLarge,),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            if (imageList.isNotEmpty)
            Container(
              width: screenWidth,height: screenHeight/2.3,
              child: PageView.builder(
                itemCount: imageList.length, // Number of pages
                itemBuilder: (context, index) {
                  final imageUrl = imageList[index];
                  return Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.white, // Different color for each page
                    child:
                    Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return
                          Center(child: CircularProgressIndicator(
                            color: Color(0xff0f2a63),
                          )
                          )
                        ;
                      },
                    )
                    ,
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                productData['location'] ?? '',
                style:  TextStyle(
                    fontWeight:FontWeight.bold,
                    fontSize: screenWidth/12
                    ,color: Color(0xff0f2a63)
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                productData['description'] ?? '',
                style: TextStyle(fontSize: 16,color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                productData['price'] ?? '',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Icon(
                    Icons.heart_broken,
                    color: Colors.red,
                    size: 24,
                  ),
                  SizedBox(width: 8),
                  Text(
                      productData['likes'].toString() ?? '',
                    style: TextStyle(fontSize: 18,color: Colors.black),
                  ),
                ],
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center,children: [
              InkWell(child:
              Container(
                width: 70,height: 70,
                child: Image(
                    image:

                    AssetImage('images/call.png')

                ),

              )
                ,onTap: (){

                  _addItem(productData['phone'] ?? '',productData['type'] ?? '',productData['location'] ?? '');

                  _makePhoneCall(productData['phone']);

                },)
            ],)
          ],
        ),
      ),
    );
  }
}