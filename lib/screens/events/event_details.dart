import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeraan_project/screens/home_screen/home_screen.dart';
import 'package:jeraan_project/screens/serves/appstate.dart';
import 'package:jeraan_project/screens/t3arf/view_user_screen.dart';
import 'package:provider/provider.dart';
class EventDetails extends StatefulWidget {
  final String image;
  final String name;
  final String id;
  final int distance;
  final String eventDate;
  final String type;
  final String desc;
  EventDetails(this.image,this.name,this.id,this.distance,this.type,this.eventDate,this.desc);
  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  Color fav=Colors.grey[400];

  bool isfav=false;

  @override
  Widget build(BuildContext context) {
    AppState appState = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text( appState.getlocal == "ar"?'تفاصيل المناسبة':"Event Details"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
              margin: EdgeInsets.only(top: 15,left: 8,right: 8,bottom: 10),
              padding: EdgeInsets.only(left: 8,right: 8,bottom: 8,top: 8),
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
                          IconButton(icon: Icon(Icons.favorite,color: fav,size: 30,), onPressed: (){
                            setState(() {
                              isfav= !isfav;
                              isfav?fav=Colors.grey[400]:fav=Colors.red;
                            });
                          })
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
                            widget.type,
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
                            widget.eventDate,
                            style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),textDirection: TextDirection.rtl,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height:15),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset('images/invitation_card.jpg'),
                        Padding(
                          padding: const EdgeInsets.only(left: 8,right: 8,top: 25),
                          child: Column(
                            children: [
                              Text(
                                  widget.desc,style:
                                TextStyle(fontSize: 18,color: Colors.pink[900]),textDirection: TextDirection.rtl,textAlign: TextAlign.center,),
                              // Container(
                              //   child: Image.network(
                              //     'https://www.cocokids.org/wp-content/uploads/2019/12/Find-Child-Care2.jpg',fit: BoxFit.cover,),
                              //   margin: EdgeInsets.only(top: 18),
                              //   color: Colors.white,
                              //   width: Get.width*.65,
                              //   height: Get.height*.2,
                              // )
                            ],
                          ),
                        )
                      ],
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
                                      Text(appState.getlocal == "ar"?'شكرا علي الاهتمام بهذه المناسبة :)' : " Thank you for your interest in this Event ",style: TextStyle(
                                          fontSize: appState.getlocal == "ar"? 15 : 14,color:Colors.pink[900] ),textDirection: TextDirection.rtl,),
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  actions: [
                                    Container(
                                      alignment : appState.getlocal == "ar"? Alignment.topRight : Alignment.topLeft,
                                      child: TextButton(
                                        child: Text(appState.getlocal == "ar"?''
                                            'إذهب الي الحساب الخاص بالمعلن واحصل علي العنوان ووسائل التواصل.' : "Go to the advertiser's account and get the address and contact",style: TextStyle(
                                            fontSize: appState.getlocal == "ar"? 15 : 13,color:Colors.pink[900]),textDirection:appState.getlocal == "ar"?  TextDirection.rtl : TextDirection.ltr,),
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewUsersScreen(widget.id)));
                                        },
                                      ),
                                    ),


                                    Container(
                                      alignment: appState.getlocal == "ar"? Alignment.topRight : Alignment.topLeft,
                                      child: TextButton(
                                        child: Text(appState.getlocal == "ar"?'الذهاب الي القائمة الرئيسيه':"Go to the main menu",style: TextStyle(
                                            fontSize: appState.getlocal == "ar"?15:13,color:Colors.pink[900]),textDirection:appState.getlocal == "ar"? TextDirection.rtl : TextDirection.ltr,),
                                        onPressed: () {
                                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                        },
                        child:Text(appState.getlocal == "ar"?'أنوي الحضور':"Will Attend",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),))
                  ],
                ),
              )
          ),
        ],
      )
    );
  }
}
