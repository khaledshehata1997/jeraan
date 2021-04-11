import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jeraan_project/constants.dart';
import 'package:jeraan_project/widgets/custom_text_form.dart';
import 'package:jeraan_project/widgets/default_button.dart';

import 'sign_in.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var keepMeLoggedIn = false;
  var checkPrivcyPolicy = false;

  final _formKey = GlobalKey<FormState>();
  // var keepMeLoggedIn=false;

  String message = "";
  bool isLoading = false;

  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _phoneController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _passwordConfirmController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var mediQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('SIGN UP'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(left: 12, right: 12, top: 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: mediQuery.width * .04,
                  ),
                  Container(
                    width: mediQuery.width,
                    height: mediQuery.height*.18,
                    alignment: Alignment.center,
                    child: Image.asset('images/jeran.png'),
                  ),
                  Container(
                      width: mediQuery.width,
                      child:Image.asset('images/text.png')
                  ),
                  SizedBox(
                    height: mediQuery.width * .01,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:10.0),
                    child: Text(
                      "الاسم",
                      style: TextStyle(
                          fontSize: mediQuery.width * .045,
                          color: Colors.black45,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  CustomTextForm(false, 'ادخل الاسم ',controller: _nameController,),
                  SizedBox(
                    height: mediQuery.width * .02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:10.0),
                    child: Text(
                      "رقم الهاتف",
                      style: TextStyle(
                          fontSize: mediQuery.width * .045,
                          color: Colors.black45,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  CustomTextForm(false, 'ادخل رقم الهاتف', controller: _phoneController,), SizedBox(
                    height: mediQuery.width * .02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:10.0),
                    child: Text(
                      "البريد الالكتروني",
                      style: TextStyle(
                          fontSize: mediQuery.width * .045,
                          color: Colors.black45,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  CustomTextForm(false, 'ادخل الايميل', controller: _emailController,),
                  SizedBox(
                    height: mediQuery.width * .02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:8.0),
                    child: Text(
                      "الرقم السري",
                      style: TextStyle(
                          fontSize: mediQuery.width * .045,
                          color: Colors.black45,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  CustomTextForm(true, 'ادخل الرقم السري',controller: _passwordController,),
                  SizedBox(
                    height: mediQuery.width * .02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:10.0),
                    child: Text(
                      "تاكيد الرقم السري",
                      style: TextStyle(
                          fontSize: mediQuery.width * .045,
                          color: Colors.black45,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  CustomTextForm(true, 'ادخل الرقم السري',controller: _passwordConfirmController,),

                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        activeColor: Colors.pink[900],
                        value: checkPrivcyPolicy,
                        onChanged: (value) {
                          setState(() {
                            checkPrivcyPolicy = value;
                          });
                        },
                      ),
                      RichText(
                        text: TextSpan(
                          text:
                          'اوافق علي كل ',
                          style: TextStyle(color: Colors.black45),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' بنود الخصوصيه',
                                style: TextStyle(color: mainColor)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: mediQuery.height * .03,
                  ),
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
                    text: 'تسجيل',
                    press: () {
                      String email, password , name , passwordConf;
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();

                        setState(() {
                          isLoading = true;
                        });
                        name = _nameController.text.trim();
                        email = _emailController.text.trim();
                        password = _passwordController.text;
                        passwordConf = _passwordConfirmController.text;
                      //  signinData(name,email, password,passwordConf);
                      }
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: mediQuery.height * .03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignIn()));
                  },
                  child: Text(
                    'دخول ',
                    style: TextStyle(
                        fontSize: mediQuery.width * .05,
                        color: mainColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  '    هل تمتلك حساب بالفعل',
                  style: TextStyle(
                    fontSize: mediQuery.width * .042,
                    color: Colors.black45,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

//   signinData(String name, String email, String password,
//       String passwordConfirmation) async {
//     try {
//       print("body : $name   $email    $password    $passwordConfirmation");
//       var url = "https://api.hvacrtoolbox.com/api/auth/register";
//
//       var request = await http.post(
//         url,
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(<String, String>{
//           "name": "$name",
//           "email": "$email",
//           "password": "$password",
//           "password_confirmation": "$passwordConfirmation"
//         }),
//       );
//       print(request.body);
//       var data = jsonDecode(request.body);
//
//       if ("${data['success']}" == "true") {
//         saveTok("${data['token']}");
//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => MainScreen()),
//               (Route<dynamic> route) => false,
//         );
//       } else {
//         setState(() {
//           isLoading = false;
//           message = "${data["errors"]}";
//         });
//       }
//     } catch (e) {
//       print(e);
//       setState(() {
//         isLoading = false;
//         message = "Error From Server or Network";
//       });
//     }
//   }
 }
