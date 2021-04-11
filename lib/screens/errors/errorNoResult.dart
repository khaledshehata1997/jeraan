import 'package:flutter/material.dart';
import 'package:jeraan_project/widgets/default_button.dart';
import 'package:jeraan_project/widgets/textOnFields.dart';

class ErrorNoResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image(image: AssetImage("images/person.png"), width: width),
                SizedBox(height: 20),
                Center(child: bigTextForErrors(context, "No Result", true)),
                SizedBox(height: 20),
                Center(
                  child: Container(
                    width: width*0.9,
                    child: Text(
                      "Sorry, there are no results for this search, Please try another phrase",
                      style: TextStyle(
                          fontSize: width * .05,
                          color: Colors.black45,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                    child: DefaultButton(
                  text: "go back to search",
                  press: () {},
                )),
                SizedBox(height: 40),
              ]),
        ),
      ),
    );
  }
}
