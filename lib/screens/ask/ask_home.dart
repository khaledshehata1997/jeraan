import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geodesy/geodesy.dart';
import 'package:get/get.dart';
import 'package:jeraan_project/screens/serves/alerts.dart';
import 'package:jeraan_project/screens/serves/appstate.dart';
import 'package:jeraan_project/screens/t3arf/view_user_screen.dart';
import 'package:provider/provider.dart';
import 'add_post_Ask.dart';

class AskHome extends StatefulWidget {
  @override
  _AskHomeState createState() => _AskHomeState();
}

class _AskHomeState extends State<AskHome> {
  ScrollController _scrollController = new ScrollController();
  Color fav=Colors.grey[400];
  bool isfav=false;
  bool loading = true;
  List<String> mainlistimage = [];
  List<String> mainlistage = [];
  List<String> mainlistjop = [];
  List<String> mainlistname = [];
  List<String> mainlistpost = [];
  List<String> mainlistphone = [];
  List<String> mainlistId = [];
  List<double> mainlistL = [];
  List<double> mainlistG = [];
  List<String> mainlistdate = [];
  List<String> listdate = [];
  List<double> listL = [];
  List<double> listG = [];
  List<String> listimage = [];
  List<String> listage = [];
  List<String> listjop = [];
  List<String> listname = [];
  List<String> listpost = [];
  List<String> listphone = [];
  List<String> listId = [];
  List<double> listDistance = [];
  String myIndex = "";
  @override
  void initState(){
    GetData();
    _scrollController.addListener(() {
     if (_scrollController.position.extentAfter == 0){
       if (myIndex.trim() != "" && myIndex != "0") {
        EasyLoading.show(status: "جاري تحميل المزيد");
        GetNextData();
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

  Future GetData()async{
    Geodesy geodesy = Geodesy();
    AppState appState = Provider.of<AppState>(context , listen: false);
    LatLng l1 = LatLng(appState.getlat , appState.getlong);
    double myDistance = double.parse(appState.getnearest) * 1000;
    QuerySnapshot _myDoc = await FirebaseFirestore.instance.collection('Ask').get();
    if(_myDoc.size>0){
    FirebaseFirestore.instance.collection("Ask").where("index", isEqualTo: (_myDoc.size-1).toString()).get().then((value){
      mainlistimage = List.from(value.docs[0]["listImage"]);
      mainlistage = List.from(value.docs[0]["listAge"]);
      mainlistjop = List.from(value.docs[0]["listJops"]);
      mainlistname = List.from(value.docs[0]["listName"]);
      mainlistpost = List.from(value.docs[0]["listPost"]);
      mainlistphone = List.from(value.docs[0]["listPhone"]);
      mainlistL = List.from(value.docs[0]["listL"]);
      mainlistG = List.from(value.docs[0]["listG"]);      
      mainlistId = List.from(value.docs[0]["listId"]);
      mainlistdate = List.from(value.docs[0]["listDate"]);
      myIndex = (_myDoc.size-1).toString();
    }).then((value) {
      for (var i = mainlistimage.length-1; i >= 0; i--) {
      double distance = geodesy.distanceBetweenTwoGeoPoints(l1, LatLng(mainlistL[i], mainlistG[i])).toDouble();
      if (distance <= myDistance) {
      listDistance.add(distance);
      listL.add(mainlistL[i]);
      listG.add(mainlistG[i]);
      listimage.add(mainlistimage[i]);
      listage.add(mainlistage[i]);
      listjop.add(mainlistjop[i]);
      listname.add(mainlistname[i]);
      listpost.add(mainlistpost[i]);
      listphone.add(mainlistphone[i]);
      listId.add(mainlistId[i]);
      listdate.add(mainlistdate[i]);
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

  Future GetNextData()async{
    Geodesy geodesy = Geodesy();
    AppState appState = Provider.of<AppState>(context , listen: false);
    LatLng l1 = LatLng(appState.getlat , appState.getlong);
    double myDistance = double.parse(appState.getnearest) * 1000;
    mainlistimage = []; mainlistage = []; mainlistjop = [];
    mainlistname = []; mainlistpost = []; mainlistphone = [];
    mainlistL = []; mainlistG = [];
    mainlistdate = []; mainlistId = [];
    FirebaseFirestore.instance.collection("Ask").where("index", isEqualTo: (int.parse(myIndex) - 1).toString()).get().then((value){
      mainlistimage = List.from(value.docs[0]["listImage"]);
      mainlistage = List.from(value.docs[0]["listAge"]);
      mainlistjop = List.from(value.docs[0]["listJops"]);
      mainlistname = List.from(value.docs[0]["listName"]);
      mainlistpost = List.from(value.docs[0]["listPost"]);
      mainlistphone = List.from(value.docs[0]["listPhone"]);
      mainlistL = List.from(value.docs[0]["listL"]);
      mainlistG = List.from(value.docs[0]["listG"]);      
      mainlistId = List.from(value.docs[0]["listId"]);
      mainlistdate = List.from(value.docs[0]["listDate"]);
      myIndex = (int.parse(myIndex) - 1).toString();
    }).then((value) {
      for (var i = mainlistimage.length-1; i >= 0; i--) {
      double distance = geodesy.distanceBetweenTwoGeoPoints(l1, LatLng(mainlistL[i], mainlistG[i])).toDouble();
      if (distance <= myDistance) {
      listDistance.add(distance);
      listL.add(mainlistL[i]);
      listG.add(mainlistG[i]);
      listimage.add(mainlistimage[i]);
      listage.add(mainlistage[i]);
      listjop.add(mainlistjop[i]);
      listname.add(mainlistname[i]);
      listpost.add(mainlistpost[i]);
      listphone.add(mainlistphone[i]);
      listId.add(mainlistId[i]);
      listdate.add(mainlistdate[i]);
      }
      }
    }).whenComplete((){
      EasyLoading.dismiss();
      setState(() {
        listimage = listimage;
      });
    });
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
                      onPressed: ()async{
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPostAsk()));
                      },
                      child: Text('إضافة استشارة',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),)),
                );
              }),
        ),
      appBar: AppBar(
        title: Text('استشارات الجيران '),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(bottom: 50),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black
                ),
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.all(8),
                width: Get.width*.8,
                height: 100,
                child: Text(
                    'رجاءا من مسئول التطبيق : لا تستخدم هذه الخاصية في إزعاج غيرك من الجيران وراقب الله في افعالك.',
                    textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 16,color: Colors.white),),
              ),
            
            Container(
          child:loading ? Padding(
            padding: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.28),
            child: Center(child: CircularProgressIndicator(),),
          ) : Container(
            child: Container(
              height: MediaQuery.of(context).size.height-280,
              child: ListView.builder(
                shrinkWrap: true,
                controller: _scrollController,
                //physics: NeverScrollableScrollPhysics(),
                itemCount: listimage.length ?? 0,
                itemBuilder: (context,i){
                  return Ask(listimage[i], listname[i], listage[i], listjop[i], listpost[i], listphone[i], listId[i] , listDistance[i].toInt() , listdate[i]);
                },
               ),
            ),
          ),
            )
            ],
          ),
        ) 
      )
    );
  }

  Widget Ask(String image,String name,String age,String job,String text,String phone,String id , int distance , String date){
    int different = DateTime.now().difference(DateTime.parse(date)).inMinutes;
    int hour = DateTime.now().difference(DateTime.parse(date)).inHours;
    int days = DateTime.now().difference(DateTime.parse(date)).inDays;
    return Container(
      margin: EdgeInsets.all(12),
      padding: EdgeInsets.only(right: 15 ,left: 15 ,top: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 8,
            spreadRadius: 1
          )
        ]
      ),
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
                    radius: 20,
                    backgroundImage: FirebaseImage('$image'),
                  ),
                
                Text(
                  '$name',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                // IconButton(icon: Icon(Icons.favorite,color: fav,size: 30,), onPressed: (){
                //   setState(() {
                //     isfav= !isfav;
                //     isfav?fav=Colors.grey[400]:fav=Colors.red;
                //   });
                // })
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
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('$age',textDirection: TextDirection.rtl,style: TextStyle(
                fontSize: 17
              ),),
              Text('العمر :  ',textDirection: TextDirection.rtl,style: TextStyle(
                fontSize: 17,fontWeight: FontWeight.bold
              ),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('$job',textDirection: TextDirection.rtl,style: TextStyle(
                fontSize: 17
              ),),
              Text('الوظيفة :  ',textDirection: TextDirection.rtl,style: TextStyle(
                fontSize: 17,fontWeight: FontWeight.bold
              ),),
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
          SizedBox(height: Get.height*.01,),
          Divider(thickness: 2,),
          Text(' $text'

            ,style: TextStyle(fontSize: 16)
            ,textDirection: TextDirection.rtl,),
          SizedBox(height: 10,),
          Divider(thickness: 2),
          Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('images/whats.png',width:30,height: 30,),
                          ),
                          Text(
                            "$phone",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          IconButton(onPressed: (){
                             FlutterClipboard.copy(phone).then((value) =>EasyLoading.showSuccess("تم النسخ",duration: Duration(milliseconds: 600)) );
                          }, icon: Icon(Icons.copy))
                        ]),
          SizedBox(height: 15,)
        ],
      ),
    );
  }
}

//snapshot.data.docs.map((doc)=>Ask(doc["image"], doc["name"], doc["age"], doc["jop"], doc["post"], doc["phone"] , doc["uid"])).toList()