import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jeraan_project/constants.dart';
import 'package:jeraan_project/screens/auth/sign_in.dart';

import 'default_button.dart';
class OnboardingContent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var mediaQuery =MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
        Container(
          alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height*.15,
        child: DefaultTextStyle(
        style: const TextStyle(
        fontSize: 45.0,
        fontFamily: 'Canterbury',
        ),
        child: AnimatedTextKit(
          repeatForever: true,
          isRepeatingAnimation: true,
        animatedTexts: [
        ScaleAnimatedText('جيران',textStyle: TextStyle(color:mainColor,fontWeight: FontWeight.bold)),
        ScaleAnimatedText('NEIGBORS',textStyle: TextStyle(color: mainColor,fontWeight: FontWeight.bold)),
        ],
        )
        ),
        ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: mediaQuery.width*0.03),
              child: Text(
                'مرحبا بكم في جيران! \nنحن نساعد الجيران علي التواصل والتقرب من بعضهم البعض، \n رجاءا ساعدنا علي اتمام هذا العمل الرائع بدون اي شيئ يؤثر علي الهدف',
                textAlign: TextAlign.center,
                style: TextStyle(
                fontSize: 18
                ),
                textDirection: TextDirection.rtl,
              ),
            ),
            SizedBox(height:MediaQuery.of(context).size.height*.05,),

            Image.asset(
              'images/jeran.png',
              height: mediaQuery.height*0.2,
              width: mediaQuery.width*0.6,
            ),
            SizedBox(height:MediaQuery.of(context).size.height*.1,),

            DefaultButton(
              text: "تخطي",
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
