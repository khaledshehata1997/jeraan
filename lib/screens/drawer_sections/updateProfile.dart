
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geodesy/geodesy.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jeraan_project/screens/drawer_sections/user_profile.dart';
import 'package:jeraan_project/screens/drawer_sections/viewPhoto.dart';
import 'package:jeraan_project/screens/serves/alerts.dart';
import 'package:jeraan_project/screens/serves/appstate.dart';
import 'package:provider/provider.dart';

class UpdateProfile extends StatefulWidget {
  UpdateProfile();
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final _formKey=GlobalKey<FormState>();
  double _value = 0.01;
   String messageGren = "";
   String messageRed = "";
  TextEditingController _controllerAbout = TextEditingController();
  String show;

  @override
  void initState() {
    AppState appState = Provider.of<AppState>(context,listen: false);
    _controllerAbout = TextEditingController(text: appState.getabout);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    AppState appState = Provider.of<AppState>(context);
    //show = myState.showall;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Container(
              child: Text(
            "تعديل الملف الشخصي",
            style: TextStyle(fontWeight: FontWeight.w400
            ,fontSize: 18
            ),
            
            
          )),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed:(){
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom:10),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(blurRadius: 5 , spreadRadius: 2 , color:Colors.black12),
                        ],
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image(image : FirebaseImage(appState.getimage)),
                                ),
                              ),
                    
                    
                    Text(appState.getname, style:TextStyle(fontWeight: FontWeight.w400 , fontSize: 15, color: Colors.black54),),

                    Container(
                      margin: EdgeInsets.only(top:5),
                      alignment: Alignment.center,
                      width: 190,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xfff9f9f9),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: GestureDetector(
                        onTap: (){
                        Navigator.push(
                                      context, MaterialPageRoute(builder: (context) => UserProfile(true , LatLng(appState.lat, appState.long) , FirebaseAuth.instance.currentUser.uid)));},
                            child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "عرض كما يظهر للآخرين",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13),
                              ),
                              SizedBox(width: 5),
                              Icon(Icons.remove_red_eye, size: 25, color: Theme.of(context).primaryColor,)
                            ]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top:5),
                      alignment: Alignment.center,
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xfff9f9f9),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: GestureDetector(
                        onTap: (){
                          _settingModalBottomSheet(context);
                        },
                            child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "رفع صورة",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13),
                              ),
                              SizedBox(width: 5),
                              Icon(Icons.camera_alt , size: 25, color: Theme.of(context).accentColor,)
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  padding: EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.topRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, bottom: 2),
                        child: Text(
                          "نبذة عنك",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ),
                      TextField(
                        controller: _controllerAbout,
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Colors.black87, fontSize: 15),
                        maxLines: 4,
                        maxLength: 180,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10.0),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Color(0xfff1f1f1),
                          hintText: "اكتب هنا نبذة قصيرة عنك",
                          hintStyle:
                              TextStyle(color: Colors.black26, fontSize: 12),
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),
              Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(top:0, bottom:15),
                              alignment: Alignment.center,
                              child: ButtonTheme(
                                minWidth: 100,
                                height: 45,
                                child: RaisedButton(
                                  padding: EdgeInsets.only(top: 5 ,bottom: 5 , right: 30 , left: 30),
                                  onPressed: () {
                                    try{
                                    FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser.uid).update({
                                    "about" : _controllerAbout.text.trim().toString()
                                     }).whenComplete(() {
                                      appState.setChanges(newabout : _controllerAbout.text.trim().toString());
                                      setState(() {
                                        EasyLoading.showSuccess("تم حفظ التغييرات بنجاح",duration: Duration(milliseconds: 600));
                                      });
                                    });
                                    }catch(e){
                                    }
                                  },
                                  
                                  shape: new RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Text(
                                    "حفظ تغييرات النبذة",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13),
                                  ),
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
              Column(
                children:<Widget>[
                  GestureDetector(
                  onTap: (){
                    _asyncChangesDialog(context, "الاسم", "name");
                  },  
                  child: customCard(Icons.person, "الاسم كاملاً", appState.getname)),
                  GestureDetector(
                    onTap: (){
                      _asyncChangesDialog(context, "رقم الهاتف", "phone");
                    },
                  child: customCard(Icons.phone, "رقم الجوال", appState.getphone)),
                  GestureDetector(
                  onTap: (){
                    _asyncChangesDialog(context, "الوظيفة", "jop");
                  },
                  child: customCard(Icons.work , "الوظيفة" , appState.getjop))
                ]
              ),
              
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                                    padding:
                                        const EdgeInsets.only(right: 20.0, bottom: 2 , top: 15),
                                    child: Text(
                                      "أقصي مسافة",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                  ),

                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 20.0, bottom: 2 , top: 15),
                                    child: Text(
                                      "${((_value == 0.01?(double.parse(appState.getnearest)/10) : _value)*10000).toInt()} M",
                                      //"",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                  ),
                      ],
                    ),
                            ),
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor:  Theme.of(context).primaryColor,
                                inactiveTrackColor: Colors.deepPurple[100],
                                trackShape: RectangularSliderTrackShape(),
                                trackHeight: 3.0,
                                thumbColor: Theme.of(context).primaryColor,
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 10.0),
                                overlayColor: Colors.deepPurple.withAlpha(20),
                                overlayShape: RoundSliderOverlayShape(
                                    overlayRadius: 28.0),
                              ),
                              child: Slider(
                                min: 0.011,
                                max: 1,
                                 value: _value == 0.01? _value =(double.parse(appState.getnearest)/10) : _value,
                                //value:  _value,
                                onChanged: (value) {
                                  setState(() {
                                    _value = value;
                                  });
                                },
                              ),
                            ),


                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(top:25, bottom:40),
                              alignment: Alignment.center,
                              child: ButtonTheme(
                                minWidth: 100,
                                height: 50,
                                child: RaisedButton(
                                  padding: EdgeInsets.only(top: 5 ,bottom: 5 , right: 30 , left: 30),
                                  onPressed: () {
                                    try{
                                    FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser.uid).update({
                                    "nearest" : (_value*10).toString()
                                     }).whenComplete(() {
                                      appState.setChanges(near : (_value*10).toString());
                                      setState(() {
                                        messageGren = "تم حفظ التغييرات بنجاح";
                                      });
                                    });
                                    }catch(e){
                                      setState(() {
                                        messageRed = "$e";
                                      });
                                    }
                                  },
                                  
                                  shape: new RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Text(
                                    "حفظ تغييرات المسافة",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13),
                                  ),
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            SizedBox(height:10),
                            Container(
                              alignment: Alignment.center,
                              width: 200,
                              child: Text(
                            "$messageGren",
                             overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                            ),
                            ),

                            Container(
                              alignment: Alignment.center,
                              width: 200,
                              child: Text(
                            "$messageRed",
                             overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                            ),
                            ),

            ],
          ),
        ));
  }
  setData() async{
    setState(() {
    messageRed = "";
  messageGren = "";
  });
    try{
        
    }catch(e){
      setState(() {
            messageRed = "$e";
          });
    }
  }
  Widget customCard(IconData icon , String title , String content){
    return Directionality(
      textDirection: TextDirection.rtl ,
      child: Card(
                    elevation: 0.2,
                    color: Color(0xfffefefe),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:<Widget>[
                          Row(
                            children:<Widget>[
                              Icon(icon, size:22 , color: Theme.of(context).accentColor),
                              SizedBox(width:5),
                              Text(
                          "$title",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                            ]
                          ),
                          Row(
                            children:<Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                width: 100,
                                child: Text(
                          "$content",
                           overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                        ),
                              ),
                        SizedBox(width:15),
                        Icon(Icons.edit , color: Theme.of(context).accentColor,)
                            ]
                          )
    
                        ]
                      ),
                    ),
    
                    ),
    );
  }
  void _settingModalBottomSheet(context){
    AppState appState = Provider.of<AppState>(context,listen: false);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc){
          return Container(
            height: 110,//(MediaQuery.of(context).size.height*0.18),
            child:  ListView(
            children: <Widget>[
            ListTile(
            leading:  Icon(Icons.edit),
            title:  Text('رفع صورة جديدة',style: TextStyle(fontWeight: FontWeight.w400
            ,fontSize: 15
            ),),
            onTap: () async {
              ImagePicker _picker = ImagePicker();
              await _picker.getImage(source: ImageSource.gallery).then((image){
                File file = File(image.path);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PhotoView(file)));
              });
            }          
          ),
           ListTile(
            leading:  Icon(Icons.delete),
            title:  Text('حذف', style: TextStyle(fontWeight: FontWeight.w400
            ,fontSize: 15
            ),),
            onTap: ()  {
               FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser.uid).update({
                  "image" : "gs://jeeran-24c62.appspot.com/391-3918613_personal-service-platform-person-icon-circle-png-transparent.png"
                    }).whenComplete(() {
                    appState.setChanges(newimage : "gs://jeeran-24c62.appspot.com/391-3918613_personal-service-platform-person-icon-circle-png-transparent.png");
                   EasyLoading.showSuccess("تم حذف الصورة بنجاح",duration: Duration(milliseconds: 600));
                Navigator.pop(context);
                    });
            },          
          ),
            ],
          ),
          );
      }
    );
}

