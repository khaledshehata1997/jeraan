import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jeraan_project/screens/events/event_home.dart';
import 'package:jeraan_project/screens/home_screen/home_screen.dart';
import 'package:jeraan_project/screens/serves/appstate.dart';
import 'package:jeraan_project/widgets/custom_text_form.dart';
import 'package:get/get.dart';
import 'package:jeraan_project/widgets/default_button.dart';
import 'package:jeraan_project/widgets/spetial_text_field.dart';
import 'package:provider/provider.dart';

class EditEvent extends StatefulWidget {
  final String image, name, type, desc , date , eventDate , id;
  final int distance;
  final String docId;
  final double lat , long;
  EditEvent(this.image,this.name,this.id,this.distance,this.date,this.docId,this.lat,this.long , this.eventDate , this.desc,this.type);
  @override
  _EditEventState createState() => _EditEventState(this.image,this.name,this.id,this.distance,this.date,this.docId,this.lat,this.long , this.eventDate , this.desc,this.type);
}

class _EditEventState extends State<EditEvent> {
  final String image, name, type, desc , date , eventDate , id;
  final int distance;
  final String docId;
  final double lat , long;
  _EditEventState(this.image,this.name,this.id,this.distance,this.date,this.docId,this.lat,this.long , this.eventDate , this.desc,this.type);

  TextEditingController _titleController = new TextEditingController();

  TextEditingController _descController = new TextEditingController();

  TextEditingController _eventDateController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _titleController = TextEditingController(text: type);
    _descController = TextEditingController(text: desc);
    _eventDateController = TextEditingController(text: eventDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppState appState = Provider.of<AppState>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(appState.getlocal == "ar"?'تعديل مناسبة':"Edit Event"),
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
                    text: appState.getlocal == "ar"? 'تعديل المناسبة' : "Edit Event",
                    press: ()async{
                      if(_titleController.text.trim() !="" &&
                        _eventDateController.text.trim() !="" &&
                        _descController.text.trim() !=""
                      ){
                        EasyLoading.show(status:appState.getlocal == "ar"?"جاري تعديل المناسبة" : "Editing The event");
                       
                      
                            var ref = FirebaseFirestore.instance.collection("Event").doc(docId);

                            Map<String,dynamic> beforeEventMap = {
                            "Image" : image,
                            "Name" : name,
                            "L" : lat,
                            "G" : long,
                            "Date" : date,
                            "EventDate" : eventDate,
                            "Id" : id,
                            "Type" : type,
                            "Desc" : desc
                          };
                          ref.update({
                          "data": FieldValue.arrayRemove([
                            beforeEventMap
                          ]
                          )});

                            Map<String,dynamic> askMap = {
                              "Image" : image,
                              "Name" : name,
                              "L" : appState.getlat,
                              "G" : appState.getlong,
                              "Date" : DateTime.now().toString(),
                              "EventDate" : _eventDateController.text.trim(),
                              "Id" : id,
                              "Type" : _titleController.text.trim(),
                              "Desc" : _descController.text.trim()
                          };
                          ref.update({
                          "data": FieldValue.arrayUnion([
                            askMap
                          ]
                          )})
                            .then((value){
                              EasyLoading.dismiss();
                              showDialogNow();
                            });
                       
                        
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
                                Text(appState.getlocal == "ar"?'تم تعديل المناسبة بنجاح :)':"Event ِEdited successfully :)",style: TextStyle(
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