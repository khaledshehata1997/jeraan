import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geodesy/geodesy.dart';
import 'package:get/get.dart';
import 'package:jeraan_project/screens/drawer_sections/updateProfile.dart';
import 'package:jeraan_project/screens/serves/alerts.dart';
import 'package:jeraan_project/screens/serves/appstate.dart';
import 'package:provider/provider.dart';
import 'package:clipboard/clipboard.dart';

class UserProfile extends StatefulWidget {
  final bool isMe;
  final LatLng userlg;
  final String userid;
  UserProfile(this.isMe , this.userlg , this.userid);
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Geodesy geodesy = Geodesy();
  int distance;
  String age = "";
  @override
  void initState() {
  AppState appState = Provider.of<AppState>(context , listen: false);
  LatLng l1 = LatLng(appState.getlat , appState.getlong);
  int point = geodesy.distanceBetweenTwoGeoPoints(l1, widget.userlg).toInt();
  DateTime dateOfBirth = DateTime(int.parse(appState.getage[0]),int.parse(appState.getage[1]),int.parse(appState.getage[2]));
  age = ((DateTime.now().difference(dateOfBirth).inDays / 365.25).floor()).toString();
  setState(() {
    distance = point;
  });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  AppState appState = Provider.of<AppState>(context );
    return Scaffold(
      appBar: AppBar(
        title: Text(appState.getlocal == "ar"?'الملف الشخصي':"Profile"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15 , vertical: 30),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(spreadRadius: .5, blurRadius: 7)],
                borderRadius: BorderRadius.circular(12)),
            width: Get.width*.95,
            margin: EdgeInsets.symmetric(vertical: 20,horizontal: 8),
            child: Column(
              children: [
                CircleAvatar(
                  maxRadius: 45,
                  backgroundImage: FirebaseImage(appState.image),
                ),
                SizedBox(height: 20,),
                Text(appState.name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                SizedBox(height: Get.height*.05,),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.person),
                        SizedBox(width: 20,),
                        Text(age,style: TextStyle(fontSize: 14)),
                        SizedBox(width: 5,),
                        Text(appState.getlocal == "ar"?"سنة":"year",style: TextStyle(fontSize: 14)),
                       
                      ],
                    ),
                    SizedBox(height: Get.height*.02,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.work_outline_outlined),
                        SizedBox(width: 20,),
                       Text(appState.jop ,style: TextStyle(fontSize: 14)),

                      ],
                    ),
                    SizedBox(height: Get.height*.02,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.location_on_outlined),
                        SizedBox(width: 20,),
                       Text(appState.adress ,style: TextStyle(fontSize: 14)),

                      ],
                    ),
                    SizedBox(height: Get.height*.02,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.location_on_outlined),
                        SizedBox(width: 20,),
                        Text( appState.getlocal == "ar"? "يبعد عنك" : "away from you"  ,style: TextStyle(fontSize: 14)),
                        SizedBox(width: 5,),
                       Text( "${distance.toString()}" ?? "" ,style: TextStyle(fontSize: 14)),
                        SizedBox(width: 5,),
                       Text( appState.getlocal == "ar"? "متر" : "m" ,style: TextStyle(fontSize: 15)),
                       // Text('البريد الالكتروني :   ',style: TextStyle(fontSize: 15),textDirection: TextDirection.rtl,),
                      ],
                    ),
                    SizedBox(height: Get.height*.02,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                         Icon(Icons.edit ,size: 20,),
                          SizedBox(width: 20,),
                           Container(
                            alignment: appState.getlocal == "ar"? Alignment.topRight : Alignment.topLeft,
                            width: MediaQuery.of(context).size.width*0.70,
                            child: Text(appState.about ,style: TextStyle(fontSize: 14),textAlign:appState.getlocal == "ar"? TextAlign.right : TextAlign.left,)),
                         

                        ],
                      ),
                    ),
                    
                    Divider(thickness: 2,height: Get.height*.05,),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('images/whats.png',width:30,height: 30,),
                          ),
                          Text(
                            appState.phone,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          IconButton(onPressed: (){
                             FlutterClipboard.copy(appState.phone).then((value) =>EasyLoading.showSuccess((appState.getlocal == "ar"?"تم النسخ" : "Copied"),duration: Duration(milliseconds: 600)));
                          }, icon: Icon(Icons.copy))
                        ]),
                    SizedBox(height: Get.height*.02,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ElevatedButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateProfile()));
                          },
                        child: Text(appState.getlocal == "ar"?'تعديل الملف الشخصي':"Edit your profile"),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.pink[900]),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
