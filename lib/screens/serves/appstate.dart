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

  //   final darkTheme = ThemeData(
  //   primaryColor: Colors.pink[900],
  //   brightness: Brightness.dark,
  //   backgroundColor: const Color(0xFF212121),
  //   accentColor: Colors.pink[900],
  //   accentIconTheme: IconThemeData(color: Colors.black),
  //   dividerColor: Colors.black12,
  // );

  // final lightTheme = ThemeData(
  //   primaryColor: Colors.pink[900],
  //   brightness: Brightness.light,
  //   backgroundColor: const Color(0xFFE5E5E5),
  //   accentColor: Colors.pink[900],
  //   accentIconTheme: IconThemeData(color: Colors.white),
  //   dividerColor: Colors.white54,
  // );

  // ThemeData _themeData;
  // ThemeData getTheme() => _themeData;
  // bool thmeTypeisDark;

  // themeNotifier() {
  //   StorageManager.readData('themeMode').then((value) {
  //     print('value read from storage: ' + value.toString());
  //     var themeMode = value ?? 'light';
  //     if (themeMode == 'light') {
  //       _themeData = lightTheme;
  //         thmeTypeisDark = false;
  //     } else {
  //       print('setting dark theme');
  //       _themeData = darkTheme;
  //       thmeTypeisDark = true;
  //     }
  //     notifyListeners();
  //   });
  // }
  // void setDarkMode() async {
  //   _themeData = darkTheme;
  //   StorageManager.saveData('themeMode', 'dark');
  //   thmeTypeisDark = true;
  //   notifyListeners();
  // }

  // void setLightMode() async {
  //   _themeData = lightTheme;
  //   StorageManager.saveData('themeMode', 'light');
  //   thmeTypeisDark = false;
  //   notifyListeners();
  // }
  // bool get getThmeTypeisDark => thmeTypeisDark ?? false; 
}
