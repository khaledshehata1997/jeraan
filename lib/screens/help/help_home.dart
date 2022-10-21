import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geodesy/geodesy.dart';
import 'package:jeraan_project/screens/help/add_product_help.dart';
import 'package:jeraan_project/screens/serves/appstate.dart';
import 'package:jeraan_project/screens/t3arf/view_user_screen.dart';
import 'package:provider/provider.dart';

import 'edit_post_help.dart';

class HelpHome extends StatefulWidget {
  @override
  _HelpHomeState createState() => _HelpHomeState();
}

class _HelpHomeState extends State<HelpHome> {
  ScrollController _scrollController = new ScrollController();
  bool loading = true;
  // List<String> mainlistimage = [];
  // List<String> mainlistname = [];
  // List<double> mainlistL = [];
  // List<double> mainlistG = [];
  // List<String> mainlistId = [];
  // List<String> mainlistdate = [];

  // List<String> mainlistphone = [];
  // List<String> mainlistPhotos = [];
  // List<String> mainlistProduct = [];
  // List<String> mainlistdesc = [];


  // List<String> listimage = [];
  // List<String> listname = [];
  // List<double> listL = [];
  // List<double> listG = [];
  // List<String> listId = [];
  // List<String> listdate = [];
  
  // List<String> listphone = [];
  // List<String> listPhotos = [];
  // List<String> listProduct = [];
  // List<String> listdesc = [];

  
  // List<double> listDistance = [];
  // String myIndex = "";

  List<String> docId = [];
  List<double> listDistance = [];

