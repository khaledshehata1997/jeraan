import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jeraan_project/widgets/carosul_slider.dart';
import 'package:jeraan_project/widgets/drawer.dart';
import 'package:jeraan_project/widgets/home_grid.dart';
import 'package:jeraan_project/widgets/serchBar.dart';


class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
GlobalKey<ScaffoldState>drawerKey=GlobalKey();
@override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Scaffold(
      key: drawerKey,
      drawer: Drawer(
        child: drawer(context),
      ),
      body: SafeArea(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Container(

              height: height,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(icon:Icon(Icons.menu,size: 30,color: Colors.pink[900],),
                            onPressed: (){
                          drawerKey.currentState.openDrawer();
                            }),
                        Container(
                            width: 150,
                            height: 60,
                            child: Image.asset(
                              'images/text.png',fit: BoxFit.cover,)),

                      IconButton(icon: Icon(Icons.location_on_outlined,size: 25,color: Colors.pink[900],),
                          onPressed: (){

                          })
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  serchBar((value){},'Search'),
                  Container(
                    margin: EdgeInsets.only(top: 12),
                      child: HomeCarousel()
                  ),
                  SizedBox(height: 10,),
                  HomeGrid(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
