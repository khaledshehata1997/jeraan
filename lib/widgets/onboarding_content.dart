import 'package:flutter/material.dart';
import 'package:jeraan_project/constants.dart';
class OnboardingContent extends StatelessWidget {
  final String text, image;
  OnboardingContent({
    this.text,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    var mediaQuery =MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Spacer(),
        Text(
          "جيران",
          style: TextStyle(
            fontSize: 40,
            color: mainColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: mediaQuery.width*0.03),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
            fontSize: 20
            ),
            textDirection: TextDirection.rtl,
          ),
        ),
        Spacer(flex: 2),
        Image.asset(
          image,
          height: mediaQuery.height*0.25,
          width: mediaQuery.width*0.5,
        ),
      ],
    );
  }
}
