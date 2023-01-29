import 'package:flutter/material.dart';

class TextFields extends StatefulWidget {

  TextEditingController controller;
  String hintText;
  Icon icon;
  String returnText;

  TextFields({Key? key, required this.controller,
  required this.hintText,
  required this.icon,
  required this.returnText
  }) : super(key: key);



  @override
  State<TextFields> createState() => _TextFieldsState();
}

class _TextFieldsState extends State<TextFields> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration:  InputDecoration(
        hintText: widget.hintText,
        //helperText: 'e.g: abc@gmail.com',
        prefixIcon: widget.icon,
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
