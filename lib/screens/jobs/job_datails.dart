import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeraan_project/screens/home_screen/home_screen.dart';
import 'package:jeraan_project/screens/serves/appstate.dart';
import 'package:jeraan_project/screens/t3arf/view_user_screen.dart';
import 'package:provider/provider.dart';
class JobDetail extends StatefulWidget {
  final String image;
  final String name;
  final String id;
  final int distance;
  final String age;
  final String hobby;
  final String desc;
  JobDetail(this.image,this.name,this.id,this.distance,this.age,this.hobby,this.desc);
  @override
  _JobDetailState createState() => _JobDetailState();
}

class _JobDetailState extends State<JobDetail> {
  Color fav=Colors.grey[400];

  bool isfav=false;

  @override
  Widget build(BuildContext context) {
    AppState appState = Provider.of<AppState>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(appState.getlocal == "ar"?'تفاصيل الهواية':"Hobby details"),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Container(
                margin: EdgeInsets.only(top: 10,left: 8,right: 8,bottom: 10),
                padding: EdgeInsets.only(left: 18,right: 18,bottom: 20,top: 12),
                width: Get.width,
                // height: Get.height*.3,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,

                      )
                    ]
                ),
                child:SingleChildScrollView(
                  child: Column(
                    children: [
                      GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewUsersScreen("${widget.id}")));
                },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundImage:FirebaseImage(widget.image),
                              maxRadius: 25,
                            ),
                            Text(
                              widget.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            Column(
                                          children: [
                        Text(
                                          appState.getlocal == "ar"?'يبعد عنك':"Away",                        style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        Row(
                          children: [
                             Text(
                                          appState.getlocal == "ar"?"متر" : "m",
                                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            SizedBox(width: 5,),
                            Text(
                                          "${widget.distance}",
                                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ],
                        ),
                                          ],
                                        )
                          ],
                        ),
                      ),
                      Divider(
                        height: 15,
                        thickness: 2,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin:EdgeInsets.only(top: 12),
                            decoration: BoxDecoration(
                              color: Colors.grey[700],
                              borderRadius: BorderRadius.circular(4),

                            ),
                            alignment: Alignment.center,
                            width: Get.width*.4,
                            height: Get.height*.04,
                            child: Text(
                              widget.hobby,
                              style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),textDirection: TextDirection.rtl,
                            ),
                          ),
                          Container(
                            margin:EdgeInsets.only(top: 12),
                            decoration: BoxDecoration(
                              color: Colors.grey[700],
                              borderRadius: BorderRadius.circular(4),

                            ),
                            alignment: Alignment.center,
                            width: Get.width*.4,
                            height: Get.height*.04,
                            child: Text(
                              appState.getlocal == "ar"?"${widget.age} عام":"${widget.age} year",
                              style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),textDirection: TextDirection.rtl,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8,right: 8,top: 25),
                        child: Column(
                          children: [
                            Text(
                              widget.desc,style:
                            TextStyle(fontSize: 19,color: Colors.pink[900]),textDirection: TextDirection.rtl,),
                          ],
                        ),
                      ),
                      SizedBox(height: 15,),

                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.pink[900],
                          ),
                          onPressed:() {
                            var result =  showDialog(

                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title:Image.asset('images/text.png',width: 60,height: 50,),
                                  content: Row(
                                    children: [
                                      Image.asset('images/smile.png',width: 25,height: 25,),
                                      Text(appState.getlocal == "ar"?'شكرا علي الاهتمام بهذه الهواية :)':'Thank you for your interest in this hobby :)',style: TextStyle(
                                          fontSize: appState.getlocal == "ar"? 15 : 13.5,color:Colors.pink[900] ),textDirection: TextDirection.rtl,),
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: Text(appState.getlocal == "ar"?''
                                          'إذهب الي الحساب الخاص بالمعلن واحصل علي العنوان ووسائل التواصل.':"Go to the advertiser's account and get the address and the means of communication.",style: TextStyle(
                                          fontSize:appState.getlocal == "ar"? 15 : 13.5,color:Colors.pink[900]),textDirection: TextDirection.rtl,),
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewUsersScreen(widget.id)));
                                      },
                                    ),


                                    TextButton(
                                      child: Text(appState.getlocal == "ar"?'الذهاب الي القائمة الرئيسيه':'Go to main menu',style: TextStyle(
                                    fontSize: appState.getlocal == "ar"? 15 : 13.5,color:Colors.pink[900]),textDirection: TextDirection.rtl,),
                                      onPressed: () {
                                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          } ,
                          child:Text(appState.getlocal == "ar"? 'مهتم بالهواية':"Interested in This hobby",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),))
                    ],
                  ),
                )
            ),
          ],
        )
    );
  }
}