import 'package:cloud_firestore/cloud_firestore.dart';

Future hobbyServicesUpdate(image,name,lat,long ,id, docid, desc , hobby , age)async{
Map<String,dynamic> HobbyMap = {
  "Image" : image,
  "Name" : name,
  "L" : lat,
  "G" : long,
  "Id" : id,
  "Desc" : desc,
  "Hobby" : hobby,
  "Age" : age
};
await FirebaseFirestore.instance.collection("Hobby").doc(docid).update({
  "data" : FieldValue.arrayUnion([
  HobbyMap
  ])                  
});
}

Future hobbyServicesSet(image,name,lat,long,id,index,desc , hobby , age)async{
Map<String,dynamic> HobbyMap = {
  "Image" : image,
  "Name" : name,
  "L" : lat,
  "G" : long,
  "Id" : id,
  "Desc" : desc,
  "Hobby" : hobby,
  "Age" : age
};
await FirebaseFirestore.instance.collection("Hobby").add({
  "index" : index,
  "data" : [HobbyMap]        
});
}