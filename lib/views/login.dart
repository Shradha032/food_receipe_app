import 'package:flutter_google_signin/views/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:food_receipe_app/constant.dart';
import 'package:food_receipe_app/localdb.dart';
import 'package:food_receipe_app/services/auth.dart';
import 'package:food_receipe_app/views/profile.dart';
//import 'package:flutter_login_system/services/auth.dart';


class Login extends StatefulWidget {



  @override
  void initState(){

  }

  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  signInMethod(context) async
  {

    await signInWithGoogle();
    constant.name = (await LocalDataSaver.getName())!;
    constant.email = (await LocalDataSaver.getEmail())!;
    constant.img = (await LocalDataSaver.getImg())!;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Profile()));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login to App"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignInButton(Buttons.Google, onPressed: () {
              signInMethod(context);

                         })
          ],
        ),
      ),
    );
  }
}
