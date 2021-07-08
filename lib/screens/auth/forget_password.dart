import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widgets/custom_text_form.dart';
import '../../widgets/default_button.dart';
import '../../widgets/textOnFields.dart';

class ForgetPassword extends StatefulWidget {

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String message = "";
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    var mediQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('نسيت كلمة السر'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SizedBox(
            height: mediQuery.height * .05,
          ),
          Container(
            margin: EdgeInsets.all(15),
            child: Form(
              key: _formKey,
                          child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: mediQuery.width,
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('images/smile.png'),
                        SizedBox(width: 30,),
                        Text('لا تقلق',style: TextStyle(fontSize: 20,color: Colors.pink[900]),)
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),

                  Text(
                    'سوف نرسل اليك بريدالكتروني لتغيير الرقم السري',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black45,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(
                    height: mediQuery.height * .065,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: textOnFields(context, 'البريد الالكتروني', false),
                  ),
                  CustomTextForm(false, 'ادخل البريد الالكتروني' , controller: _emailController,),

                  SizedBox(
                      height: mediQuery.height * .05,
                    ),

                    //states == true ? CircularProgressIndicator() : Container(),
                    isLoading == true
                        ? Center(
                            child: Container(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator()),
                          )
                        : Container(),
                    Center(
                        child: Text(
                      "$message",
                      style: TextStyle(color: Colors.red, fontSize: 15),
                    )),
                   isLoading? SizedBox(
                      height: 20,
                    ):Container(),
                  DefaultButton(
                    text: 'إرسال',
                    press: () {
                      if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          String email;
                          setState(() {
                            isLoading = true;
                          });

                          email = _emailController.text.toLowerCase();
                          //  resetPassowrd(email);
                        }
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  // resetPassowrd(String email) async {
  //   try {
  //     var url = "https://api.hvacrtoolbox.com/api/password/email";
  //
  //     var request = await http.post(
  //       url,
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body:
  //         jsonEncode(<String, String>{'email': email}),
  //     );
  //     print(request.body);
  //     var data = jsonDecode(request.body);
  //
  //     if ("${data['success']}" == "true") {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => ChangeForgotPassword(email)),
  //       );
  //     } else {
  //       setState(() {
  //         isLoading = false;
  //         message = data['message'];
  //       });
  //     }
  //   } catch (e) {
  //     print(e);
  //     setState(() {
  //       isLoading = false;
  //       message = "Error From Server or Network";
  //     });
  //   }
  // }
}
