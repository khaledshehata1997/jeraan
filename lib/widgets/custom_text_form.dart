import 'package:flutter/material.dart';
import 'package:jeraan_project/screens/serves/appstate.dart';
import 'package:provider/provider.dart';

class CustomTextForm extends StatefulWidget {
  var obScur;
  var validate;
  var controller;
  CustomTextForm( var obScur, var validate , {var controller} ){
    this.obScur=obScur;
    this.validate=validate;
    this.controller = controller;
  }

  @override
  _CustomTextFormState createState() => _CustomTextFormState();
}

class _CustomTextFormState extends State<CustomTextForm> {
  var hint;
  
  @override
  Widget build(BuildContext context) {
     AppState appState = Provider.of<AppState>(context);
    var mediQuery = MediaQuery.of(context).size;
    return Directionality(textDirection:appState.getlocal == "ar"? TextDirection.rtl : TextDirection.ltr,
      child: Stack(
                      children: [
                        Padding(
        padding: EdgeInsets.symmetric(horizontal: 6,vertical: 2),
        child: TextFormField(
          controller: widget.controller,
          obscureText: widget.obScur,
            validator: (value){
              if (value.isEmpty)
                return '${widget.validate}';
            },
            cursorColor:Colors.pink[800] ,
            decoration: InputDecoration(
              errorStyle: TextStyle(
                fontSize:15
              ),
             // contentPadding: new EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
              contentPadding: EdgeInsets.only(left: 15 , right:15),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                      width: 1,
                      style:BorderStyle.values[1],
                      color: Colors.black45
                  )
              ),
              errorBorder:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                      width: 3,
                      style:BorderStyle.values[1],
                      color: Colors.black45
                  )
              ),
    
              focusedBorder:  OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                      color: Colors.black45
                  )
              ),
    
            )
        ),
      ) ,
                       widget.obScur? Positioned(
                            top: mediQuery.height * .025,
                            left: mediQuery.width * .83,
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    widget.obScur = !widget.obScur;
                                  });
                                },
                                child: Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: Colors.black45,
                                ))):Container()
                      ],
                    ),
    );
  }
}
