// ignore_for_file: unused_import, duplicate_import, unused_local_variable, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_comarance_app/pages/chekout.dart';
import 'package:e_comarance_app/pages/login.dart';
import 'package:e_comarance_app/shared/SnackBar.dart';
import 'package:e_comarance_app/shared/colors.dart';
import 'package:e_comarance_app/shared/mytextfirld.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show basename;

import '../shared/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool islouding = false;
  bool isvesable = true;
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final nameController = TextEditingController();
  final titleController = TextEditingController();
  final ageController = TextEditingController();

  String? imgName;
  String? url;
  bool isPassword8Char = false;
  bool hasUppercase = false;
  bool hasDigits = false;
  bool hasLowercase = false;
  bool hasSpecialCharacters = false;
  paswordischange(String password) {
    setState(() {
      if (password.contains(RegExp(r'.{8,}'))) {
        isPassword8Char = true;
      } else {
        isPassword8Char = false;
      }

      if (password.contains(RegExp(r'[A-Z]'))) {
        hasUppercase = true;
      } else {
        hasUppercase = false;
      }
      if (password.contains(RegExp(r'[0-9]'))) {
        hasDigits = true;
      } else {
        hasDigits = false;
      }
      if (password.contains(RegExp(r'[a-z]'))) {
        hasLowercase = true;
      } else {
        hasLowercase = false;
      }
      if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        hasSpecialCharacters = true;
      } else {
        hasSpecialCharacters = false;
      }
    });
  }

  register() async {
    setState(() {
      islouding = !islouding;
    });
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      );
      if (imgName != null && imgPath != null) {
        // Upload image to firebase storage
        final storageRef = FirebaseStorage.instance.ref(imgName);
        await storageRef.putFile(imgPath!);
        url = await storageRef.getDownloadURL();
      }
      CollectionReference users =
          FirebaseFirestore.instance.collection('Users');

      users
          .doc(credential.user!.uid)
          .set({
            'imglink': url,
            'name': nameController.text,
            'title': titleController.text,
            'age': ageController.text,
            'email': emailController.text,
            'pass': passController.text,
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, 'The password provided is too weak.');

        // print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, 'The account already exists for that email.');
        // print('The account already exists for that email.');
      } else {
        showSnackBar(context, 'ERROR - please try again later ..');
      }
    } catch (e) {
      showSnackBar(context, "$e");
    }
    setState(() {
      islouding = !islouding;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passController.dispose();
    ageController.dispose();
    nameController.dispose();
    titleController.dispose();
    super.dispose();
  }

// get img
// -------------------------------------------------------
  File? imgPath;

  uploadImage() async {
    final pickedImg =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    try {
      if (pickedImg != null) {
        setState(() {
          imgPath = File(pickedImg.path);
          imgName = basename(pickedImg.path);
        });
      } else {
        print("NO img selected");
      }
    } catch (e) {
      print("Error => $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: screen,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: appbar,
          title: const Text("Rigister"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //   img
                    Stack(
                      children: [
                        (imgPath == null)
                            ? CircleAvatar(
                                radius: 77,
                                backgroundColor:
                                    Color.fromARGB(255, 173, 173, 173),
                                backgroundImage:
                                    AssetImage("assets/img/avatar (1).png"),
                              )
                            : ClipOval(
                                child: Image.file(
                                  imgPath!,
                                  width: 145,
                                  height: 145,
                                  fit: BoxFit.cover,
                                ),
                              ),
                        Positioned(
                            right: -10,
                            bottom: -10,
                            child: IconButton(
                                iconSize: 33,
                                color: BTNblue,
                                onPressed: () {
                                  uploadImage();
                                },
                                icon: Icon(Icons.image))),
                      ],
                    ),

                    const SizedBox(
                      height: 33,
                    ),

                    // textfields
                    // ---------------------------------------------------------------------------------
                    TextField(
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.person),
                          hintText: "Enter your username",
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
                    TextField(
                        controller: titleController,
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.person_outlined),
                          hintText: "Enter your title",
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
                    TextField(
                        controller: ageController,
                        keyboardType: TextInputType.number,
                        obscureText: false,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.pest_control_rodent),
                          hintText: "Enter your age",
                          // To delete borders
                          enabledBorder: OutlineInputBorder(
                            borderSide: Divider.createBorderSide(context),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 158, 158, 158),
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
                          suffixIcon: const Icon(Icons.email),
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
                        onChanged: (password) {
                          setState(() {
                            paswordischange(password);
                          });
                        },
                        validator: (value) {
                          return isPassword8Char &&
                                  hasUppercase &&
                                  hasDigits &&
                                  hasLowercase &&
                                  hasSpecialCharacters
                              ? null
                              : "week passwoed ..";
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: passController,
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
                    //  cheak boxes
                    // --------------------------------------------------------------------------------
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                isPassword8Char ? BTNblue : Colors.white,
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 189, 189, 189)),
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                        const SizedBox(
                          width: 11,
                        ),
                        const Text("At least 8 characters"),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: hasDigits ? BTNblue : Colors.white,
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 189, 189, 189)),
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                        const SizedBox(
                          width: 11,
                        ),
                        const Text("At least 1 number"),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: hasUppercase ? BTNblue : Colors.white,
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 189, 189, 189)),
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                        const SizedBox(
                          width: 11,
                        ),
                        const Text("Has Uppercase"),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: hasLowercase ? BTNblue : Colors.white,
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 189, 189, 189)),
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                        const SizedBox(
                          width: 11,
                        ),
                        const Text("Has  Lowercase "),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: hasSpecialCharacters
                                ? BTNblue
                                : Colors.white,
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 189, 189, 189)),
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                        const SizedBox(
                          width: 11,
                        ),
                        const Text("Has  Special Characters "),
                      ],
                    ),
                    const SizedBox(
                      height: 33,
                    ),
                    //  -----------------------------------------------------------------------
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await register();
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
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              "Register",
                              style: TextStyle(fontFamily: "myfont",fontWeight: FontWeight.w600,fontSize: 19),
                            ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Do not have an account ?",
                          style: TextStyle(fontFamily: "myfont",fontWeight: FontWeight.w600,fontSize: 19),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()),
                            );
                          },
                          child: const Text('signin',
                              style: TextStyle(fontFamily: "myfont",fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 0, 137, 250),
                                  fontSize: 19)),
                        )
                      ],
                    ),
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
