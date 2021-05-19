import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_post_t3arf.dart';

class T3arfHome extends StatefulWidget {
  @override
  _T3arfHomeState createState() => _T3arfHomeState();
}

class _T3arfHomeState extends State<T3arfHome> {
  Color fav=Colors.grey[400];
  bool isfav=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: Padding(
          padding: const EdgeInsets.only(left: 30,right: 30),
          child: BottomSheet(
              elevation: 10,
              backgroundColor: Colors.pink[900],
              onClosing: (){},
              builder: (ctx) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPostT3arf()));
                      },
                      child: Text('إضافة منشور',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),)),
                );
              }),
        ),
      appBar: AppBar(
        title: Text('تعارف الجيران '),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black
                ),
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.all(8),
                width: Get.width*.8,
                height: Get.height*.13,
                child: Text(
                    'رجاءا من مسئول التطبيق : لا تستخدم هذه الخاصية في إزعاج غيرك من الجيران وراقب الله في افعالك.',
                    textDirection: TextDirection.rtl,
                style: TextStyle(fontSize: 16,color: Colors.white),),
              ),
              t3arf('https://scontent-hbe1-1.xx.fbcdn.net/v/t1.6435-9/145442707_2866291720305610_6893681363896788682_n.jpg?_nc_cat=108&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=PmFE_GfUzo8AX_CL4Nx&_nc_ht=scontent-hbe1-1.xx&oh=1a1096bb0420aeb0871ff43c0bef18c2&oe=609808D6',
                  'Khaled Mohamed', '23', 'مهندس برمجة',
                  'انا خالد محمد ،عمري 23 عام ،ادرس في كلية الهندسة جامعة الازهر . اود ان اتعرف علي جيران بالقرب مني',
                 '+201064871625'
              ),
              t3arf('https://scontent-hbe1-1.xx.fbcdn.net/v/t1.6435-9/145442707_2866291720305610_6893681363896788682_n.jpg?_nc_cat=108&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=PmFE_GfUzo8AX_CL4Nx&_nc_ht=scontent-hbe1-1.xx&oh=1a1096bb0420aeb0871ff43c0bef18c2&oe=609808D6',
                  'Khaled Mohamed', '23', 'مهندس برمجة',
                  'انا خالد محمد ،عمري 23 عام ،ادرس في كلية الهندسة جامعة الازهر . اود ان اتعرف علي جيران بالقرب مني',
                 '+201064871625'
              )
            ],
          ),
        ),
      )
    );
  }

  Widget t3arf(String image,name,age,job,text,phone){
    return Container(
      margin: EdgeInsets.all(12),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 8,
            spreadRadius: 1
          )
        ]
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage('$image'),
              ),
              Text(
                '$name',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
              IconButton(icon: Icon(Icons.favorite,color: fav,size: 30,), onPressed: (){
                setState(() {
                  isfav= !isfav;
                  isfav?fav=Colors.grey[400]:fav=Colors.red;
                });
              })
            ],
          ),
          SizedBox(height: Get.height*.03,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('$age',textDirection: TextDirection.rtl,style: TextStyle(
                fontSize: 17
              ),),
              Text('العمر :  ',textDirection: TextDirection.rtl,style: TextStyle(
                fontSize: 17,fontWeight: FontWeight.bold
              ),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('$job',textDirection: TextDirection.rtl,style: TextStyle(
                fontSize: 17
              ),),
              Text('الوظيفة :  ',textDirection: TextDirection.rtl,style: TextStyle(
                fontSize: 17,fontWeight: FontWeight.bold
              ),),
            ],
          ),
          SizedBox(height: Get.height*.01,),
          Divider(thickness: 2,),
          Text(' $text'

            ,style: TextStyle(fontSize: 16)
            ,textDirection: TextDirection.rtl,),
          SizedBox(height: 10,),
          Divider(thickness: 2),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * .1,
                  height: MediaQuery.of(context).size.height * .04,
                  child: Image.asset('images/whats.png'),
                ),
                Text(
                  '$phone',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                Icon(Icons.copy)
              ]),
          SizedBox(height: 25,)
        ],
      ),
    );
  }
}
