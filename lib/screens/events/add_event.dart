import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jeraan_project/screens/events/event_home.dart';
import 'package:jeraan_project/screens/events/eventsServices.dart';
import 'package:jeraan_project/screens/home_screen/home_screen.dart';
import 'package:jeraan_project/screens/serves/appstate.dart';
import 'package:jeraan_project/widgets/custom_text_form.dart';
import 'package:get/get.dart';
import 'package:jeraan_project/widgets/default_button.dart';
import 'package:jeraan_project/widgets/spetial_text_field.dart';
import 'package:provider/provider.dart';

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final TextEditingController _titleController = new TextEditingController();

  final TextEditingController _descController = new TextEditingController();

  final TextEditingController _eventDateController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AppState appState = Provider.of<AppState>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(appState.getlocal == "ar"?'إضافة مناسبة':"Add Event"),
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
                      appState.getlocal == "ar"?"نوع المناسبة":"Event Type",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black45,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  CustomTextForm(false,appState.getlocal == "ar"? 'نوع المناسبة ':"Event Type",controller: _titleController,),
                  SizedBox(
                    height: Get.height*.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:10.0),
                    child: Text(
                      appState.getlocal == "ar"?"تاريخ المناسبة":"Event Date",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black45,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  CustomTextForm(false, appState.getlocal == "ar"?'تاريخ المناسبة ':"Event Date",controller: _eventDateController,),
                  SizedBox(
                    height: Get.height*.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:15.0),
                    child: Text(
                      appState.getlocal == "ar"?"تفاصيل المناسبة":"Event Details",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black45,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: SpetialCustomTextForm(

                      false, appState.getlocal == "ar"? 'ادخل التفاصيل ' : "Event Details",controller: _descController,),
                  ),

                  SizedBox(
                    height: Get.height*.04,
                  ),

                  DefaultButton(
                    text: appState.getlocal == "ar"? 'إضافة المناسبة' : "Add Event",
                    press: ()async{
                      if(_titleController.text.trim() !="" &&
                        _eventDateController.text.trim() !="" &&
                        _descController.text.trim() !=""
                      ){
                        EasyLoading.show(status:appState.getlocal == "ar"?"جاري اضافة المناسبة" : "Adding The event");
                       
                        try{
                          // "image" : "gs://jeeran-24c62.appspot.com/main${image.path}"
                        // List<String> listId = [];
                        // List<double> listL = [];
                        // List<double> listG = [];
                        // List<String> listimage = [];
                        // List<String> listname = [];
                        // List<String> listdate = [];
                        // //
                        // List<String> listType = [];
                        // List<String> listEventDate = [];
                        // List<String> listdesc = [];

                        QuerySnapshot _myDoc = await FirebaseFirestore.instance.collection('Event').get();
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

                            // listEventDate = List.from(_myDoc.docs[i]["listEventDate"]);
                            // listType = List.from(_myDoc.docs[i]["listType"]);
                            // listdesc = List.from(_myDoc.docs[i]["listDesc"]);

                            // listimage.add(appState.getimage);
                            // listname.add(appState.getname);
                            // listId.add(FirebaseAuth.instance.currentUser.uid);
                            // listdate.add(DateTime.now().toString());
                            // listL.add(appState.getlat);
                            // listG.add(appState.getlong);

                            // listType.add(_titleController.text.trim().toString());
                            // listEventDate.add(_eventDateController.text.trim().toString());
                            // listdesc.add(_descController.text.trim().toString());
                            
                            eventServicesUpdate(appState.getimage,appState.getname,appState.getlat, appState.getlong,
                             DateTime.now().toString() , _eventDateController.text.trim().toString() , FirebaseAuth.instance.currentUser.uid ,
                              _myDoc.docs[i].id,_titleController.text.trim().toString(),_descController.text.trim().toString())
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

                            // listType.add(_titleController.text.trim().toString());
                            // listEventDate.add(_eventDateController.text.trim().toString());
                            // listdesc.add(_descController.text.trim().toString());

                            // FirebaseFirestore.instance.collection("Event").add({
                            //   "index" : _myDoc.size.toString(),
                            //   "listImage" : listimage,
                            //   "listName" : listname,
                            //   "listId" : listId,
                            //   "listL" : listL,
                            //   "listG" : listG,
                            //   "listDate" : listdate,
                              
                            //   "listEventDate" : listEventDate,
                            //   "listType" : listType,
                            //   "listDesc" : listdesc
                            // })
                            // 
                            // 
                              eventServicesSet(appState.getimage,appState.getname,appState.getlat, appState.getlong,
                             DateTime.now().toString() , _eventDateController.text.trim().toString() , FirebaseAuth.instance.currentUser.uid ,
                              _myDoc.size.toString(),_titleController.text.trim().toString(),_descController.text.trim().toString())
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

                            // listType.add(_titleController.text.trim().toString());
                            // listEventDate.add(_eventDateController.text.trim().toString());
                            // listdesc.add(_descController.text.trim().toString());

                            // FirebaseFirestore.instance.collection("Event").add({
                            //   "index" : _myDoc.size.toString(),
                            //   "listImage" : listimage,
                            //   "listName" : listname,
                            //   "listId" : listId,
                            //   "listL" : listL,
                            //   "listG" : listG,
                            //   "listDate" : listdate,
                              
                            //   "listEventDate" : listEventDate,
                            //   "listType" : listType,
                            //   "listDesc" : listdesc
                            // }).then((value){
                            //   EasyLoading.dismiss();
                            //   showDialogNow();
                            // });
                            eventServicesSet(appState.getimage,appState.getname,appState.getlat, appState.getlong,
                             DateTime.now().toString() , _eventDateController.text.trim().toString() , FirebaseAuth.instance.currentUser.uid ,
                              _myDoc.size.toString(),_titleController.text.trim().toString(),_descController.text.trim().toString())
                            .then((value){
                              EasyLoading.dismiss();
                              showDialogNow();
                            });

                        }

                        }catch(e){
                          EasyLoading.dismiss();
                          EasyLoading.showError(appState.getlocal == "ar"?"عفوا حدث خطأ ما" : "sorry ! an Error occure" , duration: Duration(milliseconds: 600));
                          print(e);
                        }
                       
                        
                      }else{
                        EasyLoading.showInfo(appState.getlocal == "ar"?"تأكد من ملئ البيانات":"Make sure to fill in the information",duration: Duration(milliseconds:900));
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
    AppState appState = Provider.of<AppState>(context,listen: false);
    var result =  showDialog(

                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title:Image.asset('images/text.png',width: 60,height: 50,),
                            content: Row(
                              children: [
                                Image.asset('images/smile.png',width: 40,height: 30,),
                                Text(appState.getlocal == "ar"?'تم إضافة المناسبة بنجاح :)':"Event added successfully :)",style: TextStyle(
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
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>EventHome()));
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