import 'package:flutter/material.dart';

class CustomCircular extends StatelessWidget {
  const CustomCircular({super.key, this.color});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color,
      ),
    );
  }
}
