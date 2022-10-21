import 'package:cloud_firestore/cloud_firestore.dart';

Future t3arfServicesUpdate(image,age,jop,name,post,phone,lat,long,date,id , docid)async{
Map<String,dynamic> T3arfMap = {
  "Image" : image,
  "Age" : age,
  "Jops" : jop,
  "Name" : name,
  "Post" : post,
  "Phone": phone,
  "L" : lat,
  "G" : long,
  "Date" : date,
  "Id" : id
};
await FirebaseFirestore.instance.collection("T3arf").doc(docid).update({
  "data" : FieldValue.arrayUnion([
  T3arfMap
  ])                  
});
}

Future t3arfServicesSet(image,age,jop,name,post,phone,lat,long,date,id , index)async{
Map<String,dynamic> T3arfMap = {
  "Image" : image,
  "Age" : age,
  "Jops" : jop,
  "Name" : name,
  "Post" : post,
  "Phone": phone,
  "L" : lat,
  "G" : long,
  "Date" : date,
  "Id" : id
};
await FirebaseFirestore.instance.collection("T3arf").add({
  "index" : index,
  "data" : [T3arfMap]        
});
}