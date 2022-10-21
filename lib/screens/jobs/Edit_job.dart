import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jeraan_project/screens/home_screen/home_screen.dart';
import 'package:jeraan_project/screens/jobs/jobs_home.dart';
import 'package:jeraan_project/screens/serves/appstate.dart';
import 'package:jeraan_project/widgets/custom_text_form.dart';
import 'package:get/get.dart';
import 'package:jeraan_project/widgets/default_button.dart';
import 'package:jeraan_project/widgets/spetial_text_field.dart';
import 'package:provider/provider.dart';

import 'job_services.dart';

class EditJob extends StatefulWidget {
  final String image, name, hobby, desc , age ;
  final int distance;
  final String id , docId;
  final double lat , long ;
  EditJob(this.image,this.name,this.hobby, this.desc ,this.age, this.distance , this.id ,this.docId,this.lat,this.long);
  @override
  _EditJobState createState() => _EditJobState(this.image,this.name,this.hobby, this.desc ,this.age, this.distance , this.id ,this.docId,this.lat,this.long);
}

class _EditJobState extends State<EditJob> {
  final String image, name, hobby, desc , age ;
  final int distance;
  final String id , docId;
  final double lat , long ;
  _EditJobState(this.image,this.name,this.hobby, this.desc ,this.age, this.distance , this.id ,this.docId,this.lat,this.long);
   TextEditingController _titleController = new TextEditingController();

   TextEditingController _descController = new TextEditingController();

   TextEditingController _ageController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _titleController = TextEditingController(text: hobby);

    _descController = TextEditingController(text: desc);

    _ageController = TextEditingController(text: age);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppState appState = Provider.of<AppState>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(appState.getlocal == "ar"?'تعديل هواية':"Edit Hobby"),
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
                      appState.getlocal == "ar"?"نوع الهواية":"About Your hobby",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black45,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  CustomTextForm(false, appState.getlocal == "ar"?"نوع الهواية":"About Your hobby",controller: _titleController,),
                  SizedBox(
                    height: Get.height*.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:30.0),
                    child: Text(
                      appState.getlocal == "ar"?"العمر":"Age",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black45,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: CustomTextForm(false, appState.getlocal == "ar"?'العمر':"Age",controller: _ageController,),
                  ),
                  SizedBox(
                    height: Get.height*.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:15.0),
                    child: Text(
                      appState.getlocal == "ar"?"تفاصيل الهواية":"Hobby Details",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black45,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: SpetialCustomTextForm(

                      false, appState.getlocal == "ar"?"تفاصيل الهواية":"Hobby Details",controller: _descController,),
                  ),

                  SizedBox(
                    height: Get.height*.04,
                  ),


