import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geodesy/geodesy.dart';
import 'package:jeraan_project/screens/auth/sign_in.dart';
import 'package:jeraan_project/screens/drawer_sections/my_activity.dart';
import 'package:jeraan_project/screens/drawer_sections/settings.dart';
import 'package:jeraan_project/screens/drawer_sections/user_profile.dart';
import 'package:jeraan_project/screens/serves/appstate.dart';
import 'package:provider/provider.dart';

Widget drawer(context) {
  AppState appState = Provider.of<AppState>(context);
  return Drawer(
      child: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 130,
                  child: Row(
                    children: [
                      Container(
                          width: 60,
                          height: 60,
                          child: CircleAvatar(
                            radius: 27,
                            backgroundImage: FirebaseImage((appState.image)?? "gs://jeeran-24c62.appspot.com/391-3918613_personal-service-platform-person-icon-circle-png-transparent.png"),
                          )),
                      SizedBox(width: 12),
                      Text(appState.getname ?? "",
                          style:
                              TextStyle(color: Colors.pink[900], fontSize: 20))
                    ],
                  ),
                ),
                Divider(
                  thickness: 2,
                  height: 15,
                ),
                drawerCard(context, "images/user_6.png", appState.getlocal == "ar"?"ملفي الشخصي":"Profile", 1),
                // drawerCard(context, "images/subscription.png", "نشاطي", 2),
                drawerCard(context, "images/youtube_2.png",appState.getlocal == "ar"?"الاعدادات":"Settings", 3),
                drawerCard(context, "images/settings.png", appState.getlocal == "ar"? "عن التطبيق":"About", 4),
                drawerCard(
                    context, "images/logo_v_en_2.png", appState.getlocal == "ar"?"الشروط والخصوصية":"Terms and Privacy", 5),
                drawerCard(
                    context, "images/logo_v_en_2.png", appState.getlocal == "ar"?"التواصل معنا":"Contact us", 6),
                Container(
                    height: 80,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        FirebaseAuth.instance.signOut().then((value) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => SignIn()),
                            (Route<dynamic> route) => false,
                          );
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.pink[900]),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Text(appState.getlocal == "ar"?"تسجيل الخروج":"Log out",
                            style: TextStyle(
                                color: Colors.pink[900],
                                fontSize: 18,
                                fontWeight: FontWeight.w600)),
                      ),
                    ))
              ],
            ),
          )));
}

Widget drawerCard(context, imageurl, text, id) {
  AppState appState = Provider.of<AppState>(context ,listen: false);
  return GestureDetector(
    onTap: () {
      switch (id) {
        case 1:
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => UserProfile(true , LatLng(appState.lat, appState.long) , FirebaseAuth.instance.currentUser.uid)));
          break;
        case 2:
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyActivity()));
          break;
        case 3:
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Settings()));
          break;
        // case 4:
        //   Navigator.push(
        //       context, MaterialPageRoute(builder: (context) => Settings()));
        //   break;
        // case 5:
        //   Navigator.push(
        //       context, MaterialPageRoute(builder: (context) => AboutUs()));
        //   break;
        // case 6:
        //   Navigator.push(
        //       context, MaterialPageRoute(builder: (context) => Terms()));
        //   break;
        // case 7:
        //   Navigator.push(context,
        //       MaterialPageRoute(builder: (context) => PrivacyPolicy()));
        //   break;
        // case 8:
        //   Navigator.push(
        //       context, MaterialPageRoute(builder: (context) => ContactUs()));
        //   break;
      }
    },
    child: Column(
      children: [
        Container(
          alignment: Alignment.center,
          color: Color(0xfffdfdfd),
          height: 50,
          child:
              Text(text, style: TextStyle(color: Colors.black, fontSize: 18)),
        ),
        Divider(
          thickness: 1,
          height: 5,
        ),
      ],
    ),
  );
}
