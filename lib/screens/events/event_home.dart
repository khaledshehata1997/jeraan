import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeraan_project/screens/events/event_details.dart';

import 'add_event.dart';

class EventHome extends StatefulWidget {
  @override
  _EventHomeState createState() => _EventHomeState();
}

class _EventHomeState extends State<EventHome> {
  Color fav=Colors.grey[400];
  bool isfav=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('مناسبات الجيران'),
        centerTitle: true,

      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(left: 30,right: 30),
        child: BottomSheet(
            elevation: 10,
            backgroundColor: Colors.pink[900],
            onClosing: (){},
            builder: (ctx) {
              return Container(
                height: Get.height*.055,
                width: MediaQuery.of(context).size.width,
                child: TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddEvent()));
                    },
                    child: Text('إضافة مناسبة',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),)),
              );
            }),
      ),
      body: ListView(
        children: [
          event('https://scontent-hbe1-1.xx.fbcdn.net/v/t1.6435-9/145442707_2866291720305610_6893681363896788682_n.jpg?_nc_cat=108&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=PmFE_GfUzo8AX_CL4Nx&_nc_ht=scontent-hbe1-1.xx&oh=1a1096bb0420aeb0871ff43c0bef18c2&oe=609808D6',
            'Khaled Mohamed', 'عيد ميلاد', '24/12/2021'),
          event('https://scontent-hbe1-1.xx.fbcdn.net/v/t1.6435-9/172731204_4040812335998179_4763889988136554876_n.jpg?_nc_cat=107&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=HO1MoLvYm8oAX-oh-HW&_nc_ht=scontent-hbe1-1.xx&oh=8f7254364f21f1bcd02d381cb8451d8e&oe=60A2E063',
            'Ahmed Fathy', 'حفل زفاف', '30/5/2021'),
          event('https://scontent-hbe1-1.xx.fbcdn.net/v/t1.6435-9/145442707_2866291720305610_6893681363896788682_n.jpg?_nc_cat=108&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=PmFE_GfUzo8AX_CL4Nx&_nc_ht=scontent-hbe1-1.xx&oh=1a1096bb0420aeb0871ff43c0bef18c2&oe=609808D6',
            'Khaled Mohamed', 'حفل زفاف', '30/12/2021'),

        ],
      ),
    );
  }

  Widget event(var image,name,type,date){
    return Container(
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
      child:Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundImage:NetworkImage('$image'),
                maxRadius: 25,
              ),
              Text(
                '$name',
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
                  ' $type',
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
                  '$date',
                  style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),textDirection: TextDirection.rtl,
                ),
              ),
            ],
          ),
          SizedBox(height: 15,),

          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.pink[900],
              ),
              onPressed:() {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>EventDetails()));
              } ,
              child:Text('عرض التفاصيل',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),))
        ],
      )
    );
  }
}
