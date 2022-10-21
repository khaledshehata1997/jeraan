import 'package:cloud_firestore/cloud_firestore.dart';

Future eventServicesUpdate(image,name,lat,long,date, eventDate ,id, docid , type , desc)async{
Map<String,dynamic> eventMap = {
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
await FirebaseFirestore.instance.collection("Event").doc(docid).update({
  "data" : FieldValue.arrayUnion([
  eventMap
  ])                  
});
}

Future eventServicesSet(image,name,lat,long,date, eventDate,id , index,type , desc)async{
Map<String,dynamic> eventMap = {
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
await FirebaseFirestore.instance.collection("Event").add({
  "index" : index,
  "data" : [eventMap]        
});
}