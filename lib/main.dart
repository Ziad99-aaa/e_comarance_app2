// ignore_for_file: prefer_const_constructors

import 'package:e_comarance_app/pages/home.dart';
import 'package:e_comarance_app/pages/login.dart';
import 'package:e_comarance_app/pages/verifyEmail_page.dart';
import 'package:e_comarance_app/provider/cart.dart';
import 'package:e_comarance_app/provider/google_signin.dart';
import 'package:e_comarance_app/shared/SnackBar.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return Cart();
        }),
        ChangeNotifierProvider(create: (context) {
          return GoogleSignInProvider();
        }),
      ],
      child: MaterialApp(
          
          debugShowCheckedModeBanner: false,
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // return VerifyEmailPage(); // home() OR verify email
                return home(); 
              } else {
                return Login();
              }
            },
          )),
    );
  }
}
