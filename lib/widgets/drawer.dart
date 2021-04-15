import 'package:flutter/material.dart';

Widget drawer(context) {
  return Drawer(
      child: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 120,
                  child: Row(
                    children: [
                      Container(
                          width: 50,
                          height: 50,
                          child: CircleAvatar(
                              child: Image(
                                  image: AssetImage("images/book_5.png")))),
                      SizedBox(width: 12),
                      Text("Mohamed Ahmed",
                          style: TextStyle(color: Colors.black45, fontSize: 20))
                    ],
                  ),
                ),
                Divider(
                  thickness: 2,
                  height: 5,
                ),
                drawerCard(context, "images/user_6.png", "My Profile", 1),
                drawerCard(context, "images/subscription.png", "My Plan", 2),
                drawerCard(context, "images/youtube_2.png", "Videos", 3),
                drawerCard(context, "images/settings.png", "Settings", 4),
                drawerCard(context, "images/logo_v_en_2.png", "About us", 5),
                drawerCard(context, "images/logo_v_en_2.png",
                    "Terms and Condetions", 6),
                drawerCard(
                    context, "images/logo_v_en_2.png", "Privacy policy", 7),
                drawerCard(context, "images/email_2.png", "Contact Us", 8),
                Container(
                    height: 80,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      //             onTap: (){
                      //               logOut(context).then((value) {
                      //                 Navigator.pushAndRemoveUntil(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => SignIn()),
                      //   (Route<dynamic> route) => false,
                      // );
                      //               });
                      //             },
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xffe02020)),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage("images/logout_3.png"),
                              width: 22,
                              height: 22,
                            ),
                            SizedBox(width: 12),
                            Text("Log Out",
                                style: TextStyle(
                                    color: Color(0xffe02020),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600))
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          )));
}

Widget drawerCard(context, imageurl, text, id) {
  return GestureDetector(
    onTap: () {
      // switch (id) {
      //   case 1:
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => MyProfile()));
      //     break;
      //   case 2:
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => MyPlan()));
      //     break;
      //   case 3:
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => Videos()));
      //     break;
      //   case 4:
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => Settings()));
      //     break;
      //   case 5:
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => AboutUs()));
      //     break;
      //   case 6:
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => Terms()));
      //     break;
      //   case 7:
      //     Navigator.push(context,
      //         MaterialPageRoute(builder: (context) => PrivacyPolicy()));
      //     break;
      //   case 8:
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => ContactUs()));
      //     break;
      // }
    },
    child: Column(
      children: [
        Container(
          color: Color(0xfffdfdfd),
          height: 45,
          child: Row(
            children: [
              Image(
                image: AssetImage(imageurl),
                width: 20,
                height: 20,
              ),
              SizedBox(width: 12),
              Text(text, style: TextStyle(color: Colors.black45, fontSize: 18))
            ],
          ),
        ),
        Divider(
          thickness: 2,
          height: 5,
        ),
      ],
    ),
  );
}
