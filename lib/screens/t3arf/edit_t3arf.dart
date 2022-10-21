import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jeraan_project/screens/home_screen/home_screen.dart';
import 'package:jeraan_project/screens/serves/appstate.dart';
import 'package:jeraan_project/screens/t3arf/t3arf_home.dart';
import 'package:jeraan_project/screens/t3arf/t3arf_services.dart';
import 'package:jeraan_project/widgets/custom_text_form.dart';
import 'package:get/get.dart';
import 'package:jeraan_project/widgets/default_button.dart';
import 'package:jeraan_project/widgets/spetial_text_field.dart';
import 'package:provider/provider.dart';

class EditPostT3arf extends StatefulWidget {
  final String image, name, age, job, text, phone, id , date , docId;
  final int distance ;
  final double lat, long;
  EditPostT3arf(this.image,this.name,this.age,this.job,this.text,this.phone,this.id,this.distance,this.date,this.docId,this.lat,this.long);
  @override
  _EditPostT3arfState createState() => _EditPostT3arfState(this.image,this.name,this.age,this.job,this.text,this.phone,this.id,this.distance,this.date,this.docId,this.lat,this.long);
}

class _EditPostT3arfState extends State<EditPostT3arf> {
  final String image, name, age, job, text, phone, id , date , docId;
  final int distance ;
  final double lat, long;
  _EditPostT3arfState(this.image,this.name,this.age,this.job,this.text,this.phone,this.id,this.distance,this.date,this.docId,this.lat,this.long);
  TextEditingController _ageController = new TextEditingController();

  TextEditingController _jobController = new TextEditingController();

  TextEditingController _whatsController = new TextEditingController();