  List<Map> listData = [];
  List<Map> mainListData = [];
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
    AppState appState=Provider.of<AppState>(context);
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.only(left: 30,right: 30),
        child: BottomSheet(
            elevation: 10,
            backgroundColor: Colors.pink[900],
            onClosing: (){},
            builder: (ctx) {
              return Container(
                width: MediaQuery.of(context).size.width,
                child: TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProductHelp()));
                    },
                    child: Text(appState.getlocal == "ar"?'إضافة منتج':"Add Product",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),)),
              );
            }),
      ),
      appBar: AppBar(
        title: Text(appState.getlocal == "ar"?'إستعارات الجيران':"Borrow something"),
        centerTitle: true,
      ),
      body:Container(
        height: MediaQuery.of(context).size.height-140,
        child: loading ?Center(child: CircularProgressIndicator(),
            ) : ListView.builder(
                shrinkWrap: true,
                controller: _scrollController,
                itemCount: listData.length ?? 0,
                itemBuilder: (context,i){
                  return post(listData[i]["Name"], listData[i]["Image"] ,listData[i]["Photo"], listData[i]["Product"],listData[i]["Desc"], listData[i]["Phone"], listData[i]["Date"], listDistance[i].toInt(), listData[i]["Id"], docId[i] , listData[i]["L"] , listData[i]["G"] );
                },
        ),
      ),
    );
  }
  Widget post(String name, String image ,String photo,String product,String desc,String phone,String date,int distance,String id , String docId , double lat , double long){
    print(product);
    AppState appState = Provider.of<AppState>(context , listen: false);
    int different = DateTime.now().difference(DateTime.parse(date)).inMinutes;
    int hour = DateTime.now().difference(DateTime.parse(date)).inHours;
    int days = DateTime.now().difference(DateTime.parse(date)).inDays;
    return  Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical:12 , horizontal: 18),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(spreadRadius: .5, blurRadius: 10)],
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewUsersScreen("$id")));
                },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                     children: [
                       CircleAvatar(
                        radius: 20,
                        backgroundImage: FirebaseImage('$image'),
                  ),
                  SizedBox(width: 15,),
                  Text(
                  '$name',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                     ],
                   ),
                  id == FirebaseAuth.instance.currentUser.uid ?  Row(
                    children: [
                      IconButton(
                        onPressed: (){
                          var ref = FirebaseFirestore.instance.collection("Est3arat").doc(docId);
                          Map<String,dynamic> beforeEventMap = {
                            "Image" : image,
                            "Name" : name,
                            "L" : lat,
                            "G" : long,
                            "Date" : date,
                            "Id" : id,
                            "Phone" : phone,
                            "Photo" : photo,
                            "Product" : product,
                            "Desc" : desc,
                          };
                          ref.update({
                          "data": FieldValue.arrayRemove([
                            beforeEventMap
                          ]
                          )
                          }).then((value){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HelpHome()));
                          });

                      }, icon: Icon(Icons.delete ,)),


                       IconButton(onPressed: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProductHelp(name,image , photo, product, desc, phone, date, distance, id  , docId , lat , long)));
                          
                      }, icon: Icon(Icons.edit , )),
                    ],
                  ) : Column(
                  children: [
                    Text(
                  appState.getlocal == "ar"?'يبعد عنك':"Away",style: TextStyle(
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
              thickness: 2,
            ),
             Container(
              padding: EdgeInsets.only(top:10 , right: 10 , left: 10),
              alignment: Alignment.topRight,
              child: Text(
                '$product',
                style:
                TextStyle(fontSize: 15, color: Colors.black87,fontWeight: FontWeight.w600),
                textDirection: TextDirection.rtl,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal:10),
              alignment: Alignment.topRight,
              child: Text(
                '$desc',
                style:
                TextStyle(fontSize: 13, color: Colors.grey[800]),
                textDirection: TextDirection.rtl,
              ),
            ),
            SizedBox(height:15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.pink[900],
                    child: Text(
                      'free',
                      style: TextStyle(
                          fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),
                      textDirection: TextDirection.rtl,textAlign: TextAlign.center,
                    )),
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width * .5,
                  child: Image(image:FirebaseImage('$photo'),fit: BoxFit.contain,)
                ),
              ],
            ),
            Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(different == 0 ? (appState.getlocal == "ar"?"الآن" : "Now") : (different > 0 && different < 60)?(appState.getlocal == "ar"?"قبل $different دقيقة" : "from $different minutes") : (different>=60 && hour<24)
                     ?(appState.getlocal == "ar"?"قبل $hour ساعة" : "from $hour hour") : (appState.getlocal == "ar"?"قبل $days ساعة" : "from $days day"),textDirection: TextDirection.rtl,style: TextStyle(
                fontSize: 11
              ),),
            ],
          ),
            Divider(
              thickness: 3,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .1,
                    height: MediaQuery.of(context).size.height * .04,
                    child: Image.asset('images/whats.png'),
                  ),
                  Text(
                    '$phone',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                  IconButton(onPressed: (){
                             FlutterClipboard.copy(phone).then((value) =>EasyLoading.showSuccess((appState.getlocal == "ar"?"تم النسخ" : "Copied"),duration: Duration(milliseconds: 600)) );
                          }, icon: Icon(Icons.copy))
                ]),
          ],
        ),
      ),
    );
  }
  Future getData()async{
    Geodesy geodesy = Geodesy();
    AppState appState = Provider.of<AppState>(context , listen: false);
    LatLng l1 = LatLng(appState.getlat , appState.getlong);
    double myDistance = double.parse(appState.getnearest) * 1000;
    QuerySnapshot _myDoc = await FirebaseFirestore.instance.collection('Est3arat').get();
    if(_myDoc.size>0){
    FirebaseFirestore.instance.collection("Est3arat").where("index", isEqualTo: (_myDoc.size-1).toString()).get().then((value){
      mainListData = List.from(value.docs[0]["data"]);

      // mainlistimage = List.from(value.docs[0]["listImage"]);
      // mainlistname = List.from(value.docs[0]["listName"]);
      // mainlistL = List.from(value.docs[0]["listL"]);
      // mainlistG = List.from(value.docs[0]["listG"]);      
      // mainlistId = List.from(value.docs[0]["listId"]);
      // mainlistdate = List.from(value.docs[0]["listDate"]);

      // mainlistphone = List.from(value.docs[0]["listPhone"]);
      // mainlistPhotos = List.from(_myDoc.docs[0]["listPhotos"]);
      // mainlistProduct = List.from(_myDoc.docs[0]["listProduct"]);
      // mainlistdesc = List.from(_myDoc.docs[0]["listDesc"]);


      myIndex = (_myDoc.size-1).toString();
      for (var i = mainListData.length-1; i >= 0; i--) {
      double distance = geodesy.distanceBetweenTwoGeoPoints(l1, LatLng(mainListData[i]["L"], mainListData[i]["G"])).toDouble();
      if (distance <= myDistance) {
      // listimage.add(mainlistimage[i]);
      // listname.add(mainlistname[i]);
      // listL.add(mainlistL[i]);
      // listG.add(mainlistG[i]);
      // listId.add(mainlistId[i]);
      // listdate.add(mainlistdate[i]);

      // listphone.add(mainlistphone[i]);
      // listPhotos.add(mainlistPhotos[i]);
      // listProduct.add(mainlistProduct[i]);
      // listdesc.add(mainlistdesc[i]);

      listDistance.add(distance);
      docId.add(value.docs[0].id);
      listData.add(mainListData[i]);
      }
      }
    }).whenComplete((){
      setState(() {
        loading = false;
        listData = listData;
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

    mainListData = [];

    // mainlistimage = []; mainlistname = [];  mainlistL = []; mainlistG = [];
    // mainlistdate = []; mainlistId = [];
    
    // mainlistphone = []; mainlistPhotos = []; mainlistProduct=[]; mainlistdesc = [];
    FirebaseFirestore.instance.collection("Est3arat").where("index", isEqualTo: (int.parse(myIndex) - 1).toString()).get().then((value){
      // mainlistimage = List.from(value.docs[0]["listImage"]);
      // mainlistname = List.from(value.docs[0]["listName"]);
      // mainlistL = List.from(value.docs[0]["listL"]);
      // mainlistG = List.from(value.docs[0]["listG"]);      
      // mainlistId = List.from(value.docs[0]["listId"]);
      // mainlistdate = List.from(value.docs[0]["listDate"]);

      // mainlistphone = List.from(value.docs[0]["listPhone"]);
      // mainlistPhotos = List.from(value.docs[0]["listPhotos"]);
      // mainlistProduct = List.from(value.docs[0]["listProduct"]);
      // mainlistdesc = List.from(value.docs[0]["listDesc"]);

      mainListData = List.from(value.docs[0]["data"]);
      myIndex = (int.parse(myIndex) - 1).toString();
      for (var i = mainListData.length-1; i >= 0; i--) {
      double distance = geodesy.distanceBetweenTwoGeoPoints(l1, LatLng(mainListData[i]["L"], mainListData[i]["G"])).toDouble();
      if (distance <= myDistance) {
      // listimage.add(mainlistimage[i]);
      // listname.add(mainlistname[i]);
      // listL.add(mainlistL[i]);
      // listG.add(mainlistG[i]);
      // listId.add(mainlistId[i]);
      // listdate.add(mainlistdate[i]);

      // listphone.add(mainlistphone[i]);
      // listPhotos.add(mainlistPhotos[i]);
      // listProduct.add(mainlistProduct[i]);
      // listdesc.add(mainlistdesc[i]);


      docId.add(value.docs[0].id);
      listData.add(mainListData[i]);
      listDistance.add(distance);
      }
      }
    }).whenComplete((){
      EasyLoading.dismiss();
      setState(() {
        listData = listData;
      });
    });
  }

}
