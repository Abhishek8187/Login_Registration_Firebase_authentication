import 'package:flutter/material.dart';

class TextFields extends StatefulWidget {

   String hint='default';
   String icon;
  final String returnText;
    TextFields({Key? key,
     required this.hint,
     required this. icon,
     required this.returnText,
     } ) : super(key: key);

  @override
  State<TextFields> createState() => _TextFieldsState();
}

class _TextFieldsState extends State<TextFields> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //controller: ,
      obscureText: true,
      decoration:  InputDecoration(
        hintText: widget.hint,
        prefixIcon: Icon(Icons.account_box_sharp),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return widget.returnText;
        } else {
          return null;
        }
      },
    );
  }
}
