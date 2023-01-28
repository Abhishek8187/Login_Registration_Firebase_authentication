import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intern_task/UI/auth/login_screen.dart';
import 'package:intern_task/UI/splash_screen.dart';
import 'package:intern_task/firebase_services/splash_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.pink,
      ),
      home:SplashScreen()
    );
  }
}

