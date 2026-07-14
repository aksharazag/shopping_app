import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final String text;
  const LogoWidget({this.text = "MyApp"});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Image.asset("assets/images/logo.png",width: screenWidth * 0.4,height: screenWidth * 0.2,),
        SizedBox(height: 8),
        Text(text, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.deepOrange)),
      ],
    );
  }
}
