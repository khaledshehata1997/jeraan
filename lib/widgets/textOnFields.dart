import 'package:flutter/material.dart';

Widget textOnFields(BuildContext context, String text, bool isgreen) {
  return Text(
    text,
    style: TextStyle(
        fontSize: MediaQuery.of(context).size.width * .05,
        color: isgreen ? Theme.of(context).primaryColor : Colors.black45,
        fontWeight: FontWeight.w500),
  );
}

Widget bigTextForErrors(BuildContext context, String text, bool isgreen){
   return Text(
    text,
    style: TextStyle(
        fontSize: MediaQuery.of(context).size.width * .08,
        color: isgreen ? Theme.of(context).primaryColor : Colors.black45,
        fontWeight: FontWeight.w500),
  );
}
