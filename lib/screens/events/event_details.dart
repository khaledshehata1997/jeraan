import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeraan_project/screens/home_screen/home_screen.dart';
class EventDetails extends StatefulWidget {
  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  Color fav=Colors.grey[400];

  bool isfav=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل المناسبة'),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundImage:NetworkImage('https://scontent-hbe1-1.xx.fbcdn.net/v/t1.6435-9/145442707_2866291720305610_6893681363896788682_n.jpg?_nc_cat=108&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=PmFE_GfUzo8AX_CL4Nx&_nc_ht=scontent-hbe1-1.xx&oh=1a1096bb0420aeb0871ff43c0bef18c2&oe=609808D6'),
                          maxRadius: 25,
                        ),
                        Text(
                          'Khaled Mohamed',
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
                            'عيد ميلاد ',
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
                            '24/12/2021',
                            style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),textDirection: TextDirection.rtl,
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset('images/invitation_card.jpg'),
                        Padding(
                          padding: const EdgeInsets.only(left: 8,right: 8,top: 25),
                          child: Column(
                            children: [
                              Text(
                                  'ادعوكم جيراني لحضور حفل عيد ميلاد ابني كريم .وارجو منكم الحضور في الموعد المحدد ومعكم الاسرة الكريمة لمشاركة ابني فرحته. دمتم خير جيران :)',style:
                                TextStyle(fontSize: 18,color: Colors.pink[900]),textDirection: TextDirection.rtl,),
                              Container(
                                child: Image.network(
                                  'https://www.cocokids.org/wp-content/uploads/2019/12/Find-Child-Care2.jpg',fit: BoxFit.cover,),
                                margin: EdgeInsets.only(top: 18),
                                color: Colors.white,
                                width: Get.width*.65,
                                height: Get.height*.2,
                              )

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
                                    Image.asset('images/smile.png',width: 30,height: 30,),
                                    Text('شكرا علي الاستجابة لهذه المناسبة :)',style: TextStyle(
                                        fontSize: 15,color:Colors.pink[900] ),textDirection: TextDirection.rtl,),
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                actions: [
                                  Text(''
                                      'إذهب الي الحساب الخاص بالمعلن واحصل علي العنوان ووسائل التواصل.',style: TextStyle(
                                        fontSize: 15,color:Colors.black),textDirection: TextDirection.rtl,),


                                  TextButton(
                                    child: Text('الذهاب الي القائمة الرئيسيه',style: TextStyle(
                                        fontSize: 15,color:Colors.pink[900]),textDirection: TextDirection.rtl,),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } ,
                        child:Text('أنوي الحضور',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),))
                  ],
                ),
              )
          ),
        ],
      )
    );
  }
}
