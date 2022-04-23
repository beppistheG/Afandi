import 'package:flutter/material.dart';
import 'package:netninja_training_session/HomeScreen/components/body.dart';

class Profilescreen extends StatelessWidget {
  static String routeName="/home";
  const Profilescreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

