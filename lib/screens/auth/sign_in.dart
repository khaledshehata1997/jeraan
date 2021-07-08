import 'package:flutter/material.dart';
import 'package:jeraan_project/constants.dart';
import 'package:jeraan_project/main.dart';
import 'package:jeraan_project/screens/auth/sign_up.dart';
import 'package:jeraan_project/screens/home_screen/home_screen.dart';
import 'package:jeraan_project/widgets/custom_text_form.dart';
import 'package:jeraan_project/widgets/default_button.dart';
import 'forget_password.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  String message = "";
  bool isLoading = false;
  bool keepMeLoggedIn=false;
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    var mediQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(
        automaticallyImplyLeading: false,
        title: Text('LOG IN'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                      "البريد الالكتروني",
                      style: TextStyle(
                          fontSize: mediQuery.width * .05,
                          color: Colors.black45,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  CustomTextForm(
                    false,
                    'ادخل البريد الالكتروني',
                    controller: _emailController,
                  ),
                  SizedBox(
                    height: mediQuery.width * .03,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:10.0),
                    child: Text(
                      "الرقم السري",
                      style: TextStyle(
                          fontSize: mediQuery.width * .05,
                          color: Colors.black45,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  CustomTextForm(
                    true,
                    'أدخل الرقم السري',
                    controller: _passwordController,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        activeColor: mainColor,
                        value: keepMeLoggedIn,
                        onChanged: (value) {
                          setState(() {
                            keepMeLoggedIn = value;
                          });
                        },
                      ),
                      Text(
                        'تذكرني',
                        style: TextStyle(color: Colors.black,fontSize: 16),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPassword()));
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 13, top: 5),
                      alignment: Alignment.centerRight,
                      child: Text(
                        "هل نسيت كلمة السر؟",
                        style: TextStyle(
                            fontSize: mediQuery.width * .05,
                            color: Colors.black45,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
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
                  SizedBox(
                    height: 5,
                  ),

                  DefaultButton(
                    text: 'دخول',
                    press: () {
                      String email, password;
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        setState(() {
                          isLoading = true;
                        });
                        email = _emailController.text.toLowerCase().trim();
                        password = _passwordController.text;
                        loginData(email, password);
                      }
                    },
                  )
                ],
              ),
            ),

            SizedBox(
              height: mediQuery.height * .02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  child: Text(
                    'تسجيل',
                    style: TextStyle(
                        fontSize: mediQuery.width * .05,
                        color: Colors.pink[800],
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  '   ليس لديك حساب ',
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

  loginData(String email, String password) async {
    try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
          if(value.user.uid != null){
          Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
              (Route<dynamic> route) => false,
        );
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