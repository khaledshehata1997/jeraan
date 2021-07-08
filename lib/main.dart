import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoder/geocoder.dart';
import 'package:jeraan_project/screens/auth/onBoarding_screen.dart';
import 'package:jeraan_project/screens/home_screen/home_screen.dart';
import 'package:jeraan_project/screens/serves/appstate.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  configLoading();
  runApp(ChangeNotifierProvider<AppState>(
      create: (_) => AppState(),
      child:MyApp()));
}
  void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true;
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  @override
  void initState() {
    if(FirebaseAuth.instance.currentUser != null){
      getLocation();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppState appState = Provider.of<AppState>(context);
    return MaterialApp(
    localizationsDelegates: [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: [
    const Locale('en', ''),
    const Locale('ar', ''),
  ],
  locale: Locale(appState.getlocal),
    debugShowCheckedModeBanner: false,
      title: 'Jeran',
      theme:// appState.getTheme(),
      ThemeData(
          primaryColor:Colors.pink[900],
          accentColor: Colors.pink[900]
      ),
      home: FirebaseAuth.instance.currentUser != null ? HomeScreen() : OnBoardingScreen(),
      builder: EasyLoading.init(),
    );
  }

    getLocation()async{
    Location location = new Location();
    try{
      _serviceEnabled = await location.serviceEnabled();
if (!_serviceEnabled) {
  _serviceEnabled = await location.requestService().then((value)=>getLocation());
  if (!_serviceEnabled) {
     _serviceEnabled = await location.requestService().then((value)=>getLocation());
  }
}
_permissionGranted = await location.hasPermission();
if (_permissionGranted == PermissionStatus.denied) {
  _permissionGranted = await location.requestPermission();
  if (_permissionGranted != PermissionStatus.granted) {
    return;
  }
}

EasyLoading.show(status: "انتظر لحظة من فضلك");
_locationData = await location.getLocation();
double lat = _locationData.latitude;
double long = _locationData.longitude;
    setlocation(lat,long);
    print("lat $lat , long $long");
    }catch(e){
       print(e);
    }
  }

    setlocation(double lat ,double long) async{
     AppState appState = Provider.of<AppState>(context ,listen: false);
     SharedPreferences prefs = await SharedPreferences.getInstance();
     appState.setLocal(prefs.getString("local"));
     appState.setlocation(lat,long);
     var addresses = await Geocoder.local.findAddressesFromCoordinates(Coordinates(lat, long));
     var first = addresses.first;
     String address = first.featureName;
      print("$address");
     FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser.uid).update({"adress" : address , "lg" : [lat,long]}).then((value) {
       FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser.uid).get().then((snapshot) {
       String name = snapshot["name"];
        List<String> age =  List.from(snapshot["age"]);
        String phone = snapshot["phone"];
        String image = snapshot["image"];
        String adress = snapshot["adress"];
        String jop = snapshot["jop"];
        String nearest = snapshot["nearest"];
        String about = snapshot["about"];
        appState.setChanges(newname: name,
        newage: age,
        newphone: phone,
        newimage: image,
        newadress: adress,
        newjop:"Job",
        near: nearest,
        newabout: about);
     });
     EasyLoading.showSuccess(appState.getlocal == "ar"? "تم تجهيز التبيق" : "Ready to use" , duration: Duration(milliseconds: 400));
     });
  }
}