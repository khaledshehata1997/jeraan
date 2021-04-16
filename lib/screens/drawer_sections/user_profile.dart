import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeraan_project/widgets/default_button.dart';
class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الملف الشخصي'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(spreadRadius: .5, blurRadius: 7)],
                borderRadius: BorderRadius.circular(12)),
            width: Get.width*.95,
            height: Get.height*.8,
            margin: EdgeInsets.symmetric(vertical: 20,horizontal: 8),
            child: Column(
              children: [
                CircleAvatar(
                  maxRadius: 45,
                  backgroundImage: NetworkImage('https://scontent-hbe1-1.xx.fbcdn.net/v/t1.6435-9/145442707_2866291720305610_6893681363896788682_n.jpg?_nc_cat=108&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=PmFE_GfUzo8AX_CL4Nx&_nc_ht=scontent-hbe1-1.xx&oh=1a1096bb0420aeb0871ff43c0bef18c2&oe=609808D6'),
                ),
                SizedBox(height: 20,),
                Text('Khaled Mohamed',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                SizedBox(height: Get.height*.05,),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('khaledmshehata1997@gmail.com',style: TextStyle(fontSize: 14)),
                        SizedBox(width: 20,),
                       Icon(Icons.email_outlined),

                      ],
                    ),
                    SizedBox(height: Get.height*.025,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('سائق تاكسي',style: TextStyle(fontSize: 14)),
                        SizedBox(width: 20,),
                       Icon(Icons.work_outline_outlined),

                      ],
                    ),
                    SizedBox(height: Get.height*.025,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('10 th Of Ramadan City',style: TextStyle(fontSize: 14)),
                        SizedBox(width: 20,),
                       Icon(Icons.location_on_outlined),

                      ],
                    ),
                    SizedBox(height: Get.height*.025,),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     Icon(Icons.copy),
                    //     SizedBox(width: Get.width*.2,),
                    //     Text('+201064871625',style: TextStyle(fontSize: 14)),
                    //     SizedBox(width: Get.width*.04,),
                    //     Icon(Icons.contact_phone_outlined),
                    //    // Text('البريد الالكتروني :   ',style: TextStyle(fontSize: 15),textDirection: TextDirection.rtl,),
                    //   ],
                    // ),
                    Divider(thickness: 2,height: Get.height*.05,),
                    SizedBox(height: Get.height*.01,),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset('images/whats.png',width:30,height: 30,),
                          Text(
                            '+201064871625',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          Icon(Icons.copy)
                        ]),
                    SizedBox(height: Get.height*.07,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         ElevatedButton(
                             onPressed: (){},
                           child: Text('تعديل الملف الشخصي'),
                           style: ButtonStyle(
                             backgroundColor: MaterialStateProperty.all<Color>(Colors.pink[900]),
                           ),
                         ),
                         ElevatedButton(onPressed: (){},
                             style: ButtonStyle(
                               backgroundColor: MaterialStateProperty.all<Color>(Colors.pink[900]),
                             ),
                             child: Text('تعديل الملف الشخصي')),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
