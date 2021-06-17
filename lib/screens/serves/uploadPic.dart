import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:jeraan_project/screens/serves/alerts.dart';

Future<TaskSnapshot> uploadFirebaseImage(File _file) async{
  try{
  var ref = await FirebaseStorage.instance.ref("main").child(_file.path).putFile(_file);
  return ref;
  }catch(e){
    alertToast(e);
  }
}