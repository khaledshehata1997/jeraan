import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geodesy/geodesy.dart';
import 'package:get/get.dart';
import 'package:jeraan_project/screens/serves/alerts.dart';
import 'package:clipboard/clipboard.dart';
import 'package:jeraan_project/screens/serves/appstate.dart';
import 'package:provider/provider.dart';

class ViewUsersScreen extends StatefulWidget {
  final String userid;
  ViewUsersScreen( this.userid);
  @override
  _ViewUsersScreenState createState() => _ViewUsersScreenState();
}

class _ViewUsersScreenState extends State<ViewUsersScreen> {
  Geodesy geodesy = Geodesy();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الملف الشخصي'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").doc(widget.userid).snapshots(),
        builder: (context , snapshot){
        if (snapshot.hasError)
            return Center(child: Text('خطآ يرجى المحاولة في وقت لاحق'));
            switch (snapshot.connectionState) {
            case ConnectionState.waiting: return Center(
              child: Center(child: CircularProgressIndicator())
            );
            default:
            List<String> dateOfBirth = List.from(snapshot.data["age"]);
            DateTime dateOfBirthD = DateTime(int.parse(dateOfBirth[0]),int.parse(dateOfBirth[1]),int.parse(dateOfBirth[2]));
            String age = ((DateTime.now().difference(dateOfBirthD).inDays / 365.25).floor()).toString();
              String name = snapshot.data["name"];
              String phone = snapshot.data["phone"];
              String image = snapshot.data["image"];
              String adress = snapshot.data["adress"];
              String jop = snapshot.data["jop"];
              String about = snapshot.data["about"];
              List<double> lg = List.from(snapshot.data["lg"]);

              AppState appState = Provider.of<AppState>(context , listen: false);
              LatLng l1 = LatLng(appState.getlat , appState.getlong);
              int distance = geodesy.distanceBetweenTwoGeoPoints(l1, LatLng(lg[0], lg[1])).toInt();
        return ListView(
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
                    backgroundImage: FirebaseImage(image),
                  ),
                  SizedBox(height: 20,),
                  Text(name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  SizedBox(height: Get.height*.05,),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("سنة",style: TextStyle(fontSize: 14)),
                          SizedBox(width: 3,),
                          Text(age,style: TextStyle(fontSize: 14)),
                          SizedBox(width: 20,),
                         Icon(Icons.person)
      
                        ],
                      ),
                      SizedBox(height: Get.height*.02,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(jop ,style: TextStyle(fontSize: 14)),
                          SizedBox(width: 20,),
                         Icon(Icons.work_outline_outlined),
      
                        ],
                      ),
                      SizedBox(height: Get.height*.02,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(adress ,style: TextStyle(fontSize: 14)),
                          SizedBox(width: 20,),
                         Icon(Icons.location_on_outlined),
      
                        ],
                      ),
                      SizedBox(height: Get.height*.02,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text( "متر" ,style: TextStyle(fontSize: 15)),
                          SizedBox(width: 5,),
                          Text( "${distance.toString()}" ?? "" ,style: TextStyle(fontSize: 14)),
                          SizedBox(width: 5,),
                          Text( "يبعد عنك"  ,style: TextStyle(fontSize: 14)),
                          SizedBox(width: 20,),
                         Icon(Icons.location_on_outlined),
                         // Text('البريد الالكتروني :   ',style: TextStyle(fontSize: 15),textDirection: TextDirection.rtl,),
                        ],
                      ),
                      SizedBox(height: Get.height*.02,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              alignment: Alignment.topRight,
                              width: MediaQuery.of(context).size.width*0.70,
                              child: Text(about ,style: TextStyle(fontSize: 14),textAlign: TextAlign.right,)),
                            SizedBox(width: 20,),
                           Icon(Icons.edit ,size: 20,),
      
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
                              phone,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            ),
                            IconButton(onPressed: (){
                               FlutterClipboard.copy(phone).then((value) =>EasyLoading.showSuccess("تم النسخ",duration: Duration(milliseconds: 600)));
                            }, icon: Icon(Icons.copy))
                          ]),
                      //SizedBox(height: Get.height*.02,),
                      
                    ],
                  )
                ],
              ),
            )
          ],
        );
            }}
      ),
    );
  }
}
