import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jeraan_project/constants.dart';
import 'package:jeraan_project/main.dart';
import 'package:jeraan_project/widgets/custom_text_form.dart';
import 'package:jeraan_project/widgets/default_button.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';


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
  List<String> dateOfBirth = [];
  String dateBirth = "تاريخ الميلاد";
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
              margin: EdgeInsets.only(left: 12, right: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: mediQuery.width * .04,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    width: mediQuery.width*.95,
                    height: mediQuery.height*.25,
                    alignment: Alignment.center,
                    child: Image.asset('images/jeran2022.jpeg',
                    ),
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
                  SizedBox(height:5),
                   Padding(
                      padding: const EdgeInsets.only(right: 8.0, bottom: 2),
                      child: Text(
                        "تاريخ الميلاد",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ),
                    Directionality(textDirection: TextDirection.rtl,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(right: 15, left: 15),
                        height: 50,
                        color: Color(0xfff9f9f9),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                dateBirth,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                              ButtonTheme(
                                minWidth: 60,
                                height: 25,
                                child: RaisedButton(
                                  onPressed: () {
                                     DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(1940, 1, 1),
                              maxTime: DateTime(2016, 1, 1),
                              onConfirm: (date) {
                                dateOfBirth = [];
                                dateOfBirth.add(date.year.toString());
                                dateOfBirth.add(date.month.toString());
                                dateOfBirth.add(date.day.toString());
                                setState(() {
                                  dateBirth = "${date.year}-${date.month}-${date.day}";
                                });
                                print(dateOfBirth);
                          }, currentTime: DateTime.now(), locale: LocaleType.ar);
                                  },
                                  shape: new RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Text(
                                    "تحديد",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              
                            ]),
                      ),
                    ),
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
                      String email, password , phone , name , passwordConf;
                      if (_formKey.currentState.validate() && dateOfBirth.isNotEmpty) {
                        _formKey.currentState.save();

                        setState(() {
                          isLoading = true;
                        });
                        name = _nameController.text.trim();
                        email = _emailController.text.trim();
                        phone = _phoneController.text.trim();
                        password = _passwordController.text;
                        passwordConf = _passwordConfirmController.text;
                        signUpData(name , phone , email , password , passwordConf);
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

  signUpData(String name, String phone , String email, String password,
      String passwordConfirmation) async {
   try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
        .then((value)async{
         if(value.user.uid != null){
           await FirebaseFirestore.instance.collection("Users").doc(value.user.uid).set({
             'name' : name ,
             'phone' : phone, 
             'email' : email,
             "image" : "gs://jeeran-24c62.appspot.com/391-3918613_personal-service-platform-person-icon-circle-png-transparent.png",
             "age" : dateOfBirth,
             "jop" : "" ,
             "nearest" : "1",
             "about" : ""
           }).then((value) {
             Navigator.pushAndRemoveUntil(
            context,
             MaterialPageRoute(builder: (context) => MyApp()),
              (Route<dynamic> route) => false,
            );
           });
          }
        });
        
    } on Exception catch (exception) {
      print(exception);
      setState(() {
        isLoading = false;
        message = "${exception.toString()}";
      });
    }catch (e) {
      print(e);
      setState(() {
        isLoading = false;
        message = "${e.toString()}";
      });
    }
  }
 }
