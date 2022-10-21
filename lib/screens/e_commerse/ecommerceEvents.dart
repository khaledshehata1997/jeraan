import 'package:cloud_firestore/cloud_firestore.dart';

Future ecommerceServicesUpdate(image,name,lat,long,date,id,phone,photo,product,desc,price,docid)async{
Map<String,dynamic> ecommerceMap = {
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
  "Price" : price
};
await FirebaseFirestore.instance.collection("Ecommerce").doc(docid).update({
  "data" : FieldValue.arrayUnion([
  ecommerceMap
  ])                  
});
}

Future ecommerceServicesSet(image,name,lat,long,date,id,phone,photo,product,desc,price,index)async{
Map<String,dynamic> ecommerceMap = {
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
  "Price" : price
};
await FirebaseFirestore.instance.collection("Ecommerce").add({
  "index" : index,
  "data" : [ecommerceMap]        
});
}