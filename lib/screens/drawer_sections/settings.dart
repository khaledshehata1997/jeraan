import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeraan_project/constants.dart';
import 'package:jeraan_project/widgets/default_button.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var radioVal='value';
  var radioVal2='value';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الأعدادات'),
        centerTitle: true,
      ),
      body: Column(
        children: [
           Container(
             alignment: Alignment.topRight,
             margin: EdgeInsets.all(12),
             padding: EdgeInsets.all(8),
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(8),
               color: Colors.white,
               boxShadow: [
                 BoxShadow(
                   spreadRadius: 2,
                   blurRadius: 8,
                   color: Colors.grey
                 ),
               ]
             ),
             child: Column(
               children: [
                 Text('وضع التطبيق',style: TextStyle(
                     fontWeight:FontWeight.bold,fontSize: 18,color: mainColor),),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                   children: [
                     Text('وضع النهار'),
                     Radio(

                       value: 'val1',
                       groupValue:radioVal ,
                       onChanged: (val){
                         setState(() {
                           radioVal=val;
                         });
                       },
                     ),
                   ],
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                   children: [
                     Text('وضع الليل'),
                     Radio(
                       value: 'val2',
                       groupValue:radioVal ,
                       onChanged: (val){
                         setState(() {
                           radioVal=val;
                         });
                       },
                     ),
                   ],
                 ),

               ],
             ),
             width:Get.width*.95,
           ),Container(
             alignment: Alignment.topRight,
             margin: EdgeInsets.all(15),
             padding: EdgeInsets.all(8),
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(8),
               color: Colors.white,
               boxShadow: [
                 BoxShadow(
                   spreadRadius: 2,
                   blurRadius: 8,
                   color: Colors.grey
                 ),
               ]
             ),
             child: Column(
               children: [
                 Text('لغة التطبيق',style: TextStyle(
                     fontWeight:FontWeight.bold,fontSize: 18,color: mainColor),),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                   children: [
                     Text('العربية'),
                     Radio(

                       value: 'arabic',
                       groupValue:radioVal2 ,
                       onChanged: (val){
                         setState(() {
                           radioVal2=val;
                         });
                       },
                     ),
                   ],
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                   children: [
                     Text('الانجليزية'),
                     Radio(
                       value: 'English',
                       groupValue:radioVal2 ,
                       onChanged: (val){
                         setState(() {
                           radioVal2=val;
                         });
                       },
                     ),
                   ],
                 ),
               ],
             ),
             width:Get.width*.95,
           ),
          SizedBox(height: 20,),
          DefaultButton(
            text: 'حفظ التغييرات',
            press: (){

            },
          )

        ],
      ),
    );
  }
}
