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
              alignment: Alignment.center,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.pink[900],
                  borderRadius: BorderRadius.circular(10)
              ),
              child:Text('عن عائشة رضي الله عنها عن النبي  صلى الله عليه وسلم\n  قال: ((ما زال جبريل يوصيني بالجار حتى ظننت أنه سيورثه)) .',
                style:TextStyle(fontSize:15,fontWeight:FontWeight.bold,color: Colors.white ) ,textDirection: TextDirection.rtl,)
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.pink[900],
                borderRadius: BorderRadius.circular(10)
            ),
             child:Text('(وَاعْبُدُوا اللَّهَ وَلَا تُشْرِكُوا بِهِ شَيْئًا وَبِالْوَالِدَيْنِ إِحْسَانًا وَبِذِي الْقُرْبَى وَالْيَتَامَى وَالْمَسَاكِينِ وَالْجَارِ ذِي الْقُرْبَى وَالْجَارِ الْجُنُبِ وَالصَّاحِبِ بِالْجَنْبِ وَابْنِ السَّبِيلِ وَمَا مَلَكَتْ أَيْمَانُكُمْ إِنَّ اللَّهَ لَا يُحِبُّ مَنْ كَانَ مُخْتَالًا فَخُورًا)'

               ,style:TextStyle(fontSize:13,fontWeight:FontWeight.bold,color: Colors.white ) ,textDirection: TextDirection.rtl,)
          ),
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(
                  color: Colors.pink[900],
                  borderRadius: BorderRadius.circular(10)
              ),
              child:Text('عن أَبي شُريْحٍ الخُزاعيِّ : أَنَّ النَّبيَّ ﷺ قَالَ \n(("مَنْ كَانَ يُؤمِنُ بِاللَّهِ والْيَوْمِ الآخِرِ فَلْيُحْسِنْ إلى جارِهِ"))',
                style:TextStyle(fontSize:15,fontWeight:FontWeight.bold,color: Colors.white ) ,textDirection: TextDirection.rtl,)
          ),
        ],
        options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 2.9,
            onPageChanged: (index, reason) {
              setState(() {
                currentPage = index;
              });
            }),
      )
    ]);
  }
}
