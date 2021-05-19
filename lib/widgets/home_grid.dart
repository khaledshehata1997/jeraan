
import 'package:flutter/material.dart';
import 'package:jeraan_project/screens/e_commerse/e_commerse_home.dart';
import 'package:jeraan_project/screens/events/event_home.dart';
import 'package:jeraan_project/screens/help/help_home.dart';
import 'package:jeraan_project/screens/jobs/jobs_home.dart';
import 'package:jeraan_project/screens/t3arf/t3arf_home.dart';
class HomeGrid extends StatelessWidget {
  String image1,image2;
  String text1,text2;

  @override
  Widget build(BuildContext context) {
 Fun1(){Navigator.push(context, MaterialPageRoute(builder: (context)=>EventHome()));};
 Fun2(){Navigator.push(context, MaterialPageRoute(builder: (context)=>T3arfHome()));};
 Fun3(){Navigator.push(context, MaterialPageRoute(builder: (context)=>ECommerseHome()));};
 Fun4(){Navigator.push(context, MaterialPageRoute(builder: (context)=>HelpHome()));};
 Fun5(){Navigator.push(context, MaterialPageRoute(builder: (context)=>JobsHome()));};
 Fun6(){};
    return SingleChildScrollView(
      child: Column(
        children: [

          homeGrid(context,'home_images/eventss.png',   'home_images/twasl.jpg',
              'مناسبات الجيران',     'تعارف الجيران',
                 Fun1,
                 Fun2,
      ),
          homeGrid(context,'home_images/E-commerse.png',    'home_images/help.jpg'
              ,'بيع وشراء الجيران',   'إستعارات الجيران',
              Fun3,
              Fun4,
          ),
          homeGrid(context,'home_images/jobs.jpg',   'home_images/istshara.jpg',
              'هوايات الجيران',   'استشارات بين الجيران',
      Fun5,
      Fun6,
      ),
        ],
      ),
    );
  }

  Widget homeGrid(BuildContext context, String image1,image2,text1,text2, Function one,two){
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              GestureDetector(
                onTap: (){
                  one();
                },
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius:15,
                        color: Colors.grey,
                      )
                    ],
                      color: Colors.pink[50],
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Image.asset('$image1',fit: BoxFit.fill,),
                  margin: EdgeInsets.all(3),
                  width: width*.38,
                  height: height*.095,
                ),
              ),
              Text('$text1',style: TextStyle(fontSize: 18,color: Colors.pink[900],fontWeight: FontWeight.bold),)
            ],
          ),
          SizedBox(width: 12,),
          Column(
            children: [
              GestureDetector(
                onTap:(){
                  two();
                },
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius:15,
                          color: Colors.grey,
                        )
                      ],
                      color: Colors.pink[50],
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Image.asset('$image2',fit: BoxFit.fill),
                  margin: EdgeInsets.all(3),
                  width: width*.38,
                  height: height*.095,
                ),
              ),
              Text('$text2',style: TextStyle(fontSize: 18,color: Colors.pink[900],fontWeight: FontWeight.bold),)
            ],
          ),

        ],
      ),

    );
 }

}
