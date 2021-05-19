import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_job.dart';
import 'job_datails.dart';
 class JobsHome extends StatefulWidget {
   @override
   _JobsHomeState createState() => _JobsHomeState();
 }

 class _JobsHomeState extends State<JobsHome> {
   Color fav=Colors.grey[400];
   bool isfav=false;
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text('هوايات الجيران'),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddJob()));
                     },
                     child: Text('إضافة هواية',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),)),
               );
             }),
       ),
       body:ListView(
         children: [
           event('https://scontent-hbe1-1.xx.fbcdn.net/v/t1.6435-9/145442707_2866291720305610_6893681363896788682_n.jpg?_nc_cat=108&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=PmFE_GfUzo8AX_CL4Nx&_nc_ht=scontent-hbe1-1.xx&oh=1a1096bb0420aeb0871ff43c0bef18c2&oe=609808D6',
               'Khaled Mohamed', 'معلم رياضيات'),
           event('https://scontent-hbe1-1.xx.fbcdn.net/v/t1.6435-9/172731204_4040812335998179_4763889988136554876_n.jpg?_nc_cat=107&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=HO1MoLvYm8oAX-oh-HW&_nc_ht=scontent-hbe1-1.xx&oh=8f7254364f21f1bcd02d381cb8451d8e&oe=60A2E063',
               'Ahmed Fathy', 'مهندس برمجة'),
           event('',
               'Ali Hamed', 'ميكانيكي سيارات'),


         ],
       ),
     );
   }
   Widget event(var image,name,date){
     return Container(
         margin: EdgeInsets.only(top: 15,left: 8,right: 8,bottom: 10),
         padding: EdgeInsets.only(left: 8,right: 8,bottom: 8,top: 8),
         width: Get.width,
          height: Get.height*.3,
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
               height: 12,
               thickness: 2,
             ),

             Container(
               margin:EdgeInsets.only(top: 12),
               decoration: BoxDecoration(
                 color: Colors.grey[700],
                 borderRadius: BorderRadius.circular(4),

               ),
               alignment: Alignment.center,
               width: Get.width*.6,
               height: Get.height*.07,
               child: Text(
                 '$date',
                 style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),textDirection: TextDirection.rtl,
               ),
             ),
             SizedBox(height: 10,),

             ElevatedButton(
                 style: ElevatedButton.styleFrom(
                   primary: Colors.pink[900],
                 ),
                 onPressed:() {
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>JobDetail()));
                 } ,
                 child:Text('عرض التفاصيل',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),))
           ],
         )
     );
   }
 }
