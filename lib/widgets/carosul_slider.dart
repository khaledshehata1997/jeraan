import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class HomeCarousel extends StatefulWidget {
  @override
  _HomeCarouselState createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel> {
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
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
        items: [
          Container(
            color: Colors.yellowAccent,
            child: Image.asset(
              'images/jar1.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.yellowAccent,
            child: Image.asset(
              'images/jar2.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.yellowAccent,
            child: Image.asset(
              'images/jar3.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ],
        options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 2.4,
            onPageChanged: (index, reason) {
              setState(() {
                currentPage = index;
              });
            }),
      )
    ]);
  }
}
