import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jeraan_project/screens/help/help_home.dart';
import 'package:jeraan_project/screens/home_screen/home_screen.dart';
import 'package:jeraan_project/screens/serves/appstate.dart';
import 'package:jeraan_project/screens/serves/uploadPic.dart';
import 'package:jeraan_project/widgets/custom_text_form.dart';
import 'package:get/get.dart';
import 'package:jeraan_project/widgets/default_button.dart';
import 'package:jeraan_project/widgets/spetial_text_field.dart';
import 'package:provider/provider.dart';

import 'help_services.dart';

class AddProductHelp extends StatefulWidget {
  @override
  _AddProductHelpState createState() => _AddProductHelpState();
}

class _AddProductHelpState extends State<AddProductHelp> {
  final TextEditingController _titleController = new TextEditingController();

  final TextEditingController _descController = new TextEditingController();

  final TextEditingController _whatsController = new TextEditingController();

  File image ;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AppState appState = Provider.of<AppState>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(appState.getlocal == "ar"?'إضافة منتج':"Add Product"),
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
                      appState.getlocal == "ar"?"اسم المنتج":"Product Name",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black45,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  CustomTextForm(false, appState.getlocal == "ar"?'اسم المنتج ':"Enter Product Name",controller: _titleController,),
                  SizedBox(
                    height: Get.height*.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:15.0),
                    child: Text(
                      appState.getlocal == "ar"?"تفاصيل المنتج":"Product Details",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black45,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: SpetialCustomTextForm(

                      false, appState.getlocal == "ar"?'ادخل التفاصيل ':"Enter Product Details",controller: _descController,),
                  ),

