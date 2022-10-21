import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geodesy/geodesy.dart';
import 'package:get/get.dart';
import 'package:jeraan_project/screens/ask/edit_post.dart';
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
  // List<String> mainlistimage = [];
  // List<String> mainlistage = [];
  // List<String> mainlistjop = [];
  // List<String> mainlistname = [];
  // List<String> mainlistpost = [];
  // List<String> mainlistphone = [];
  // List<String> mainlistId = [];
  // List<double> mainlistL = [];
  // List<double> mainlistG = [];
  // List<String> mainlistdate = [];
  // List<String> listdate = [];
  // List<double> listL = [];
  // List<double> listG = [];
  // List<String> listimage = [];
  // List<String> listage = [];
  // List<String> listjop = [];
  // List<String> listname = [];
  // List<String> listpost = [];
  // List<String> listphone = [];
  // List<String> listId = [];
  List<String> docId = [];
  List<double> listDistance = [];

  List<Map> listData = [];
  List<Map> mainListData = [];
  String myIndex = "";
  @override
  void initState(){
    AppState appState = Provider.of<AppState>(context , listen: false);
    GetData();
    _scrollController.addListener(() {
     if (_scrollController.position.extentAfter == 0){
       if (myIndex.trim() != "" && myIndex != "0") {
        EasyLoading.show(status: appState.getlocal == "ar"? "جاري تحميل المزيد":"Loading ..");
        GetNextData();
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

  Future GetData()async{
    Geodesy geodesy = Geodesy();
    AppState appState = Provider.of<AppState>(context , listen: false);
    LatLng l1 = LatLng(appState.getlat , appState.getlong);
    double myDistance = double.parse(appState.getnearest) * 1000;
    QuerySnapshot _myDoc = await FirebaseFirestore.instance.collection('Ask').get();
    if(_myDoc.size>0){
    FirebaseFirestore.instance.collection("Ask").where("index", isEqualTo: (_myDoc.size-1).toString()).get().then((value){
      mainListData = List.from(value.docs[0]["data"]);
      // mainlistimage = List.from(value.docs[0]["listImage"]);
      // mainlistage = List.from(value.docs[0]["listAge"]);
      // mainlistjop = List.from(value.docs[0]["listJops"]);
      // mainlistname = List.from(value.docs[0]["listName"]);
      // mainlistpost = List.from(value.docs[0]["listPost"]);
      // mainlistphone = List.from(value.docs[0]["listPhone"]);
      // mainlistL = List.from(value.docs[0]["listL"]);
      // mainlistG = List.from(value.docs[0]["listG"]);      
      // mainlistId = List.from(value.docs[0]["listId"]);
      // mainlistdate = List.from(value.docs[0]["listDate"]);
      myIndex = (_myDoc.size-1).toString();
      
      for (var i = mainListData.length-1; i >= 0; i--) {
      double distance = geodesy.distanceBetweenTwoGeoPoints(l1, LatLng(mainListData[i]["L"], mainListData[i]["G"])).toDouble();
      if (distance <= myDistance) {
      listDistance.add(distance);
      docId.add(value.docs[0].id);
      listData.add(mainListData[i]);
      }
      }
      if (mainListData.length < 2) {
        GetNextData();
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

  Future GetNextData()async{
    Geodesy geodesy = Geodesy();
    AppState appState = Provider.of<AppState>(context , listen: false);
    LatLng l1 = LatLng(appState.getlat , appState.getlong);
    double myDistance = double.parse(appState.getnearest) * 1000;
    mainListData = [];
    FirebaseFirestore.instance.collection("Ask").where("index", isEqualTo: (int.parse(myIndex) - 1).toString()).get().then((value){
      // mainlistimage = List.from(value.docs[0]["listImage"]);
      // mainlistage = List.from(value.docs[0]["listAge"]);
      // mainlistjop = List.from(value.docs[0]["listJops"]);
      // mainlistname = List.from(value.docs[0]["listName"]);
      // mainlistpost = List.from(value.docs[0]["listPost"]);
      // mainlistphone = List.from(value.docs[0]["listPhone"]);
      // mainlistL = List.from(value.docs[0]["listL"]);
      // mainlistG = List.from(value.docs[0]["listG"]);      
      // mainlistId = List.from(value.docs[0]["listId"]);
      // mainlistdate = List.from(value.docs[0]["listDate"]);
      mainListData = List.from(value.docs[0]["data"]);
      myIndex = (int.parse(myIndex) - 1).toString();
      for (var i = mainListData.length-1; i >= 0; i--) {
      double distance = geodesy.distanceBetweenTwoGeoPoints(l1, LatLng(mainListData[i]["L"], mainListData[i]["G"])).toDouble();
      if (distance <= myDistance) {
      listDistance.add(distance);
      // listL.add(mainlistL[i]);
      // listG.add(mainlistG[i]);
      // listimage.add(mainlistimage[i]);
      // listage.add(mainlistage[i]);
      // listjop.add(mainlistjop[i]);
      // listname.add(mainlistname[i]);
      // listpost.add(mainlistpost[i]);
      // listphone.add(mainlistphone[i]);
      // listId.add(mainlistId[i]);
      // listdate.add(mainlistdate[i]);
      docId.add(value.docs[0].id);
      listData.add(mainListData[i]);
      }
      }
    }).whenComplete((){
      EasyLoading.dismiss();
      setState(() {
        listData = listData;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    AppState appState = Provider.of<AppState>(context);
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
                      child: Text(appState.getlocal == "ar"?'إضافة استشارة':"Add Question",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),)),
                );
              }),
        ),
      appBar: AppBar(
        title: Text(appState.getlocal == "ar"?'استشارات الجيران ':"Ask your neighbors"),
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
                    appState.getlocal == "ar"?'رجاءا من مسئول التطبيق : لا تستخدم هذه الخاصية في إزعاج غيرك من الجيران وراقب الله في افعالك.':'Please from the application administrator: Do not use this feature to annoy other neighbors and watch God in your actions.',
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
                itemCount: listData.length ?? 0,
                itemBuilder: (context,i){
                  return Ask(listData[i]["Image"], listData[i]["Name"], listData[i]["Age"], listData[i]["Jops"], listData[i]["Post"], listData[i]["Phone"], listData[i]["Id"] , listDistance[i].toInt() , listData[i]["Date"] , docId[i] , listData[i]["L"] , listData[i]["G"]);
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

  Widget Ask(String image,String name,String age,String job,String text,String phone,String id , int distance , String date , String docId , double lat,double long){
    AppState appState = Provider.of<AppState>(context , listen: false);
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
                

                // IconButton(icon: Icon(Icons.favorite,color: fav,size: 30,), onPressed: (){
                //   setState(() {
                //     isfav= !isfav;
                //     isfav?fav=Colors.grey[400]:fav=Colors.red;
                //   });
                // })
                id == FirebaseAuth.instance.currentUser.uid ?  Row(
                    children: [
                      IconButton(
                        onPressed: (){
                          var ref = FirebaseFirestore.instance.collection("Ask").doc(docId);
                          Map<String,dynamic> beforeAskMap = {
                            "Image" : image,
                            "Age" : age,
                            "Jops" : job,
                            "Name" : name,
                            "Post" : text,
                            "Phone": phone,
                            "L" : lat,
                            "G" : long,
                            "Date" : date,
                            "Id" : id
                          };
                          ref.update({
                          "data": FieldValue.arrayRemove([
                            beforeAskMap
                          ]
                          )
                          }).then((value){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AskHome()));
                          });

                      }, icon: Icon(Icons.delete ,)),


                       IconButton(onPressed: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>EditPostAsk(image,name,age,job,text,phone,id,distance,date,docId,lat,long)));
                          
                      }, icon: Icon(Icons.edit , )),
                    ],
                  ) : 
                  Column(
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
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(appState.getlocal == "ar"?'العمر : ' : ' : Age',textDirection: TextDirection.rtl,style: TextStyle(
                fontSize: 17,fontWeight: FontWeight.bold
              ),),
              Text('$age',textDirection: TextDirection.rtl,style: TextStyle(
                fontSize: 17
              ),),
              
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(appState.getlocal == "ar"?'الوظيفة :  ':' : Jop',textDirection: TextDirection.rtl,style: TextStyle(
                fontSize: 17,fontWeight: FontWeight.bold
              ),),
              Text('$job',textDirection: TextDirection.rtl,style: TextStyle(
                fontSize: 17
              ),),
              
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(different == 0 ? (appState.getlocal == "ar"?"الآن" : "Now") : (different > 0 && different < 60)?(appState.getlocal == "ar"?"قبل $different دقيقة" : "from $different minutes") : (different>=60 && hour<24)
                     ?(appState.getlocal == "ar"?"قبل $hour ساعة" : "from $hour hour") : (appState.getlocal == "ar"?"قبل $days ساعة" : "from $days day"),textDirection: TextDirection.rtl,style: TextStyle(
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
                             FlutterClipboard.copy(phone).then((value) =>EasyLoading.showSuccess((appState.getlocal == "ar"?"تم النسخ" : "Copied"),duration: Duration(milliseconds: 600)) );
                          }, icon: Icon(Icons.copy))
                        ]),
          SizedBox(height: 15,)
        ],
      ),
    );
  }
}

//snapshot.data.docs.map((doc)=>Ask(doc["image"], doc["name"], doc["age"], doc["jop"], doc["post"], doc["phone"] , doc["uid"])).toList()