                  DefaultButton(
                    text: appState.getlocal == "ar"?'تعديل الهواية':"Edit Hobby",
                    press: ()async{
                      if(_titleController.text.trim() !="" &&
                        _ageController.text.trim() !="" &&
                        _descController.text.trim() !=""
                      ){
                        EasyLoading.show(status:appState.getlocal == "ar"?"جاري تعديل الهواية":"Editing the hobby ..");
                       
                        try{
                          // "image" : "gs://jeeran-24c62.appspot.com/main${image.path}"
                        // List<String> listId = [];
                        // List<double> listL = [];
                        // List<double> listG = [];
                        // List<String> listimage = [];
                        // List<String> listname = [];
                        // List<String> listdate = [];
                        // //
                        // List<String> listAge = [];
                        // List<String> listHobby = [];
                        // List<String> listdesc = [];

                        QuerySnapshot _myDoc = await FirebaseFirestore.instance.collection('Hobby').get();
                        if(_myDoc.size>0){
                      for (var i = 0; i < _myDoc.size; i++) {
                        print("${_myDoc.docs[i]['index']} : ${_myDoc.size-1}");
                        if(_myDoc.docs[i]["index"] == "${_myDoc.size-1}"){
                          List l =  List.from(_myDoc.docs[i]["data"]);
                          if(l.length <= 200){
                            // listimage = List.from(_myDoc.docs[i]["listImage"]);
                            // listname = List.from(_myDoc.docs[i]["listName"]);
                            // listL = List.from(_myDoc.docs[i]["listL"]);
                            // listG = List.from(_myDoc.docs[i]["listG"]);
                            // listdate = List.from(_myDoc.docs[i]["listDate"]);
                            // listId = List.from(_myDoc.docs[i]["listId"]);

                            // listHobby = List.from(_myDoc.docs[i]["listHobby"]);
                            // listAge = List.from(_myDoc.docs[i]["listAge"]);
                            // listdesc = List.from(_myDoc.docs[i]["listDesc"]);

                            // listimage.add(appState.getimage);
                            // listname.add(appState.getname);
                            // listId.add(FirebaseAuth.instance.currentUser.uid);
                            // listdate.add(DateTime.now().toString());
                            // listL.add(appState.getlat);
                            // listG.add(appState.getlong);


                            // listHobby.add(_titleController.text.trim().toString());
                            // listAge.add(_ageController.text.trim().toString());
                            // listdesc.add(_descController.text.trim().toString());
                            

                            // FirebaseFirestore.instance.collection("Hobby").doc(_myDoc.docs[i].id).update({
                            //   "listImage" : listimage,
                            //   "listName" : listname,
                            //   "listId" : listId,
                            //   "listL" : listL,
                            //   "listG" : listG,
                            //   "listDate" : listdate,
                              
                            //   "listHobby" : listHobby,
                            //   "listAge" : listAge,
                            //   "listDesc" : listdesc
                              
                            // })
                            // 
                            var ref = FirebaseFirestore.instance.collection("Hobby").doc(docId);
                          Map<String,dynamic> beforeHobbyMap = {
                            "Image" : image,
                            "Name" : name,
                            "L" : lat,
                            "G" : long,
                            "Id" : id,
                            "Desc" : desc,
                            "Hobby" : hobby,
                            "Age" : age
                          };
                          ref.update({
                          "data": FieldValue.arrayRemove([
                            beforeHobbyMap
                          ]
                          )
                          });
                            hobbyServicesUpdate(appState.getimage,appState.getname,appState.getlat, appState.getlong,
                              FirebaseAuth.instance.currentUser.uid ,
                              _myDoc.docs[i].id,_descController.text.trim().toString(),
                              _titleController.text.trim().toString() , _ageController.text.trim().toString())
                            .then((value){
                              EasyLoading.dismiss();
                              showDialogNow();
                            });
                          }else{
                            // listimage.add(appState.getimage);
                            // listname.add(appState.getname);
                            // listId.add(FirebaseAuth.instance.currentUser.uid);
                            // listdate.add(DateTime.now().toString());
                            // listL.add(appState.getlat);
                            // listG.add(appState.getlong);

                            // listHobby.add(_titleController.text.trim().toString());
                            // listAge.add(_ageController.text.trim().toString());
                            // listdesc.add(_descController.text.trim().toString());

                            // FirebaseFirestore.instance.collection("Hobby").add({
                            //   "index" : _myDoc.size.toString(),
                            //   "listImage" : listimage,
                            //   "listName" : listname,
                            //   "listId" : listId,
                            //   "listL" : listL,
                            //   "listG" : listG,
                            //   "listDate" : listdate,
                              
                            //   "listHobby" : listHobby,
                            //   "listAge" : listAge,
                            //   "listDesc" : listdesc
                            // })
                            // 
                            var ref = FirebaseFirestore.instance.collection("Hobby").doc(docId);
                          Map<String,dynamic> beforeHobbyMap = {
                            "Image" : image,
                            "Name" : name,
                            "L" : lat,
                            "G" : long,
                            "Id" : id,
                            "Desc" : desc,
                            "Hobby" : hobby,
                            "Age" : age
                          };
                          ref.update({
                          "data": FieldValue.arrayRemove([
                            beforeHobbyMap
                          ]
                          )
                          });
                            hobbyServicesSet(appState.getimage,appState.getname,appState.getlat, appState.getlong,
                              FirebaseAuth.instance.currentUser.uid ,
                              _myDoc.size.toString(),_descController.text.trim().toString(),
                              _titleController.text.trim().toString() , _ageController.text.trim().toString())
                              .then((value){
                              EasyLoading.dismiss();
                              showDialogNow();
                            });

                          }
                          break;
                        }
                        
                        }
                        
                        }else{
                            // listimage.add(appState.getimage);
                            // listname.add(appState.getname);
                            // listId.add(FirebaseAuth.instance.currentUser.uid);
                            // listdate.add(DateTime.now().toString());
                            // listL.add(appState.getlat);
                            // listG.add(appState.getlong);

                            // listHobby.add(_titleController.text.trim().toString());
                            // listAge.add(_ageController.text.trim().toString());
                            // listdesc.add(_descController.text.trim().toString());

                            // FirebaseFirestore.instance.collection("Hobby").add({
                            //   "index" : _myDoc.size.toString(),
                            //   "listImage" : listimage,
                            //   "listName" : listname,
                            //   "listId" : listId,
                            //   "listL" : listL,
                            //   "listG" : listG,
                            //   "listDate" : listdate,
                              
                            //   "listHobby" : listHobby,
                            //   "listAge" : listAge,
                            //   "listDesc" : listdesc
                            // }).then((value){
                            //   EasyLoading.dismiss();
                            //   showDialogNow();
                            // });
                            var ref = FirebaseFirestore.instance.collection("Hobby").doc(docId);
                          Map<String,dynamic> beforeHobbyMap = {
                            "Image" : image,
                            "Name" : name,
                            "L" : lat,
                            "G" : long,
                            "Id" : id,
                            "Desc" : desc,
                            "Hobby" : hobby,
                            "Age" : age
                          };
                          ref.update({
                          "data": FieldValue.arrayRemove([
                            beforeHobbyMap
                          ]
                          )
                          });
                            hobbyServicesSet(appState.getimage,appState.getname,appState.getlat, appState.getlong,
                              FirebaseAuth.instance.currentUser.uid ,
                              _myDoc.size.toString(),_descController.text.trim().toString(),
                              _titleController.text.trim().toString() , _ageController.text.trim().toString())
                              .then((value){
                              EasyLoading.dismiss();
                              showDialogNow();
                            });

                        }

                        }catch(e){
                          EasyLoading.dismiss();
                          EasyLoading.showError(appState.getlocal == "ar"?"عفوا حدث خطأ ما":"sorry you request not complited", duration: Duration(milliseconds: 600));
                          print(e);
                        }
                       
                        
                      }else{
                        EasyLoading.showInfo(appState.getlocal == "ar"?"تأكد من ملئ البيانات":"Be sure to fill out the information",duration: Duration(milliseconds:900));
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
  showDialogNow(){
     AppState appState = Provider.of<AppState>(context , listen: false);
    var result =  showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title:Image.asset('images/text.png',width: 60,height: 50,),
                            content: Row(
                              children: [
                                Image.asset('images/smile.png',width: 25,height: 25,),
                                Text(appState.getlocal == "ar"?'تم تعديل الهواية بنجاح :)':'Hobby Edited successfully :)',style: TextStyle(
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
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>JobsHome()));
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
  }
}