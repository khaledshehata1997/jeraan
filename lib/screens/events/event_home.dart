import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geodesy/geodesy.dart';
import 'package:get/get.dart';
import 'package:jeraan_project/screens/events/event_details.dart';
import 'package:jeraan_project/screens/serves/appstate.dart';
import 'package:provider/provider.dart';

import 'add_event.dart';

class EventHome extends StatefulWidget {
  @override
  _EventHomeState createState() => _EventHomeState();
}

class _EventHomeState extends State<EventHome> {
  Color fav=Colors.grey[400];
  bool isfav=false;
  ScrollController _scrollController = new ScrollController();
  bool loading = true;

  List<String> mainlistId = [];
  List<double> mainlistL = [];
  List<double> mainlistG = [];
  List<String> mainlistimage = [];
  List<String> mainlistname = [];
  List<String> mainlistdate = [];
  //
  List<String> mainlistType = [];
  List<String> mainlistEventDate = [];
  List<String> mainlistdesc = [];


  List<String> listId = [];
  List<double> listL = [];
  List<double> listG = [];
  List<String> listimage = [];
  List<String> listname = [];
  List<String> listdate = [];
  //
  List<String> listType = [];
  List<String> listEventDate = [];
  List<String> listdesc = [];

  List<double> listDistance = [];
  String myIndex = "";

