import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jeraan_project/screens/serves/alerts.dart';
import 'package:jeraan_project/screens/serves/appstate.dart';
import 'package:jeraan_project/screens/serves/uploadPic.dart';
import 'package:provider/provider.dart';

class PhotoView extends StatelessWidget{
  final File img;
  PhotoView(this.img);
  @override
  Widget build(BuildContext context) {
    AppState appState = Provider.of<AppState>(context,listen: false);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Directionality(
            textDirection: TextDirection.rtl ,
            child: GestureDetector(
              onTap: (){
                uploadFirebaseImage(img).then((boo){
                  if (boo != null) {
                    try{
                  FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser.uid).update({
                  "image" : "gs://jeeran-24c62.appspot.com/main${img.path}"
                    }).whenComplete(() {
                    appState.setChanges(newimage : "gs://jeeran-24c62.appspot.com/main${img.path}");
                    EasyLoading.showSuccess("تم رفع الصورة بنجاح",duration: Duration(milliseconds: 600));
                   Navigator.pop(context);
                   Navigator.pop(context);
                  });
                  }catch(e){
                    alertToast(e);
                  }
                  }
                });
              },
              child: Container(
                width: 150,
                height: 55,
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(30)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "رفع الصورة",
                      style: TextStyle(
                      color: Colors.white, fontSize: 16)),
                    Directionality(textDirection: TextDirection.rtl ,child: Icon(Icons.send , size: 24, color: Colors.white,))
                  ],
                ),
              ),
            ),
          ),
          appBar: AppBar(title: Text("رفع صورة"),centerTitle: true,),
          body: Container(
            alignment: Alignment.center,
          color:Color(0xff000000),
          width:size.width,
          height: size.height,
          child: SingleChildScrollView(child:
           Column(
             children: <Widget>[
               Image(fit: BoxFit.fitWidth, image: FileImage(img)),
             ],
           )),
        ),
    );
  }
}