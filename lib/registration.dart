import'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:netninja_training_session/main.dart';




class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final _auth = FirebaseAuth.instance;
  bool showProgress = false;
  //form key
  final _formkey = GlobalKey<FormState>();
  //editing controller
  final firstNameEditingController = new TextEditingController();
  final secondNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmpasswordEditingController = new TextEditingController();


  @override
  Widget build(BuildContext context) {



    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.name,
      //validator: () {}
      onSaved: (value){
        firstNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "First Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );



    final secondNameField = TextFormField(
      autofocus: false,
      controller: secondNameEditingController,
      keyboardType: TextInputType.name,
      //validator: () {}
      onSaved: (value){
        secondNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Second Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );



    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      //validator: () {}
      onSaved: (value){
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );



    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => value != null && value.length < 6
      ? 'Enter at least 6 characters' : null     ,
      onSaved: (value){
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );


    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmpasswordEditingController,
      obscureText: true,
      //validator: () {}
      onSaved: (value){
        confirmpasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Confirm Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );


    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.deepOrange,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async {

          setState(() {
            showProgress = true;
          });

          Future RegistrationScreen() async{
            final isValid = _formkey.currentState!.validate();
            if(!isValid) return;
          }

          try {
            final newuser =
            await _auth.createUserWithEmailAndPassword(
                email: emailEditingController.text.trim(), password: passwordEditingController.text.trim());
            if (newuser != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage()),
              );
              setState(() {
                showProgress = false;
              });
            }
          } catch (e) {}
        },
        child: Text(
          "Sign UP",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: Colors.white,fontWeight: FontWeight.bold ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red,),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 180,
                      child: Image.asset(
                        "assets/images/logo.PNG",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 45),
                    firstNameField,
                    SizedBox(height: 20),
                    secondNameField,
                    SizedBox(height: 20),
                    emailField,
                    SizedBox(height: 20),
                    passwordField,
                    SizedBox(height: 20),
                    confirmPasswordField,
                    SizedBox(height: 20),
                    signUpButton,
                    SizedBox(height: 15)




                  ],
                ),
              ),
            ),
          ),
        ),
      ),

    );
  }
}
