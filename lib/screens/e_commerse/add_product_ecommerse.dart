import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jeraan_project/screens/e_commerse/e_commerse_home.dart';
import 'package:jeraan_project/screens/home_screen/home_screen.dart';
import 'package:jeraan_project/widgets/custom_text_form.dart';
import 'package:get/get.dart';
import 'package:jeraan_project/widgets/default_button.dart';
import 'package:jeraan_project/widgets/spetial_text_field.dart';
class AddProductEcommerse extends StatelessWidget {
  final TextEditingController _titleController = new TextEditingController();
  final TextEditingController _priceController = new TextEditingController();
  final TextEditingController _descController = new TextEditingController();
  final TextEditingController _whatsController = new TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إضافة منتج'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right:10.0),
                    child: Text(
                      "اسم المنتج",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black45,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  CustomTextForm(false, 'اسم المنتج ',controller: _titleController,),
                  SizedBox(
                    height: Get.height*.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:15.0),
                    child: Text(
                      "تفاصيل المنتج",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black45,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: SpetialCustomTextForm(

                      false, 'ادخل التفاصيل ',controller: _descController,),
                  ),
                  SizedBox(
                   height:Get.height*.02 ,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:15.0),
                    child: Text(
                      "سعر المنتج",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black45,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: CustomTextForm(

                      false, 'ادخل السعر ',controller:_priceController,),
                  ),
                  SizedBox(
                    height: Get.height*.02,
                  ), Padding(
                    padding: const EdgeInsets.only(right:15.0),
                    child: Text(
                      "رقم التواصل",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black45,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: CustomTextForm(

                      false, 'ادخل الرفم ',controller: _whatsController,),
                  ),
                  SizedBox(
                    height: Get.height*.02,
                  ),
                  Center(
                    child: Container(
                      color: Colors.grey[100],
                      height: Get.height*.15,
                      width: Get.width*.4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_a_photo,color: Colors.pink[900],size: 30,),
                          SizedBox(
                            width: Get.width*.03,
                          ),
                          Text('إضافة صورة',style: TextStyle(fontSize: 18,color: Colors.pink[900]),)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height*.02,
                  ),
                  DefaultButton(
                    text: 'إضافة المنتج',
                    press: (){
                      var result =  showDialog(

                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title:Image.asset('images/text.png',width: 60,height: 50,),
                            content: Row(
                              children: [
                                Image.asset('images/smile.png',width: 40,height: 30,),
                                Text('تم إضافة المنتج بنجاح :)',style: TextStyle(
                                    fontSize: 19,color:Colors.pink[900] ),textDirection: TextDirection.rtl,),
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            actions: [
                              TextButton(
                                child: Text('الرجوع الي القائمة السابقة',style: TextStyle(
                                    fontSize: 15,color:Colors.black),textDirection: TextDirection.rtl,),
                                onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ECommerseHome()));
                                },
                              ),
                              TextButton(
                                child: Text('الذهاب الي القائمة الرئيسيه',style: TextStyle(
                                    fontSize: 15,color:Colors.black),textDirection: TextDirection.rtl,),
                                onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}

