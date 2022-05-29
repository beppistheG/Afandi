import 'package:flutter/widgets.dart';
import 'package:netninja_training_session/HomeScreen/Profile%20screen.dart';


import 'package:netninja_training_session/main.dart';
import 'package:netninja_training_session/Sign up.dart';
import 'package:netninja_training_session/sign_up/sign_up_screen.dart';


// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {

  Profilescreen.routeName: (context) => Profilescreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),



};