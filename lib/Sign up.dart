
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:netninja_training_session/widget 1/RoundedInputField.dart';

import 'HomeScreen/Profile screen.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late String _email,_password,_name;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(

        child: SingleChildScrollView(

          child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: <Widget>[

            const Text(
              "SIGN UP",
              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 60.0),
            ),
            SizedBox(height: size.height * 0.03),

            RoundedInputField(

              onChanged: (value) {
                setState(() {
                  _name = value.trim();
                });
              },hintText: "Your Name",
              key: null,
            ),
            RoundedInputField(

              onChanged: (value) {
                setState(() {
                  _email = value.trim();
                });
              }, hintText: "Your Email",
              key: null,
            ),
            RoundedInputField(
              onChanged: (value) {
                setState(() {
                  _password = value.trim();
                });
              }, hintText: 'Password',
              key: null,
            ),
            RawMaterialButton(

              onPressed: () async {
                if (validateStructure(_password) == false) {
                  showAlertDialog(context);
                }
                else {
                  try {
                    auth.createUserWithEmailAndPassword(
                        email: _email, password: _password);
                    await auth.currentUser?.reload();
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => Profilescreen()));
                  }
                  catch (e) {
                    print("The exception thrown is $e");
                  }
                  finally {
                    User? user = FirebaseAuth.instance.currentUser;

                    FirebaseFirestore.instance.collection("users").doc(
                        user?.uid).set({
                      'uid': user?.uid,
                      'email': _email,
                      'password': _password,
                      'role': 'user',
                      'username' : _name,
                      'imageURL': 'https://firebasestorage.googleapis.com/v0/b/email-login-1be37.appspot.com/o/blank-profile-picture-973460_1280.jpg?alt=media&token=dc22531c-64a8-4ec7-af0d-1e4618cd1748',
                    });
                  };
                };
              },
            ),
            SizedBox(height: size.height * 0.03),
          ],
            ),
        ),
      ),
    );
  }
}

bool validateStructure(String value) {
  String pattern = r'^(?=.?[A-Z])(?=.?[a-z])(?=.*?[0-9])';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}
showAlertDialog(BuildContext context) {

  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Error"),
    content: const Text(
        'your password have to include'
            '\n Minimum 1 Upper case'
            '\n Minimum 1 lowercase'
            '\n Minimum 1 Numeric Number'
            '\n and password length more than 6' ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}