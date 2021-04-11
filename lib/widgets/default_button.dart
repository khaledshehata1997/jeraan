import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final Function press;
  DefaultButton({
    this.text,
    this.press,
  });

  @override
  Widget build(BuildContext context) {
    var mediaQuery =MediaQuery.of(context).size;
    return SizedBox(
      width: mediaQuery.width*0.94,
      height: mediaQuery.height*0.07,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: Colors.pink[800],
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}