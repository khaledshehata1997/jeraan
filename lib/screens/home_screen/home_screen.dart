import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jeraan_project/screens/serves/appstate.dart';
import 'package:jeraan_project/widgets/carosul_slider.dart';
import 'package:jeraan_project/widgets/drawer.dart';
import 'package:jeraan_project/widgets/home_grid.dart';
import 'package:jeraan_project/widgets/serchBar.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

GlobalKey<ScaffoldState>drawerKey=GlobalKey();
@override
  Widget build(BuildContext context) {
    AppState appState = Provider.of<AppState>(context);
    var mediQuery = MediaQuery.of(context).size;

    return Scaffold(
      key: drawerKey,
      drawer: Drawer(
        child: drawer(context),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(icon:Icon(Icons.menu,size: 30,color: Colors.pink[900],),
                          onPressed: (){
                        drawerKey.currentState.openDrawer();
                          }),
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        width: mediQuery.width*.55,
                        height: mediQuery.height*.13,
                        alignment: Alignment.center,
                        child: Image.asset('images/jeran2022.jpeg',
                        ),
                      ),
                      Container(width: 35,)
                    // IconButton(icon: Icon(Icons.location_on_outlined,size: 25,color: Colors.pink[900],),
                    //     onPressed: (){

                    //     })
                    ],
                  ),
                ),
                //serchBar((value){},appState.getlocal == "ar"? "البحث" : 'Search'),
                Container(
                  margin: EdgeInsets.only(top: 12),
                    child: HomeCarousel()
                ),
                SizedBox(height: mediQuery.height*.035),
                HomeGrid(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
