import 'dart:async';


import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:intern_task/UI/auth/login_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{  //used for animation duration


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5 ),
            ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()))
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[

            SizedBox(height: MediaQuery.of(context).size.height * 0.08,),
            const Align(
              alignment: Alignment.center,
              child: Text('Welcome to my App\n (please wait)',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
            )

          ],
        ),
      ),
    );
  }
}