Future<String> _asyncChangesDialog(BuildContext context , String type , String object ) async {
    TextEditingController  _controller = TextEditingController();
    AppState appState = Provider.of<AppState>(context , listen: false);

     return showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return 
    Directionality(
      textDirection:TextDirection.rtl,
      child: AlertDialog(
        contentPadding: EdgeInsets.all(12),
          backgroundColor: Theme.of(context).accentColor,
          title: Text('تعديل $type' ,
          textAlign: TextAlign.start,
           style: TextStyle(
             color: Colors.white,
             fontSize: 18 ,
             fontWeight: FontWeight.normal
             ),),
          content: Form(
            key: _formKey,
            child: TextFormField(
                style: TextStyle(fontSize: 15 , fontFamily:'cairo', color: Colors.white ),
              decoration: InputDecoration(
                 enabledBorder: UnderlineInputBorder(      
                    borderSide: BorderSide(color: Colors.pink[500]),   
                  ),  
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  
                labelStyle: TextStyle(fontSize: 15 , fontFamily:'cairo', color: Colors.white  ),
                hintStyle: TextStyle(fontSize: 15  , fontFamily:'cairo' ,color: Colors.white60),
                  labelText: 'اكتب $type المراد استبداله', hintText: '' , ),
                  controller: _controller,
                  validator: (input) =>
            input.isEmpty ? 'برجاء ملئ هذا الحقل' : null,
            ),),
          actions: <Widget>[
            FlatButton(
              
              child: Text('الغاء' ,
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 14  , fontWeight: FontWeight.normal, color:Colors.white )),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
             FlatButton(
              child: Text('تأكيد',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 14 , fontWeight: FontWeight.normal,color:Colors.white )),
              onPressed: ()  {
                if(_formKey.currentState.validate()){
                setState(() {
                  if (_controller.text.trim().toString() != "") {
                    FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser.uid).update({
                    object : _controller.text.trim().toString()
                  }).whenComplete(() {
                    if(object == "name"){
                    appState.setChanges(newname: _controller.text.trim().toString());
                    }else if(object == "phone"){
                    appState.setChanges(newphone: _controller.text.trim().toString());
                    }else{
                    appState.setChanges(newjop: _controller.text.trim().toString());
                    }
                  });
                  }
                  // object == "name"?this.name = _controller.text: object == "phone"?this.phone =_controller.text:
                  // this.email =_controller.text;
                });
                Navigator.pop(context);
                }
              },
            ),
          ],
    ),
    );
    },
  );
}
}
