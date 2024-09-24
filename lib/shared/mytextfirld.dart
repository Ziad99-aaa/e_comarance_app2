import 'package:flutter/material.dart';

class mytextfield extends StatelessWidget {
  final TextInputType textinput;
  final bool scure;
  final String text;
  final String myController;
  mytextfield({
    super.key,
    this.myController="",
    required this.textinput,
    required this.text,
    required this.scure,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      
        keyboardType: textinput,
        obscureText: scure,
        decoration: InputDecoration(
          hintText: text,
          // To delete borders
          enabledBorder: OutlineInputBorder(
            borderSide: Divider.createBorderSide(context),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          // fillColor: Colors.red,
          filled: true,
          contentPadding: const EdgeInsets.all(8),
        ));
  }
}
