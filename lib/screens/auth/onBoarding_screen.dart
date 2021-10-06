import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeraan_project/constants.dart';
import 'package:jeraan_project/screens/auth/sign_in.dart';
import 'package:jeraan_project/widgets/default_button.dart';
import 'package:jeraan_project/widgets/onboarding_content.dart';

class OnBoardingScreen extends StatefulWidget {
  static String routeName = '/splash';
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  // AnimatedContainer buildDot({int index}) {
  //   return AnimatedContainer(
  //
  //     duration: Duration(seconds: 2),
  //     margin: EdgeInsets.only(right: 5),
  //     height: 6,
  //     width: currentPage == index ? 20 : 6,
  //     decoration: BoxDecoration(
  //       color: currentPage == index ? mainColor : Color(0xFFD8D8D8),
  //       borderRadius: BorderRadius.circular(3),
  //     ),
  //   );
  // }
  //
  // int currentPage = 0;
  // List<Map<String, String>> onboardingData = [
  //   {"text": "",
  //     "image": ""},
  // ];

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return  OnboardingContent(
    );
  }
}
