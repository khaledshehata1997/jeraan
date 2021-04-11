import 'package:flutter/material.dart';
import 'package:jeraan_project/screens/auth/onBoarding_screen.dart';
import 'package:jeraan_project/screens/auth/sign_in.dart';
import 'package:jeraan_project/screens/home_screen/home_screen.dart';
import 'package:jeraan_project/widgets/carosul_slider.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor:Colors.pink[900],
            accentColor: Colors.pink[900]
      ),
      home: HomeScreen(),
    );
  }
}

