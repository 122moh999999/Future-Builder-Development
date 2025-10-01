import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'details page.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Home_Page extends StatelessWidget {
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color(0xff0f2a63), width: 2))),
          ),
          leading: IconButton(
              onPressed: () {
                ZoomDrawer.of(context)?.toggle(); // فتح أو إغلاق القائمة
              },
              icon: Icon(Icons.menu,
                  size: screenWidth / 10, color: Color(0xff0f2a63))),
          title: Text('Home',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xff0f2a63))),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: productsCollection.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final products = snapshot.data?.docs ?? [];
              final currentUser = FirebaseAuth.instance.currentUser;
              if (currentUser == null) {
                return Center(
                    child: Text('Please log in to interact with products.'));
              }

              final currentUserId = currentUser.uid;

              return GridView.builder(
                padding: EdgeInsets.all(8.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 8.0, // Spacing between columns
                  mainAxisSpacing: 8.0, // Spacing between rows
                  childAspectRatio: 0.7, // Aspect ratio of the grid items
                ),
                itemCount:
                    products.length, // Number of items dynamically determined
                itemBuilder: (context, index) {
                  final product = products[index];
                  final data = product.data() as Map<String, dynamic>;

                  final List<dynamic> imageList = data['imageUrl'] ?? [];
                  final String firstImage =
                      (imageList.isNotEmpty) ? imageList[0] : '';

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            productData: data,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: Color(0xff0f2a63), width: 2),
                          color: Colors.white),
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.all(10),
                              child: Image.network(
                                firstImage,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Center(
                                      child: CircularProgressIndicator(
                                    color: Colors.yellow,
                                  ));
                                },
                              )),
                          Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.description,
                                      color: Colors.grey,
                                      size: 24,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      data['type'] ?? '',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff0f2a63)),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_pin,
                                      color: Colors.grey,
                                      size: 24,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      data['location'] ?? '',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff0f2a63)),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    LikesButton(
                                      initialLikes: data['likes'],
                                      productId: product.id,
                                      userId:
                                          currentUserId, // معرف المستخدم الحالي
                                      likedBy: List<String>.from(data[
                                              'likedBy'] ??
                                          []), // قائمة المستخدمين الذين أعجبهم المنتج
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }));
  }
}

class LikesButton extends StatefulWidget {
  final int initialLikes;
  final String productId;
  final String userId; // معرف المستخدم
  final List<String> likedBy; // قائمة المستخدمين الذين أعجبهم المنتج

  LikesButton({
    Key? key,
    this.initialLikes = 0,
    required this.productId,
    required this.userId,
    required this.likedBy,
  }) : super(key: key);

  @override
  _LikesButtonState createState() => _LikesButtonState();
}

class _LikesButtonState extends State<LikesButton>
    with SingleTickerProviderStateMixin {
  late int _likes;
  late bool _isLiked;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _likes = widget.initialLikes;
    _isLiked = widget.likedBy
        .contains(widget.userId); // التحقق إذا كان المستخدم قد تفاعل
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    if (_isLiked) {
      _animationController.forward(); // إعداد الحالة الأولية
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _updateLikesInFirebase() async {
    final docRef =
        FirebaseFirestore.instance.collection('products').doc(widget.productId);

    try {
      if (_isLiked) {
        // إضافة المستخدم إلى قائمة likedBy
        await docRef.update({
          'likes': _likes,
          'likedBy': FieldValue.arrayUnion([widget.userId]),
        });
      } else {
        // إزالة المستخدم من قائمة likedBy
        await docRef.update({
          'likes': _likes,
          'likedBy': FieldValue.arrayRemove([widget.userId]),
        });
      }
    } catch (e) {
      print('Error updating likes: $e');
    }
  }

  void _toggleLike() {
    setState(() {
      if (_isLiked) {
        _likes--;
        _animationController.reverse();
      } else {
        _likes++;
        _animationController.forward();
      }
      _isLiked = !_isLiked;

      // تحديث Firebase
      _updateLikesInFirebase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleLike,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ScaleTransition(
            scale: Tween<double>(begin: 1.0, end: 1.2).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Curves.elasticOut,
              ),
            ),
            child: Icon(
              _isLiked ? Icons.favorite : Icons.favorite_border,
              color: _isLiked ? Colors.red : Colors.grey,
              size: 32,
            ),
          ),
          SizedBox(width: 8),
          Text(
            '$_likes',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xff0f2a63)),
          ),
        ],
      ),
    );
  }
}