                  SizedBox(
                    height: Get.height*.02,
                  ), Padding(
                    padding: const EdgeInsets.only(right:15.0),
                    child: Text(
                      appState.getlocal == "ar"?"رقم التواصل":"Phone",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black45,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: CustomTextForm(

                      false, appState.getlocal == "ar"?'ادخل الرفم ':"Enter Phone Number",controller: _whatsController,),
                  ),
                  SizedBox(
                    height: Get.height*.02,
                  ),
                  image == null ?
                  Container():
                  Container(
                    margin: EdgeInsets.only(bottom: Get.height*.02),
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    child: Image.file(image , fit: BoxFit.contain),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: ()async{
                        ImagePicker _picker = ImagePicker();
                        await _picker.getImage(source: ImageSource.gallery).then((value) {
                          if (value != null) {
                            setState(() {
                           image = File(value.path);
                         }); 
                          }
                        });
                      },
                      child: Container(
                        color: Colors.grey[100],
                        height: Get.height*.15,
                        width: Get.width*.4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_a_photo,color: Colors.pink[900],size: 30,),
                            SizedBox(
                              width: Get.width*.03,
                            ),
                            Text(image == null ?(appState.getlocal == "ar"?'إضافة صورة':"Add Image"): (appState.getlocal == "ar"?'تغيير الصورة':"Change image"),style: TextStyle(fontSize: 18,color: Colors.pink[900]),)
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height*.02,
                  ),
                  DefaultButton(
                    text: appState.getlocal == "ar"?'إضافة المنتج':"Add Product",
                    press: (){
                      if(_titleController.text.trim() !="" &&
                        _whatsController.text.trim() !="" &&
                        _descController.text.trim() !="" &&
                        image != null
                      ){
                        EasyLoading.show(status:appState.getlocal == "ar"?"جاري اضافة منشورك":"Adding your Post");
                        uploadFirebaseImage(image).then((boo) async{
                        if (boo != null) {
                        try{
                        // "image" : "gs://jeeran-24c62.appspot.com/main${image.path}"
                        // List<String> listId = [];
                        // List<double> listL = [];
                        // List<double> listG = [];
                        // List<String> listimage = [];
                        // List<String> listname = [];
                        // List<String> listdate = [];
                        // //
                        // List<String> listphone = [];
                        // List<String> listPhotos = [];
                        // List<String> listProduct = [];
                        // List<String> listdesc = [];
                        QuerySnapshot _myDoc = await FirebaseFirestore.instance.collection('Est3arat').get();
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

                            // listphone = List.from(_myDoc.docs[i]["listPhone"]);
                            // listPhotos = List.from(_myDoc.docs[i]["listPhotos"]);
                            // listProduct = List.from(_myDoc.docs[i]["listProduct"]);
                            // listdesc = List.from(_myDoc.docs[i]["listDesc"]);

                            // listimage.add(appState.getimage);
                            // listname.add(appState.getname);
                            // listId.add(FirebaseAuth.instance.currentUser.uid);
                            // listdate.add(DateTime.now().toString());
                            // listL.add(appState.getlat);
                            // listG.add(appState.getlong);

                            // listphone.add(_whatsController.text.trim().toString());
                            // listPhotos.add("gs://jeeran-24c62.appspot.com/main${image.path}");
                            // listProduct.add(_titleController.text.trim().toString());
                            // listdesc.add(_descController.text.trim().toString());

                            // FirebaseFirestore.instance.collection("Est3arat").doc(_myDoc.docs[i].id).update({
                            //   "listImage" : listimage,
                            //   "listName" : listname,
                            //   "listId" : listId,
                            //   "listL" : listL,
                            //   "listG" : listG,
                            //   "listDate" : listdate,
                              
                            //   "listPhone": listphone,
                            //   "listPhotos" : listPhotos,
                            //   "listProduct" : listProduct,
                            //   "listDesc" : listdesc
                            // })
                            // 
                            
                            helpServicesUpdate(appState.getimage,appState.getname,appState.getlat, appState.getlong,
                             DateTime.now().toString(), FirebaseAuth.instance.currentUser.uid ,
                            _whatsController.text.trim().toString(),"gs://jeeran-24c62.appspot.com/main${image.path}",
                            _titleController.text.trim().toString(),_descController.text.trim().toString(),
                            _myDoc.docs[i].id).then((value){
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

                            // listphone.add(_whatsController.text.trim().toString());
                            // listPhotos.add("gs://jeeran-24c62.appspot.com/main${image.path}");
                            // listProduct.add(_titleController.text.trim().toString());
                            // listdesc.add(_descController.text.trim().toString());

                            // FirebaseFirestore.instance.collection("Est3arat").add({
                            //   "index" : _myDoc.size.toString(),
                            //   "listImage" : listimage,
                            //   "listName" : listname,
                            //   "listId" : listId,
                            //   "listL" : listL,
                            //   "listG" : listG,
                            //   "listDate" : listdate,
                              
                            //   "listPhone": listphone,
                            //   "listPhotos" : listPhotos,
                            //   "listProduct" : listProduct,
                            //   "listDesc" : listdesc
                            // })
                            // 
                            // 
                              helpServicesSet(appState.getimage,appState.getname,appState.getlat, appState.getlong,
                             DateTime.now().toString(), FirebaseAuth.instance.currentUser.uid ,
                            _whatsController.text.trim().toString(),"gs://jeeran-24c62.appspot.com/main${image.path}",
                            _titleController.text.trim().toString(),_descController.text.trim().toString(),
                           _myDoc.size.toString()).then((value){
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

                            // listphone.add(_whatsController.text.trim().toString());
                            // listPhotos.add("gs://jeeran-24c62.appspot.com/main${image.path}");
                            // listProduct.add(_titleController.text.trim().toString());
                            // listdesc.add(_descController.text.trim().toString());

                            // FirebaseFirestore.instance.collection("Est3arat").add({
                            //   "index" : _myDoc.size.toString(),
                            //   "listImage" : listimage,
                            //   "listName" : listname,
                            //   "listId" : listId,
                            //   "listL" : listL,
                            //   "listG" : listG,
                            //   "listDate" : listdate,
                              
                            //   "listPhone": listphone,
                            //   "listPhotos" : listPhotos,
                            //   "listProduct" : listProduct,
                            //   "listDesc" : listdesc
                            // }).then((value){
                            //   EasyLoading.dismiss();
                            //   showDialogNow();
                            // });

                            helpServicesSet(appState.getimage,appState.getname,appState.getlat, appState.getlong,
                             DateTime.now().toString(), FirebaseAuth.instance.currentUser.uid ,
                            _whatsController.text.trim().toString(),"gs://jeeran-24c62.appspot.com/main${image.path}",
                            _titleController.text.trim().toString(),_descController.text.trim().toString(),
                           _myDoc.size.toString()).then((value){
                              EasyLoading.dismiss();
                              showDialogNow();
                            });

                        }

                        }catch(e){
                          EasyLoading.dismiss();
                          EasyLoading.showError(appState.getlocal == "ar"?"عفوا حدث خطأ ما":"sorry you request not complited", duration: Duration(milliseconds: 600));
                          print(e);
                        }
                        }
                      });
                        
                      }else{
                        EasyLoading.showInfo(appState.getlocal == "ar"?"تأكد من ملئ البيانات و إرفاق صورة":"Be sure to fill out the information and attach a photo",duration: Duration(milliseconds:900));
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
                                Image.asset('images/smile.png',width: 40,height: 30,),
                                Text(appState.getlocal == "ar"?'تم إضافة المنتج بنجاح :)':"Product added successfully :)",style: TextStyle(
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
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HelpHome()));
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



//  List<String> listId = [];
//                         List<double> listL = [];
//                         List<double> listG = [];
//                         List<String> listimage = [];
//                         List<String> listname = [];
//                         List<String> listdate = [];
//                         //
//                         List<String> listphone = [];
//                         List<String> listPhotos = [];
//                         List<String> listProduct = [];
//                         List<String> listdesc = [];
//                         QuerySnapshot _myDoc = await FirebaseFirestore.instance.collection('Est3arat').get();
//                         if(_myDoc.size>0){
//                       for (var i = 0; i < _myDoc.size; i++) {
//                         print("${_myDoc.docs[i]['index']} : ${_myDoc.size-1}");
//                         if(_myDoc.docs[i]["index"] == "${_myDoc.size-1}"){
//                           List l =  List.from(_myDoc.docs[i]["listId"]);
//                           if(l.length <= 200){
//                             listimage = List.from(_myDoc.docs[i]["listImage"]);
//                             listname = List.from(_myDoc.docs[i]["listName"]);
//                             listL = List.from(_myDoc.docs[i]["listL"]);
//                             listG = List.from(_myDoc.docs[i]["listG"]);
//                             listdate = List.from(_myDoc.docs[i]["listDate"]);
//                             listId = List.from(_myDoc.docs[i]["listId"]);

//                             listphone = List.from(_myDoc.docs[i]["listPhone"]);
//                             listPhotos = List.from(_myDoc.docs[i]["listPhotos"]);
//                             listProduct = List.from(_myDoc.docs[i]["listProduct"]);
//                             listdesc = List.from(_myDoc.docs[i]["listDesc"]);

//                             listimage.add(appState.getimage);
//                             listname.add(appState.getname);
//                             listId.add(FirebaseAuth.instance.currentUser.uid);
//                             listdate.add(DateTime.now().toString());
//                             listL.add(appState.getlat);
//                             listG.add(appState.getlong);

//                             listphone.add(_whatsController.text.trim().toString());
//                             listPhotos.add("gs://jeeran-24c62.appspot.com/main${image.path}");
//                             listProduct.add(_titleController.text.trim().toString());
//                             listdesc.add(_descController.text.trim().toString());

//                             FirebaseFirestore.instance.collection("Est3arat").doc(_myDoc.docs[i].id).update({
//                               "listImage" : listimage,
//                               "listName" : listname,
//                               "listId" : listId,
//                               "listL" : listL,
//                               "listG" : listG,
//                               "listDate" : listdate,
                              
//                               "listPhone": listphone,
//                               "listPhotos" : listPhotos,
//                               "listProduct" : listProduct,
//                               "listDesc" : listdesc
//                             }).then((value){
//                               EasyLoading.dismiss();
//                               showDialogNow();
//                             });
//                           }else{
                            
//                           }
//                         }
//                         break;
//                         }
                        
//                         }else{

//                         }

//                         }catch(e){
//                           EasyLoading.dismiss();
//                           EasyLoading.showError("عفوا حدث خطأ ما" , duration: Duration(milliseconds: 600));
//                         }
//                         }
//                       });
                        
//                       }else{
//                         EasyLoading.showInfo("تأكد من ملئ البيانات و إرفاق صورة",duration: Duration(milliseconds:900));
//                       }