  @override
  void initState(){
    getData();
    _scrollController.addListener(() {
     if (_scrollController.position.extentAfter == 0){
       if (myIndex.trim() != "" && myIndex != "0") {
        EasyLoading.show(status: "جاري تحميل المزيد");
        getNextData();
       }else{
         EasyLoading.showInfo("لا يوجد المزيد" , duration: Duration(milliseconds: 600));
         
       } 
      }
    });
    super.initState();
  }
  @override
void dispose() {
    _scrollController.dispose();
    super.dispose();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('مناسبات الجيران'),
        centerTitle: true,

      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(left: 30,right: 30),
        child: BottomSheet(
            elevation: 10,
            backgroundColor: Colors.pink[900],
            onClosing: (){},
            builder: (ctx) {
              return Container(
                height: Get.height*.055,
                width: MediaQuery.of(context).size.width,
                child: TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddEvent()));
                    },
                    child: Text('إضافة مناسبة',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),)),
              );
            }),
      ),
      body: Container(
         height: MediaQuery.of(context).size.height-140,
        child: loading ?Center(child: CircularProgressIndicator(),
            ) : ListView.builder(
                shrinkWrap: true,
                controller: _scrollController,
                itemCount: listimage.length ?? 0,
                itemBuilder: (context,i){
                  return event(listimage[i] ,listname[i] , listType[i] , listdesc[i] , listEventDate[i] ,  listId[i], listDistance[i].toInt());
                },
        ),
       ),
    );
  }

  Widget event(String image, String name,String type,String desc ,String eventDate ,String id ,int distance){
    return Container(
      margin: EdgeInsets.only(top: 10,left: 8,right: 8,bottom: 10),
         padding: EdgeInsets.only(left: 18,right: 18,bottom: 20,top: 12),
      width: Get.width,
     // height: Get.height*.3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,

          )
        ]
      ),
      child:Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundImage:FirebaseImage('$image'),
                maxRadius: 25,
              ),
              Text(
                '$name',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 17),
              ),
              Column(
                    children: [
                      Text(
                    'يبعد عنك',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Row(
                        children: [
                           Text(
                    "متر",
                    style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          SizedBox(width: 5,),
                          Text(
                    "$distance",
                    style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  )
            ],
          ),
          Divider(
            height: 15,
            thickness: 2,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin:EdgeInsets.only(top: 12),
          decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(4),

              ),
                alignment: Alignment.center,
                width: Get.width*.4,
                height: Get.height*.04,
                child: Text(
                  '$type',
                  style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),textDirection: TextDirection.rtl,
                ),
              ),
              Container(
                margin:EdgeInsets.only(top: 12),
                decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(4),

              ),
                alignment: Alignment.center,
                width: Get.width*.4,
                height: Get.height*.04,
                child: Text(
                  '$eventDate',
                  style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),textDirection: TextDirection.rtl,
                ),
              ),
            ],
          ),
          SizedBox(height: 15,),

          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.pink[900],
              ),
              onPressed:() {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>EventDetails(image,name,id,distance,type,eventDate,desc)));
              } ,
              child:Text('عرض التفاصيل',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),))
        ],
      )
    );
  }

  Future getData()async{
    Geodesy geodesy = Geodesy();
    AppState appState = Provider.of<AppState>(context , listen: false);
    LatLng l1 = LatLng(appState.getlat , appState.getlong);
    double myDistance = double.parse(appState.getnearest) * 1000;
    QuerySnapshot _myDoc = await FirebaseFirestore.instance.collection('Event').get();
    if(_myDoc.size>0){
    FirebaseFirestore.instance.collection("Event").where("index", isEqualTo: (_myDoc.size-1).toString()).get().then((value){

      mainlistimage = List.from(value.docs[0]["listImage"]);
      mainlistname = List.from(value.docs[0]["listName"]);
      mainlistL = List.from(value.docs[0]["listL"]);
      mainlistG = List.from(value.docs[0]["listG"]);      
      mainlistId = List.from(value.docs[0]["listId"]);
      mainlistdate = List.from(value.docs[0]["listDate"]);

      mainlistEventDate = List.from(_myDoc.docs[0]["listEventDate"]);
      mainlistType = List.from(_myDoc.docs[0]["listType"]);
      mainlistdesc = List.from(_myDoc.docs[0]["listDesc"]);


      myIndex = (_myDoc.size-1).toString();
    }).then((value) {
      for (var i = mainlistimage.length-1; i >= 0; i--) {
      double distance = geodesy.distanceBetweenTwoGeoPoints(l1, LatLng(mainlistL[i], mainlistG[i])).toDouble();
      if (distance <= myDistance) {
      listimage.add(mainlistimage[i]);
      listname.add(mainlistname[i]);
      listL.add(mainlistL[i]);
      listG.add(mainlistG[i]);
      listId.add(mainlistId[i]);
      listdate.add(mainlistdate[i]);

      listEventDate.add(mainlistEventDate[i]);
      listType.add(mainlistType[i]);
      listdesc.add(mainlistdesc[i]);


      listDistance.add(distance);
      }
      }
    }).whenComplete((){
      setState(() {
        loading = false;
        listimage = listimage;
      });
    });
  }else{
    EasyLoading.showInfo("لا توجد منشورات", duration: Duration(milliseconds: 800));
    setState(() {
      loading = false;
    });
  }
  }


  Future getNextData()async{
    Geodesy geodesy = Geodesy();
    AppState appState = Provider.of<AppState>(context , listen: false);
    LatLng l1 = LatLng(appState.getlat , appState.getlong);
    double myDistance = double.parse(appState.getnearest) * 1000;

    mainlistimage = []; mainlistname = [];  mainlistL = []; mainlistG = [];
    mainlistdate = []; mainlistId = []; 
    
    mainlistEventDate = []; mainlistType = []; mainlistdesc = [];
    FirebaseFirestore.instance.collection("Event").where("index", isEqualTo: (int.parse(myIndex) - 1).toString()).get().then((value){
      mainlistimage = List.from(value.docs[0]["listImage"]);
      mainlistname = List.from(value.docs[0]["listName"]);
      mainlistL = List.from(value.docs[0]["listL"]);
      mainlistG = List.from(value.docs[0]["listG"]);      
      mainlistId = List.from(value.docs[0]["listId"]);
      mainlistdate = List.from(value.docs[0]["listDate"]);

      mainlistEventDate = List.from(value.docs[0]["listEventDate"]);
      mainlistType = List.from(value.docs[0]["listType"]);
      mainlistdesc = List.from(value.docs[0]["listDesc"]);

      myIndex = (int.parse(myIndex) - 1).toString();
    }).then((value) {
      for (var i = mainlistimage.length-1; i >= 0; i--) {
      double distance = geodesy.distanceBetweenTwoGeoPoints(l1, LatLng(mainlistL[i], mainlistG[i])).toDouble();
      if (distance <= myDistance) {
      listimage.add(mainlistimage[i]);
      listname.add(mainlistname[i]);
      listL.add(mainlistL[i]);
      listG.add(mainlistG[i]);
      listId.add(mainlistId[i]);
      listdate.add(mainlistdate[i]);

      listEventDate.add(mainlistEventDate[i]);
      listType.add(mainlistType[i]);
      listdesc.add(mainlistdesc[i]);


      listDistance.add(distance);
      }
      }
    }).whenComplete((){
      EasyLoading.dismiss();
      setState(() {
        listimage = listimage;
      });
    });
  }
}
