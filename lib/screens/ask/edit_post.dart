import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jeraan_project/screens/home_screen/home_screen.dart';
import 'package:jeraan_project/screens/serves/appstate.dart';
import 'package:jeraan_project/widgets/custom_text_form.dart';
import 'package:get/get.dart';
import 'package:jeraan_project/widgets/default_button.dart';
import 'package:jeraan_project/widgets/spetial_text_field.dart';
import 'package:provider/provider.dart';

import 'ask_home.dart';

class EditPostAsk extends StatefulWidget {
  final String image, name, age, job, text, phone, id , date , docId;
  final int distance ;
  final double lat, long;
  EditPostAsk(this.image,this.name,this.age,this.job,this.text,this.phone,this.id,this.distance,this.date,this.docId,this.lat,this.long);
  @override
  _EditPostAskState createState() => _EditPostAskState(this.image,this.name,this.age,this.job,this.text,this.phone,this.id,this.distance,this.date,this.docId,this.lat,this.long);
}

class _EditPostAskState extends State<EditPostAsk> {
  final String image, name, age, job, text, phone, id , date , docId;
  final int distance ;
  final double lat, long;
  _EditPostAskState(this.image,this.name,this.age,this.job,this.text,this.phone,this.id,this.distance,this.date,this.docId,this.lat,this.long);
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
        title: Text(appState.getlocal == "ar"?'تعديل استشارة':"Edit Question"),
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
                  CustomTextForm(false, appState.getlocal == "ar"?"العمر":"Age",controller: _ageController,),
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
                  CustomTextForm(false, appState.getlocal == "ar"?"الوظيفة":"Job",controller: _jobController,),
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
                  CustomTextForm(false, appState.getlocal == "ar"?"رقم التواصل":"Phone",controller: _whatsController,),
                  SizedBox(
                    height: Get.height*.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:15.0),
                    child: Text(
                      appState.getlocal == "ar"?"تفاصيل الاستشارة":"your Question",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black45,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: SpetialCustomTextForm(

                      false, appState.getlocal == "ar"?"تفاصيل الاستشارة":"your Question",controller: _postController,),
                  ),


                  SizedBox(
                    height: Get.height*.05,
                  ),
                  DefaultButton(
                    text: appState.getlocal == "ar"?'تعديل استشارة':"Edit Question",
                    press: ()async{
                      bool success = false;
                      EasyLoading.show(status:appState.getlocal == "ar"?"جاري تعديل استشارتك":"Editing your Question ..");

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
                          });
                          Map<String,dynamic> askMap = {
                            "Image" : image,
                            "Age" : _ageController.text.trim(),
                            "Jops" : _jobController.text.trim(),
                            "Name" : name,
                            "Post" : _postController.text.trim(),
                            "Phone": _whatsController.text.trim(),
                            "L" : appState.getlat,
                            "G" : appState.getlong,
                            "Date" : DateTime.now().toString(),
                            "Id" : id
                          };
                          ref.update({
                          "data": FieldValue.arrayUnion([
                            askMap
                          ]
                          )
                          }).then((value){
                              EasyLoading.dismiss();
                              var result =  showDialog(

                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title:Image.asset('images/text.png',width: 60,height: 50,),
                            content: Row(
                              children: [
                                Image.asset('images/smile.png',width: 40,height: 30,),
                                Text(appState.getlocal == "ar"?'تم التعديل بنجاح :)':" Edited Successfully :) ",style: TextStyle(
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
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AskHome()));
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