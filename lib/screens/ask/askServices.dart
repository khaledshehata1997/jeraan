import 'package:cloud_firestore/cloud_firestore.dart';

Future askServicesUpdate(image,age,jop,name,post,phone,lat,long,date,id , docid)async{
Map<String,dynamic> askMap = {
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
await FirebaseFirestore.instance.collection("Ask").doc(docid).update({
  "data" : FieldValue.arrayUnion([
  askMap
  ])                  
});
}

Future askServicesSet(image,age,jop,name,post,phone,lat,long,date,id , index)async{
Map<String,dynamic> askMap = {
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
await FirebaseFirestore.instance.collection("Ask").add({
  "index" : index,
  "data" : [askMap]        
});
}