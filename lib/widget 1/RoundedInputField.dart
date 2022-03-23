import 'package:flutter/material.dart';
import 'TextFieldContainer.dart';

class RoundedInputField extends StatelessWidget {

  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
   RoundedInputField({
    required Key? key,
    required this.hintText,
    this.icon = Icons.person,
    required this.onChanged,
  }) : super(key: key);
    static final _globalkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {


    return Material(
      child: TextFieldContainer(
        key: _globalkey,
        child: TextField(
          onChanged: onChanged,
          cursorColor: const Color(0xFF6F35A5),
          decoration: InputDecoration(
            icon: Icon(
              icon,
              color: const Color(0xFF6F35A5),
            ),
            hintText: hintText,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}