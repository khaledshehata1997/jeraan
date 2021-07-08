import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class HomeCarousel extends StatefulWidget {
  @override
  _HomeCarouselState createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel> {
  List<Map> ad = [];
  int currentPage = 0;
  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      height: 6,
      width: currentPage == index ? 20 : 6,
    );
  }

  // carouselWidget(String url) {
  //   return Container(
  //     child: ClipRRect(
  //         child: Stack(
  //           children: <Widget>[
  //             Container(
  //                 height: MediaQuery.of(context).size.height * .21,
  //                 width: MediaQuery.of(context).size.width * 1.0,
  //                 ),
  //           ],
  //         )),
  //   );
  // }

  @override
  void initState() {
    FirebaseFirestore.instance.collection("ads").doc("main").get().then((value){
      ad = List.from(value["ads"]);
      setState(() {
        
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
    ad.length > 0 ?  CarouselSlider.builder(
        itemCount: ad.length, itemBuilder: (context,i,n){
          return cardAd(ad[i]["image"], ad[i]["url"]);
        },
        
        options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 2.9,
            onPageChanged: (index, reason) {
              setState(() {
                currentPage = index;
              });
            }),
      ):Container()
    ]);
  }
  Widget cardAd(image , url){
    return GestureDetector(
      onTap: ()async{
         await canLaunch(url) ? await launch(url) : print('Could not launch $url');
      },
      child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.pink[900],
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(image: FirebaseImage(image),fit: BoxFit.cover),
                ),
            ),
    );
  }
}