  TextEditingController _postController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    AppState appState = Provider.of<AppState>(context,listen: false);
    DateTime dateOfBirth = DateTime(int.parse(appState.getage[0]),int.parse(appState.getage[1]),int.parse(appState.getage[2]));
    String age = ((DateTime.now().difference(dateOfBirth).inDays / 365.25).floor()).toString();
    _ageController = TextEditingController(text: age);
    _jobController = TextEditingController(text: appState.getjop);
    _whatsController = TextEditingController(text: appState.getphone);
    _postController = TextEditingController(text: text);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    AppState appState = Provider.of<AppState>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(appState.getlocal == "ar"?'تعديل منشور':"Edit Post"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right:10.0),
                    child: Text(
                      appState.getlocal == "ar"?"العمر":"Age",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black45,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  CustomTextForm(false, appState.getlocal == "ar"?'العمر':"Age",controller: _ageController,),
                  SizedBox(
                    height: Get.height*.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:10.0),
                    child: Text(
                      appState.getlocal == "ar"?"الوظيفة":"Job",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black45,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  CustomTextForm(false, appState.getlocal == "ar"?'الوظيفة':"Job",controller: _jobController,),
                  SizedBox(
                    height: Get.height*.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:10.0),
                    child: Text(
                      appState.getlocal == "ar"?"رقم التواصل":"Phone",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black45,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  CustomTextForm(false, appState.getlocal == "ar"?'رقم التواصل':"Phone",controller: _whatsController,),
                  SizedBox(
                    height: Get.height*.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:15.0),
                    child: Text(
                      appState.getlocal == "ar"?"المنشور":"Post",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black45,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: SpetialCustomTextForm(

                      false, appState.getlocal == "ar"?'ادخل المنشور':"Write the post",controller: _postController,),
                  ),


                  SizedBox(
                    height: Get.height*.05,
                  ),
                  DefaultButton(
                    text: appState.getlocal == "ar"?'تعديل المنشور':"Edit The Post",
                    press: ()async{
                      bool success = false;
                      EasyLoading.show(status:appState.getlocal == "ar"?"جاري تعديل منشورك":"Editing your Post");
                      // await FirebaseFirestore.instance.collection("T3arf").add({
                      //   "uid" : FirebaseAuth.instance.currentUser.uid,
                      //   "image" : appState.getimage,
                      //   "name" : appState.getname,
                      //   "age" : _ageController.text.trim().toString(),
                      //   "jop" : _jobController.text.trim().toString(),
                      //   "phone" : _whatsController.text.trim().toString(),
                      //   "post" : _postController.text.trim().toString(),
                      // }).then((value){
                      //   setState(() {
                      //     success = true;
                      //   });
                      // });
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
                      QuerySnapshot _myDoc = await FirebaseFirestore.instance.collection('T3arf').get();
                      if(_myDoc.size>0){
                      for (var i = 0; i < _myDoc.size; i++) {
                        print("${_myDoc.docs[i]['index']} : ${_myDoc.size-1}");
                        if(_myDoc.docs[i]["index"] == "${_myDoc.size-1}"){
                          List l =  List.from(_myDoc.docs[i]["data"]);
                          if(l.length <= 200){
                            // listimage = List.from(_myDoc.docs[i]["listImage"]);
                            // listage = List.from(_myDoc.docs[i]["listAge"]);
                            // listjop = List.from(_myDoc.docs[i]["listJops"]);
                            // listname = List.from(_myDoc.docs[i]["listName"]);
                            // listpost = List.from(_myDoc.docs[i]["listPost"]);
                            // listphone = List.from(_myDoc.docs[i]["listPhone"]);
                            // listL = List.from(_myDoc.docs[i]["listL"]);
                            // listG = List.from(_myDoc.docs[i]["listG"]);
                            // listdate = List.from(_myDoc.docs[i]["listDate"]);
                            // listId = List.from(_myDoc.docs[i]["listId"]);
                            // listimage.add(appState.getimage);
                            // listage.add(_ageController.text.trim().toString());
                            // listjop.add(_jobController.text.trim().toString());
                            // listname.add(appState.getname);
                            // listpost.add(_postController.text.trim().toString());
                            // listphone.add(_whatsController.text.trim().toString());
                            // listId.add(FirebaseAuth.instance.currentUser.uid);
                            // listdate.add(DateTime.now().toString());
                            // listL.add(appState.getlat);
                            // listG.add(appState.getlong);
                            // FirebaseFirestore.instance.collection("T3arf").doc(_myDoc.docs[i].id).update({
                            //   "listImage" : listimage,
                            //   "listAge" : listage,
                            //   "listJops" : listjop,
                            //   "listName" : listname,
                            //   "listPost" : listpost,
                            //   "listPhone": listphone,
                            //   "listL" : listL,
                            //   "listG" : listG,
                            //   "listDate" : listdate,
                            //   "listId" : listId
                            // })
                            // 
                            var ref = FirebaseFirestore.instance.collection("T3arf").doc(docId);
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
                          });
                            t3arfServicesUpdate(appState.getimage, _ageController.text.trim().toString(), _jobController.text.trim().toString(),
                             appState.getname, _postController.text.trim().toString(), _whatsController.text.trim().toString(),
                              appState.getlat, appState.getlong, DateTime.now().toString(), FirebaseAuth.instance.currentUser.uid , _myDoc.docs[i].id)
                              .then((value){
                              EasyLoading.dismiss();
                              var result =  showDialog(

                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title:Image.asset('images/text.png',width: 60,height: 50,),
                            content: Row(
                              children: [
                                Image.asset('images/smile.png',width: 40,height: 30,),
                                Text(appState.getlocal == "ar"?'تم تعديل المنشور بنجاح :)':"Post Edited successfully :)",style: TextStyle(
                                    fontSize: appState.getlocal == "ar"?19:15,color:Colors.pink[900] ),textDirection: TextDirection.rtl,),
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            actions: [
                              TextButton(
                                child: Text(appState.getlocal == "ar"?'الرجوع الي القائمة السابقة':"Return to the previous menu",style: TextStyle(
                                    fontSize: appState.getlocal == "ar"? 15 : 13.5,color:Colors.black),textDirection: TextDirection.rtl,),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>T3arfHome()));
                                },
                              ),
                              TextButton(
                                child: Text(appState.getlocal == "ar"?'الذهاب الي القائمة الرئيسيه':'Go to main menu',style: TextStyle(
                                    fontSize: appState.getlocal == "ar"? 15 : 13.5,color:Colors.black),textDirection: TextDirection.rtl,),
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
                                },
                              ),
                            ],
                          );
                        },
                      );
                            });
                          }else{
                            // listimage.add(appState.getimage);
                            // listage.add(_ageController.text.trim().toString());
                            // listjop.add(_jobController.text.trim().toString());
                            // listname.add(appState.getname);
                            // listpost.add(_postController.text.trim().toString());
                            // listphone.add(_whatsController.text.trim().toString());
                            // listId.add(FirebaseAuth.instance.currentUser.uid);
                            // listdate.add(DateTime.now().toString());
                            // listL.add(appState.getlat);
                            // listG.add(appState.getlong);
                            // FirebaseFirestore.instance.collection("T3arf").add({
                            //   "index" : _myDoc.size.toString(),
                            //   "listImage" : listimage,
                            //   "listAge" : listage,
                            //   "listJops" : listjop,
                            //   "listName" : listname,
                            //   "listPost" : listpost,
                            //   "listPhone": listphone,
                            //   "listL" : listL,
                            //   "listG" : listG,
                            //   "listDate" : listdate,
                            //   "listId" : listId
                            // }).then((value){
                              var ref = FirebaseFirestore.instance.collection("T3arf").doc(docId);
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
                          });
                              t3arfServicesSet(appState.getimage, _ageController.text.trim().toString(), _jobController.text.trim().toString(),
                             appState.getname, _postController.text.trim().toString(), _whatsController.text.trim().toString(),
                              appState.getlat, appState.getlong, DateTime.now().toString(), FirebaseAuth.instance.currentUser.uid , _myDoc.size.toString())
                            .then((value){
                              EasyLoading.dismiss();
                              var result =  showDialog(

                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title:Image.asset('images/text.png',width: 60,height: 50,),
                            content: Row(
                              children: [
                                Image.asset('images/smile.png',width: 40,height: 30,),
                                Text(appState.getlocal == "ar"?'تم تعديل المنشور بنجاح :)':"Post Edited successfully :)",style: TextStyle(
                                    fontSize: appState.getlocal == "ar"?19:15,color:Colors.pink[900] ),textDirection: TextDirection.rtl,),
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            actions: [
                              TextButton(
                                child: Text(appState.getlocal == "ar"?'الرجوع الي القائمة السابقة':"Return to the previous menu",style: TextStyle(
                                    fontSize: appState.getlocal == "ar"? 15 : 13.5,color:Colors.black),textDirection: TextDirection.rtl,),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>T3arfHome()));
                                },
                              ),
                              TextButton(
                                child: Text(appState.getlocal == "ar"?'الذهاب الي القائمة الرئيسيه':'Go to main menu',style: TextStyle(
                                    fontSize: appState.getlocal == "ar"? 15 : 13.5,color:Colors.black),textDirection: TextDirection.rtl,),
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
                                },
                              ),
                            ],
                          );
                        },
                      );
                            });
                          }
                          break;
                        }
                      }
                      }else{
                        // listimage.add(appState.getimage);
                        //     listage.add(_ageController.text.trim().toString());
                        //     listjop.add(_jobController.text.trim().toString());
                        //     listname.add(appState.getname);
                        //     listpost.add(_postController.text.trim().toString());
                        //     listphone.add(_whatsController.text.trim().toString());
                        //     listId.add(FirebaseAuth.instance.currentUser.uid);
                        //     listdate.add(DateTime.now().toString());
                        //     listL.add(appState.getlat);
                        //     listG.add(appState.getlong);
                        //     FirebaseFirestore.instance.collection("T3arf").add({
                        //       "index" : _myDoc.size.toString(),
                        //       "listImage" : listimage,
                        //       "listAge" : listage,
                        //       "listJops" : listjop,
                        //       "listName" : listname,
                        //       "listPost" : listpost,
                        //       "listPhone": listphone,
                        //       "listL" : listL,
                        //       "listG" : listG,
                        //       "listDate" : listdate,
                        //       "listId" : listId
                        //     }).then((value){
                          var ref = FirebaseFirestore.instance.collection("T3arf").doc(docId);
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
                          });
                          t3arfServicesSet(appState.getimage, _ageController.text.trim().toString(), _jobController.text.trim().toString(),
                             appState.getname, _postController.text.trim().toString(), _whatsController.text.trim().toString(),
                              appState.getlat, appState.getlong, DateTime.now().toString(), FirebaseAuth.instance.currentUser.uid,_myDoc.size.toString())
                            .then((value){
                              EasyLoading.dismiss();
                              var result =  showDialog(

                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title:Image.asset('images/text.png',width: 60,height: 50,),
                            content: Row(
                              children: [
                                Image.asset('images/smile.png',width: 40,height: 30,),
                                Text(appState.getlocal == "ar"?'تم تعديل المنشور بنجاح :)':"Post Edited successfully :)",style: TextStyle(
                                    fontSize: appState.getlocal == "ar"?19:15,color:Colors.pink[900] ),textDirection: TextDirection.rtl,),
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            actions: [
                              TextButton(
                                child: Text(appState.getlocal == "ar"?'الرجوع الي القائمة السابقة':"Return to the previous menu",style: TextStyle(
                                    fontSize: appState.getlocal == "ar"? 15 : 13.5,color:Colors.black),textDirection: TextDirection.rtl,),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>T3arfHome()));
                                },
                              ),
                              TextButton(
                                child: Text(appState.getlocal == "ar"?'الذهاب الي القائمة الرئيسيه':'Go to main menu',style: TextStyle(
                                    fontSize: appState.getlocal == "ar"? 15 : 13.5,color:Colors.black),textDirection: TextDirection.rtl,),
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
                                },
                              ),
                            ],
                          );
                        },
                      );
                            });

                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}