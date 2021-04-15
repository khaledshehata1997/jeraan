import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jeraan_project/screens/auth/forget_password.dart';
import 'package:get/get.dart';

import 'add_product.dart';
class ECommerseHome extends StatefulWidget {
  @override
  _ECommerseHomeState createState() => _ECommerseHomeState();
}

class _ECommerseHomeState extends State<ECommerseHome> {
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
           Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProduct()));
            },
            child: Text('إضافة منتج',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),)),
    );
    }),
      ),
      appBar: AppBar(
        title: Text('بيع وشراء الجيران'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
              children: [
                post(
                    'Khaled Mohamed',
                      '4200\n ريال',
                      'https://scontent-hbe1-1.xx.fbcdn.net/v/t1.6435-9/145442707_2866291720305610_6893681363896788682_n.jpg?_nc_cat=108&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=PmFE_GfUzo8AX_CL4Nx&_nc_ht=scontent-hbe1-1.xx&oh=1a1096bb0420aeb0871ff43c0bef18c2&oe=609808D6',
                      'https://el5olasa.com/wp-content/uploads/2019/10/%D9%84%D8%A7%D8%A8%D8%AA%D9%88%D8%A8-XPS-15-%D8%B7%D8%B1%D8%A7%D8%B2-2020-%D8%A3%D9%81%D8%B6%D9%84-%D9%84%D8%A7%D8%A8%D8%AA%D9%88%D8%A8-%D8%AF%D9%8A%D9%84-768x384.png',
                      'لاب توب apple جيل خامس \n رام: 8 جيجابايت \n هارد: 1000 جيجا , شاشة 15 بوصه full hd',
                      '+201064871625' ),
                SizedBox(height: 15,),
                post(
                    'Hassan Abdelhameed',
                    '1000\n ريال',
                    'https://scontent-hbe1-1.xx.fbcdn.net/v/t1.6435-9/84110374_1484842798350693_3347258839169761280_n.jpg?_nc_cat=105&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=ivgoBlfPwSoAX91-hP6&_nc_ht=scontent-hbe1-1.xx&oh=0eaa65405fc797e8bcbbb990e1765167&oe=609767BE',
                    'https://www.elarabygroup.com/media/catalog/product/cache/1/image/9df78eab33525d08d6e5fb8d27136e95/a/l/alba-ladies-hand-watch-fashion-stainless-steel-bracelet-and-silver-white-dial-ah7p34x1.jpg',
                    'لاب توب apple جيل خامس \n رام: 8 جيجابايت \n هارد: 1000 جيجا , شاشة 15 بوصه full hd',
                    '+201064871625' ),

              ],
            ),
          )
        ],
      ),
    );
  }
  Widget post(name , price,photo,product,desc,phone){
    return  Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(spreadRadius: .5, blurRadius: 10)],
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundImage:NetworkImage('$photo'),
                maxRadius: 25,
              ),
              Text(
                '$name',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                '2 hr',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          Divider(
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.pink[900],
                  child: Text(
                    '$price',
                    style: TextStyle(
                        fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),
                    textDirection: TextDirection.rtl,textAlign: TextAlign.center,
                  )),
              Container(
                width: MediaQuery.of(context).size.width * .6,
                child: Image.network(
                    '$product'),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.topRight,
            child: Text(
              '$desc',
              style:
              TextStyle(fontSize: 15, color: Colors.grey[800]),
              textDirection: TextDirection.rtl,
            ),
          ),
          Divider(
            thickness: 3,
          ),
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
        ],
      ),
    );
  }
}
