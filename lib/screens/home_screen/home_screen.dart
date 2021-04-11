import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jeraan_project/widgets/carosul_slider.dart';
import 'package:jeraan_project/widgets/home_grid.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override

  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('تطبيق جيران',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
        ),
      drawer: Drawer(),
      body: SafeArea(
        child: Container(
          height: height,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 12),
                  child: HomeCarousel()
              ),
              HomeGrid(),
            ],
          ),
        ),
      ),
    );
  }
}
