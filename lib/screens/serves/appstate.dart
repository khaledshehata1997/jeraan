import 'package:flutter/material.dart';
import 'package:jeraan_project/theme/StorageManager.dart';

class AppState with ChangeNotifier {
  AppState();
  double lat;
  double long;
  void setlocation(double la , double lon) {
    lat = la;
    long = lon;
    notifyListeners();
  }
  double get getlat => lat ;
  double get getlong => long ;
  List<String> age;
  String name , phone , image , adress , jop , nearest , about;
  void setChanges({String newname, List<String> newage, String newphone, String newimage ,String newadress, String newjop, String near , String newabout}){
    name = (newname ?? name) ?? "" ;
    age = (newage ?? age) ?? [] ;
    phone = (newphone ?? phone) ?? "";
    image = (newimage ?? image) ?? "gs://jeeran-24c62.appspot.com/391-3918613_personal-service-platform-person-icon-circle-png-transparent.png";
    adress = (newadress ?? adress) ?? "";
    jop = (newjop ?? jop) ?? "";
    nearest = (near ?? nearest) ?? "0";
    about = (newabout ?? about) ?? "";
    notifyListeners();
  }
  String get getname => name;
  List<String> get getage => age;
  String get getphone => phone;
  String get getimage => image ?? "gs://jeeran-24c62.appspot.com/391-3918613_personal-service-platform-person-icon-circle-png-transparent.png";
  String get getadress => adress;
  String get getjop => jop;
  String get getnearest => nearest;
  String get getabout => about;

  String local;
  void setLocal(String loc){
    local = (loc ?? local)?? "en";
    notifyListeners();
  }
  String get getlocal => local ?? "en";
}
