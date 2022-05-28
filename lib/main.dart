import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:netninja_training_session/HomeScreen/Profile screen.dart';
import 'package:netninja_training_session/sign_up/sign_up_screen.dart';

import 'Sign up.dart';
import 'size_config.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SizeConfig());

    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //Initialize Flutter app


  Future<FirebaseApp>  _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

// The change of the  Widget happens here




  // YES The change is here
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context , snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return LoginScreen();
          }
          return const Center ( child: CircularProgressIndicator(),
          );
        },

      ),
    );
  }
}
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);


  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


//Login system

  static Future<User?> loginUsingEmailPassword({required String email, required String password, required BuildContext context}) async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user ;
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    }
    on FirebaseAuthException catch(e){
      if(e.code == "user-not-found"){
        print("This user does not Exist");
      }
    }
    return user;
  }


  @override
  Widget build(BuildContext context) {
// create the TextEditingController controller
    TextEditingController _emailController= TextEditingController();
    TextEditingController _passwordController= TextEditingController();




    return Padding(
      padding: const EdgeInsets.all(
          16.0), //Used const to make the value the same for everyone
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [

          const Text(" Login to your account",
              style:TextStyle(color: Colors.black12, fontSize: 44.0,fontWeight: FontWeight.bold )
          ),
          const SizedBox(height: 44,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration:  const InputDecoration(
                hintText: "Enter Email",
                prefixIcon: Icon(Icons.mail , color: Colors.black),

              ),
            ),
          ),
          const SizedBox( height: 26.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Enter Password",
                prefixIcon: Icon(Icons.lock , color: Colors.black),
              ),
            ),
          ),
          const SizedBox( height: 16.0,
          ),
          const Text( "Forgot password ?" , textAlign: TextAlign.center, style: TextStyle(color: Colors.red)
          ),
          const SizedBox( height: 88.0,
          ),
          SizedBox(
            width: double.infinity,
            child: RawMaterialButton(fillColor: const Color(0xFF0069FE) ,onPressed: () async {
              //test the app
              User? user = await loginUsingEmailPassword(email: _emailController.text, password: _passwordController.text, context: context);
              print(user);
              if(user != null){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Profilescreen()));
              }
            },
              child: const Text("Login", style: TextStyle(color: Colors.white, fontSize: 20.0), ),
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0)),),

          ),
          SizedBox(
            width: double.infinity,
            child: RawMaterialButton(
              fillColor: Colors.white,
              elevation : 0.0,
              padding: const EdgeInsets.symmetric(vertical: 20.0,),
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0)),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute( builder: (context) => SignUpScreen()));
              },
              child: const Text("Sign up", style: TextStyle(color: Colors.black, fontSize: 20.0)),
            ),
          )
        ],
      ),
    );
  }
}
