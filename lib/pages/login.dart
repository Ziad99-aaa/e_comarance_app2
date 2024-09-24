// ignore_for_file: unused_import, unused_local_variable, use_build_context_synchronously, prefer_const_constructors

import 'package:e_comarance_app/pages/Forgot.dart';
import 'package:e_comarance_app/pages/register.dart';
import 'package:e_comarance_app/provider/google_signin.dart';
import 'package:e_comarance_app/shared/SnackBar.dart';
import 'package:e_comarance_app/shared/colors.dart';
import 'package:e_comarance_app/shared/mytextfirld.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailcontroller = TextEditingController();
  final passcontroller = TextEditingController();
  bool isvesable = true;
  bool islouding = false;
  login() async {
    setState(() {
      islouding = !islouding;
    });
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailcontroller.text, password: passcontroller.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(context, "No user found for that email.");
        // print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showSnackBar(context, "Wrong password provided for that user.");
        // print('Wrong password provided for that user.');
      } else {
        showSnackBar(context, "ERROR - please try again later ..");
      }
    }
    setState(() {
      islouding = !islouding;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailcontroller.dispose();
    passcontroller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final googlesignin = Provider.of<GoogleSignInProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: screen,
        appBar: AppBar(
          backgroundColor: appbar,
          title: const Text(
            "Sign In",
            style: TextStyle(fontFamily: "myfont", fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: double.infinity,
                      height: 211,
                      child: Image.asset("assets/img/sigin.png",fit: BoxFit.fill,)),
                  TextFormField(
                      // autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: emailcontroller,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.email),
                        hintText: "Enter your email",
                        // To delete borders
                        enabledBorder: OutlineInputBorder(
                          borderSide: Divider.createBorderSide(context),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        // fillColor: Colors.red,
                        filled: true,
                        contentPadding: const EdgeInsets.all(8),
                      )),
                  const SizedBox(
                    height: 33,
                  ),
                  TextFormField(

                      // autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: passcontroller,
                      keyboardType: TextInputType.text,
                      obscureText: isvesable,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isvesable = !isvesable;
                            });
                          },
                          icon: Icon(isvesable
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        hintText: "Enter your password",
                        // To delete borders
                        enabledBorder: OutlineInputBorder(
                          borderSide: Divider.createBorderSide(context),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        // fillColor: Colors.red,
                        filled: true,
                        contentPadding: const EdgeInsets.all(8),
                      )),
                  const SizedBox(
                    height: 33,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        login();
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(BTNblue),
                      padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                    ),
                    child: islouding
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            "Sign in",
                            style: TextStyle(
                                fontFamily: "myfont",
                                fontWeight: FontWeight.w600,
                                fontSize: 19),
                          ),
                  ),
                  SizedBox(
                    height: 33,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Forgot()),
                        );
                      },
                      child: Text("forgot password ?",
                          style: TextStyle(
                              fontFamily: "myfont",
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              decoration: TextDecoration.underline))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Do not have an account ?",
                        style: TextStyle(
                            fontFamily: "myfont",
                            fontWeight: FontWeight.w600,
                            fontSize: 19),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Register()),
                          );
                        },
                        child: Text('signup',
                            style: TextStyle(
                                fontFamily: "myfont",
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 0, 137, 250),
                                fontSize: 19,
                                decoration: TextDecoration.underline)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 17,
                  ),
                  SizedBox(
                    width: 299,
                    child: Row(
                      children: const [
                        Expanded(
                            child: Divider(
                          thickness: 0.6,
                          color: Colors.black,
                        )),
                        Text(
                          "OR",
                          style: TextStyle(
                            fontFamily: "myfont",
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Expanded(
                            child: Divider(
                          thickness: 0.6,
                          color: Colors.black,
                        )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 17,
                  ),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        islouding = true;
                      });

                      await googlesignin.googlelogin();
                    },
                    child: Container(
                      padding: EdgeInsets.all(13),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.red, width: 2)),
                      child: SvgPicture.asset(
                        "assets/icons/google-plus.svg",
                        color: Colors.red,
                        height: 27,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
