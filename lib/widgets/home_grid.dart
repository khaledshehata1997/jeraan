
import 'package:flutter/material.dart';
import 'package:jeraan_project/screens/ask/ask_home.dart';
import 'package:jeraan_project/screens/e_commerse/e_commerse_home.dart';
import 'package:jeraan_project/screens/events/event_home.dart';
import 'package:jeraan_project/screens/help/help_home.dart';
import 'package:jeraan_project/screens/jobs/jobs_home.dart';
import 'package:jeraan_project/screens/serves/appstate.dart';
import 'package:jeraan_project/screens/t3arf/t3arf_home.dart';
import 'package:provider/provider.dart';
class HomeGrid extends StatelessWidget {
  String image1,image2;
  String text1,text2;

  @override
  Widget build(BuildContext context) {
  AppState appState = Provider.of<AppState>(context);
 Fun1(){Navigator.push(context, MaterialPageRoute(builder: (context)=>EventHome()));};
 Fun2(){Navigator.push(context, MaterialPageRoute(builder: (context)=>T3arfHome()));};
 Fun3(){Navigator.push(context, MaterialPageRoute(builder: (context)=>ECommerseHome()));};
 Fun4(){Navigator.push(context, MaterialPageRoute(builder: (context)=>HelpHome()));};
 Fun5(){Navigator.push(context, MaterialPageRoute(builder: (context)=>JobsHome()));};
 Fun6(){Navigator.push(context, MaterialPageRoute(builder: (context)=>AskHome()));};
    return SingleChildScrollView(
      child: Column(
        children: [

          homeGrid(context,'home_images/istshara.jpg',   'home_images/twasl.jpg',
              appState.getlocal == "ar"?  'تعارف الجيران' : "know the neighbors",    appState.getlocal == "ar"? 'استشارات الجيران' : "Ask your neighbors",
                 Fun2,
            Fun6,
      ),

          homeGrid(context,'home_images/E-commerse.png',    'home_images/help.jpg'
              ,appState.getlocal == "ar"? 'بيع وشراء الجيران': "Sell and Buy",appState.getlocal == "ar"? 'إستعارات وتبادل الجيران': "Borrow something",
              Fun3,
              Fun4,
          ),
       homeGrid(context,'home_images/jobs.jpg',   'home_images/eventss.png',
             appState.getlocal == "ar"? 'هوايات الجيران': "Neighbors' hobbies", appState.getlocal == "ar"? 'مناسبات الجيران': "Neighbors events",
      Fun5,
            Fun1,
      ),
        ],
      ),
    );
  }

  Widget homeGrid(BuildContext context, String image1,image2,text1,text2, Function one,two){
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
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
                  width: width*.35,
                  height: height*.09,
                ),
              ),
              Text('$text1',style: TextStyle(fontSize: 15,color: Colors.pink[900],fontWeight: FontWeight.bold),)
            ],
          ),
          SizedBox(width: 10,),
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
                  width: width*.35,
                  height: height*.09,
                ),
              ),
              Text('$text2',style: TextStyle(fontSize: 15,color: Colors.pink[900],fontWeight: FontWeight.bold),)
            ],
          ),

        ],
      ),

    );
 }

}
