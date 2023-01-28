import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:intern_task/UI/auth/login_screen.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void isLogin(BuildContext context) {

    final _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;  //to check if there is already some data or not

    if(user!= null){          //if user has already data then he is already login
      Timer(
        Duration(seconds: 3),
            () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        ),
      );
    }
    else{         //user not already login
      Timer(
        Duration(seconds: 3),
            () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        ),
      );
    }

  }
}
