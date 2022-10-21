import 'package:cloud_firestore/cloud_firestore.dart';

Future helpServicesUpdate(image,name,lat,long,date,id,phone,photo,product,desc,docid)async{
Map<String,dynamic> helpMap = {
  "Image" : image,
  "Name" : name,
  "L" : lat,
  "G" : long,
  "Date" : date,
  "Id" : id,
  "Phone" : phone,
  "Photo" : photo,
  "Product" : product,
  "Desc" : desc,
};
await FirebaseFirestore.instance.collection("Est3arat").doc(docid).update({
  "data" : FieldValue.arrayUnion([
  helpMap
  ])                  
});
}

Future helpServicesSet(image,name,lat,long,date,id,phone,photo,product,desc,index)async{
Map<String,dynamic> helpMap = {
  "Image" : image,
  "Name" : name,
  "L" : lat,
  "G" : long,
  "Date" : date,
  "Id" : id,
  "Phone" : phone,
  "Photo" : photo,
  "Product" : product,
  "Desc" : desc,
};
await FirebaseFirestore.instance.collection("Est3arat").add({
  "index" : index,
  "data" : [helpMap]        
});
}