import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeraan_project/constants.dart';
import 'package:jeraan_project/screens/serves/appstate.dart';
import 'package:jeraan_project/widgets/default_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  // var radioVal='value';
  var radioVal2='value';

  @override
  void initState() {
    AppState appState = Provider.of<AppState>(context , listen:false);
    setState(() {
     radioVal2 =  appState.getlocal == "en" ? "English" : "arabic";
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppState appState = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(appState.getlocal == "ar"?'الأعدادات':"Settings"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //  Container(
            //    alignment: Alignment.topRight,
            //    margin: EdgeInsets.all(12),
            //    padding: EdgeInsets.all(8),
            //    decoration: BoxDecoration(
            //      borderRadius: BorderRadius.circular(8),
            //      color: Colors.white,
            //      boxShadow: [
            //        BoxShadow(
            //          spreadRadius: 2,
            //          blurRadius: 8,
            //          color: Colors.grey
            //        ),
            //      ]
            //    ),
            //    child: Column(
            //      children: [
            //        Text('وضع التطبيق',style: TextStyle(
            //            fontWeight:FontWeight.bold,fontSize: 18,color: mainColor),),
            //        Row(
            //          mainAxisAlignment: MainAxisAlignment.end,
            //          children: [
            //            Text('وضع النهار'),
            //            Radio(
      
            //              value: 'val1',
            //              groupValue:radioVal ,
            //              onChanged: (val){
            //                setState(() {
            //                  radioVal=val;
            //                });
            //              },
            //            ),
            //          ],
            //        ),
            //        Row(
            //          mainAxisAlignment: MainAxisAlignment.end,
            //          children: [
            //            Text('وضع الليل'),
            //            Radio(
            //              value: 'val2',
            //              groupValue:radioVal ,
            //              onChanged: (val){
            //                setState(() {
            //                  radioVal=val;
            //                });
            //              },
            //            ),
            //          ],
            //        ),
      
            //      ],
            //    ),
            //    width:Get.width*.95,
            //  ),
             
             Container(
               alignment:  Alignment.topRight,
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
                   Text(appState.getlocal == "ar"?'لغة التطبيق' : "App Language",style: TextStyle(
                       fontWeight:FontWeight.bold,fontSize: 18,color: mainColor),),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       Radio(
                         value: 'arabic',
                         groupValue:radioVal2 ,
                         onChanged: (val){
                           setState(() {
                             radioVal2=val;
                           });
                         },
                       ),
                       Text(appState.getlocal == "ar"?'العربية':"Arabic"),
                       
                     ],
                   ),
                   Row(
                     mainAxisAlignment:  MainAxisAlignment.start,
                     children: [
                       Radio(
                         value: 'English',
                         groupValue:radioVal2 ,
                         onChanged: (val){
                           setState(() {
                             radioVal2=val;
                           });
                         },
                       ),
                       Text(appState.getlocal == "ar"?'الانجليزية':"English"),
                       
                     ],
                   ),
                 ],
               ),
               width:Get.width*.95,
             ),
            SizedBox(height: 20,),
            DefaultButton(
              text: appState.getlocal == "ar"?'حفظ التغييرات':"Save Changes",
              press: ()async{
                AppState appState = Provider.of<AppState>(context , listen:false);
                if(radioVal2 == "arabic"){
                  appState.setLocal("ar");
                  resetLang("ar");
                }else if(radioVal2 == "English"){
                  appState.setLocal("en");
                  resetLang("en");
                }
              },
            )
      
          ],
        ),
      ),
    );
  }
  resetLang(local) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("local", "$local");
  }
}
