import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geodesy/geodesy.dart';
import 'package:jeraan_project/screens/auth/forget_password.dart';
import 'package:get/get.dart';
import 'package:jeraan_project/screens/serves/appstate.dart';
import 'package:jeraan_project/screens/t3arf/view_user_screen.dart';
import 'package:provider/provider.dart';

import 'add_product_ecommerse.dart';
class ECommerseHome extends StatefulWidget {
  @override
  _ECommerseHomeState createState() => _ECommerseHomeState();
}

class _ECommerseHomeState extends State<ECommerseHome> {
    ScrollController _scrollController = new ScrollController();
  bool loading = true;
  List<String> mainlistimage = [];
  List<String> mainlistname = [];
  List<double> mainlistL = [];
  List<double> mainlistG = [];
  List<String> mainlistId = [];
  List<String> mainlistdate = [];

  List<String> mainlistphone = [];
  List<String> mainlistPhotos = [];
  List<String> mainlistProduct = [];
  List<String> mainlistdesc = [];
  List<String> mainlistPrice = [];


  List<String> listimage = [];
  List<String> listname = [];
  List<double> listL = [];
  List<double> listG = [];
  List<String> listId = [];
  List<String> listdate = [];
  
  List<String> listphone = [];
  List<String> listPhotos = [];
  List<String> listProduct = [];
  List<String> listdesc = [];
  List<String> listPrice = [];
  
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
           Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProductEcommerse()));
            },
            child: Text('إضافة منتج',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),)),
    );
    }),
      ),
      appBar: AppBar(
        title: Text('بيع وشراء الجيران'),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height-140,
        child: loading ?Center(child: CircularProgressIndicator(),
            ) : ListView.builder(
                shrinkWrap: true,
                controller: _scrollController,
                itemCount: listimage.length ?? 0,
                itemBuilder: (context,i){
                  return post(listname[i], listimage[i] ,listPhotos[i], listProduct[i], listdesc[i], listphone[i], listdate[i], listDistance[i].toInt(), listId[i],listPrice[i]);
                },
        ),
      ),
    );
  }
  Widget post(String name, String image ,String photo,String product,String desc,String phone,String date,int distance,String id , String price){
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
                  CircleAvatar(
                    backgroundImage:FirebaseImage('$image'),
                    maxRadius: 25,
                  ),
                  Text(
                    '$name',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
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
                    radius: 35,
                    backgroundColor: Colors.pink[900],
                    child: Text(
                      '$price',
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
              Text(different == 0 ? "الآن" : (different > 0 && different < 60)?"قبل $different دقيقة" : (different>=60 && hour<24)
                     ?"قبل $hour ساعة" : "قبل $days يوم",textDirection: TextDirection.rtl,style: TextStyle(
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
                             FlutterClipboard.copy(phone).then((value) =>EasyLoading.showSuccess("تم النسخ",duration: Duration(milliseconds: 600)) );
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
    QuerySnapshot _myDoc = await FirebaseFirestore.instance.collection('Ecommerce').get();
    if(_myDoc.size>0){
    FirebaseFirestore.instance.collection("Ecommerce").where("index", isEqualTo: (_myDoc.size-1).toString()).get().then((value){

      mainlistimage = List.from(value.docs[0]["listImage"]);
      mainlistname = List.from(value.docs[0]["listName"]);
      mainlistL = List.from(value.docs[0]["listL"]);
      mainlistG = List.from(value.docs[0]["listG"]);      
      mainlistId = List.from(value.docs[0]["listId"]);
      mainlistdate = List.from(value.docs[0]["listDate"]);

      mainlistphone = List.from(value.docs[0]["listPhone"]);
      mainlistPhotos = List.from(_myDoc.docs[0]["listPhotos"]);
      mainlistProduct = List.from(_myDoc.docs[0]["listProduct"]);
      mainlistdesc = List.from(_myDoc.docs[0]["listDesc"]);
      mainlistPrice = List.from(_myDoc.docs[0]["listPrice"]);


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

      listphone.add(mainlistphone[i]);
      listPhotos.add(mainlistPhotos[i]);
      listProduct.add(mainlistProduct[i]);
      listdesc.add(mainlistdesc[i]);
      listPrice.add(mainlistPrice[i]);


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
    
    mainlistphone = []; mainlistPhotos = []; mainlistProduct=[]; mainlistdesc = []; mainlistPrice = [];
    FirebaseFirestore.instance.collection("Ecommerce").where("index", isEqualTo: (int.parse(myIndex) - 1).toString()).get().then((value){
      mainlistimage = List.from(value.docs[0]["listImage"]);
      mainlistname = List.from(value.docs[0]["listName"]);
      mainlistL = List.from(value.docs[0]["listL"]);
      mainlistG = List.from(value.docs[0]["listG"]);      
      mainlistId = List.from(value.docs[0]["listId"]);
      mainlistdate = List.from(value.docs[0]["listDate"]);

      mainlistphone = List.from(value.docs[0]["listPhone"]);
      mainlistPhotos = List.from(value.docs[0]["listPhotos"]);
      mainlistProduct = List.from(value.docs[0]["listProduct"]);
      mainlistdesc = List.from(value.docs[0]["listDesc"]);
      mainlistPrice = List.from(value.docs[0]["listPrice"]);

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

      listphone.add(mainlistphone[i]);
      listPhotos.add(mainlistPhotos[i]);
      listProduct.add(mainlistProduct[i]);
      listdesc.add(mainlistdesc[i]);
      listPrice.add(mainlistPrice[i]);


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
