import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jeraan_project/screens/auth/sign_in.dart';
import 'package:jeraan_project/screens/drawer_sections/user_profile.dart';

Widget drawer(context) {
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
                          width: 70,
                          height: 70,
                          child: CircleAvatar(
                            maxRadius: 35,
                            backgroundImage: NetworkImage('https://scontent-hbe1-1.xx.fbcdn.net/v/t1.6435-9/145442707_2866291720305610_6893681363896788682_n.jpg?_nc_cat=108&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=PmFE_GfUzo8AX_CL4Nx&_nc_ht=scontent-hbe1-1.xx&oh=1a1096bb0420aeb0871ff43c0bef18c2&oe=609808D6'),
                          )),
                      SizedBox(width: 12),
                      Text("Khaled Mohamed",
                          style: TextStyle(color: Colors.pink[900], fontSize: 20))
                    ],
                  ),
                ),
                Divider(
                  thickness: 2,
                  height: 15,
                ),
                drawerCard(context, "images/user_6.png", "ملفي الشخصي", 1),
                drawerCard(context, "images/subscription.png", "نشاطي", 2),
                drawerCard(context, "images/youtube_2.png", "الاعدادات", 3),
                drawerCard(context, "images/settings.png", "عن التطبيق", 4),
                drawerCard(context, "images/logo_v_en_2.png", "الشروط والخصوصية", 5),
                drawerCard(context, "images/logo_v_en_2.png",
                    "التواصل معنا", 6),

                Container(
                    height: 80,
                    alignment: Alignment.center,
                    child: GestureDetector(
                                  onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
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
                        child: Text("Log Out",
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
  return GestureDetector(
    onTap: () {
      switch (id) {
        case 1:
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => UserProfile()));
          break;
        // case 2:
        //   Navigator.push(
        //       context, MaterialPageRoute(builder: (context) => MyPlan()));
        //   break;
        // case 3:
        //   Navigator.push(
        //       context, MaterialPageRoute(builder: (context) => Videos()));
        //   break;
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
          child: Text(text, style: TextStyle(color: Colors.black, fontSize: 18)),
        ),
        Divider(
          thickness: 1,
          height: 5,
        ),
      ],
    ),
  );
}
