// ignore_for_file: prefer_const_constructors

import 'package:e_comarance_app/shared/SnackBar.dart';
import 'package:e_comarance_app/shared/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Forgot extends StatefulWidget {
  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  final _formKey = GlobalKey<FormState>();
  bool islouding = false;
  final emailController = TextEditingController();

  reset() async {
    setState(() {
      islouding = !islouding;
    });

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Forgot()),
      );
      showSnackBar(context, "Done ");
    } catch (e) {
      showSnackBar(context, "ERROR - $e");
    }
    setState(() {
      islouding = !islouding;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: screen,
      appBar: AppBar(
        backgroundColor: appbar,
        title: Text("Forgot Page"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(33.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/img/Forgot password-bro.png"),
                  Text(
                    "Enter your Email to reset password ",
                    style: TextStyle(fontFamily: "myfont",fontWeight: FontWeight.w600,fontSize: 18),
                  ),
                  const SizedBox(
                    height: 33,
                  ),
                  TextFormField(
                      validator: (value) {
                        return value!.contains(RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                            ? null
                            : "Enter a valid email";
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.email),
                        hintText: "Enter your email",
                        // To delete borders
                        enabledBorder: OutlineInputBorder(
                          borderSide: Divider.createBorderSide(context),
                        ),
                        focusedBorder: OutlineInputBorder(
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        reset();
                      } else {
                        showSnackBar(
                            context, "ERROR - please try again later.");
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(BTNblue),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(12)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                    ),
                    child: islouding
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            "reset",
                            style: TextStyle(fontFamily: "myfont",fontWeight: FontWeight.w600,fontSize: 19),
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
