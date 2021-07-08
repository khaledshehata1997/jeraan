import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geodesy/geodesy.dart';
import 'package:get/get.dart';
import 'package:jeraan_project/screens/serves/appstate.dart';
import 'package:jeraan_project/screens/t3arf/view_user_screen.dart';
import 'package:provider/provider.dart';

import 'add_job.dart';
import 'job_datails.dart';
 class JobsHome extends StatefulWidget {
   @override
   _JobsHomeState createState() => _JobsHomeState();
 }

 class _JobsHomeState extends State<JobsHome> {
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
  List<String> mainlistAge = [];
  List<String> mainlistHobby = [];
  List<String> mainlistdesc = [];


  List<String> listId = [];
  List<double> listL = [];
  List<double> listG = [];
  List<String> listimage = [];
  List<String> listname = [];
  List<String> listdate = [];
  //
  List<String> listAge = [];
  List<String> listHobby = [];
  List<String> listdesc = [];

  List<double> listDistance = [];
  String myIndex = "";

  @override
  void initState(){
    AppState appState = Provider.of<AppState>(context , listen: false);
    getData();
    _scrollController.addListener(() {
     if (_scrollController.position.extentAfter == 0){
       if (myIndex.trim() != "" && myIndex != "0") {
        EasyLoading.show(status: appState.getlocal == "ar"? "جاري تحميل المزيد":"Loading ..");
        getNextData();
       }else{
         EasyLoading.showInfo(appState.getlocal == "ar"?"لا يوجد المزيد" : "No more posts" , duration: Duration(milliseconds: 600));
         
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
     AppState appState = Provider.of<AppState>(context);
     return Scaffold(
       appBar: AppBar(
         title: Text(appState.getlocal == "ar"?'هوايات الجيران':"Neighbors' hobbies"),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddJob()));
                     },
                     child: Text(appState.getlocal == "ar"?'إضافة هواية':"Add Hobby",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),)),
               );
             }),
       ),
       body:Container(
         height: MediaQuery.of(context).size.height-140,
        child: loading ?Center(child: CircularProgressIndicator(),
            ) : ListView.builder(
                shrinkWrap: true,
                controller: _scrollController,
                itemCount: listimage.length ?? 0,
                itemBuilder: (context,i){
                  return event(listimage[i] ,listname[i] , listHobby[i] , listdesc[i] , listAge[i] , listDistance[i].toInt(), listId[i]);
                },
        ),
       ),
     );
   }
   Widget event(String image,String name,String hobby,String desc ,String age ,int distance ,String id  ){
     AppState appState = Provider.of<AppState>(context , listen: false);
     return Container(
         margin: EdgeInsets.only(top: 10,left: 8,right: 8,bottom: 10),
         padding: EdgeInsets.only(left: 18,right: 18,bottom: 20,top: 12),
         width: Get.width,
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
             GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewUsersScreen("$id")));
                },
               child: Row(
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
                    appState.getlocal == "ar"?'يبعد عنك':"Away",  style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Row(
                        children: [
                           Text(
                    appState.getlocal == "ar"?"متر" : "m",
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
             ),
             Divider(
               height: 12,
               thickness: 2,
             ),

             Container(
               margin:EdgeInsets.only(top: 12),
               decoration: BoxDecoration(
                 color: Colors.grey[700],
                 borderRadius: BorderRadius.circular(4),

               ),
               alignment: Alignment.center,
               width: Get.width*.6,
               height: Get.height*.07,
               child: Text(
                 '$hobby',
                 style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),textDirection: TextDirection.rtl,
               ),
             ),
             SizedBox(height: 10,),

             ElevatedButton(
                 style: ElevatedButton.styleFrom(
                   primary: Colors.pink[900],
                 ),
                 onPressed:() {
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>JobDetail(image,name,id,distance,age,hobby,desc)));
                 } ,
                 child:Text(appState.getlocal == "ar"?'عرض التفاصيل':"View Details",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),))
           ],
         )
     );
   }
   Future getData()async{
    Geodesy geodesy = Geodesy();
    AppState appState = Provider.of<AppState>(context , listen: false);
    LatLng l1 = LatLng(appState.getlat , appState.getlong);
    double myDistance = double.parse(appState.getnearest) * 1000;
    QuerySnapshot _myDoc = await FirebaseFirestore.instance.collection('Hobby').get();
    if(_myDoc.size>0){
    FirebaseFirestore.instance.collection("Hobby").where("index", isEqualTo: (_myDoc.size-1).toString()).get().then((value){

      mainlistimage = List.from(value.docs[0]["listImage"]);
      mainlistname = List.from(value.docs[0]["listName"]);
      mainlistL = List.from(value.docs[0]["listL"]);
      mainlistG = List.from(value.docs[0]["listG"]);      
      mainlistId = List.from(value.docs[0]["listId"]);
      mainlistdate = List.from(value.docs[0]["listDate"]);

      mainlistHobby = List.from(_myDoc.docs[0]["listHobby"]);
      mainlistAge = List.from(_myDoc.docs[0]["listAge"]);
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

      listHobby.add(mainlistHobby[i]);
      listAge.add(mainlistAge[i]);
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
    EasyLoading.showInfo(appState.getlocal == "ar"?"لا توجد منشورات":"No posts founded", duration: Duration(milliseconds: 800));
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
    
    mainlistHobby = []; mainlistAge = []; mainlistdesc = [];
    FirebaseFirestore.instance.collection("Hobby").where("index", isEqualTo: (int.parse(myIndex) - 1).toString()).get().then((value){
      mainlistimage = List.from(value.docs[0]["listImage"]);
      mainlistname = List.from(value.docs[0]["listName"]);
      mainlistL = List.from(value.docs[0]["listL"]);
      mainlistG = List.from(value.docs[0]["listG"]);      
      mainlistId = List.from(value.docs[0]["listId"]);
      mainlistdate = List.from(value.docs[0]["listDate"]);

      mainlistHobby = List.from(value.docs[0]["listHobby"]);
      mainlistAge = List.from(value.docs[0]["listAge"]);
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

      listHobby.add(mainlistHobby[i]);
      listAge.add(mainlistAge[i]);
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
