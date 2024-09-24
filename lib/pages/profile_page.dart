import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_comarance_app/shared/colors.dart';
import 'package:e_comarance_app/shared/data_firebase.dart';
import 'package:e_comarance_app/shared/img_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' show basename;

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? imgPath;
  String? imgName;
  final credential = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  uploadImage2Screen() async {
    final pickedImg =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    try {
      if (pickedImg != null) {
        setState(() {
          imgPath = File(pickedImg.path);
          imgName = basename(pickedImg.path);
          int random = Random().nextInt(9999999);
          imgName = "$random$imgName";
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
    return Scaffold(
      backgroundColor: screen,
      appBar: AppBar(
        backgroundColor: appbar,
        title: const Text("Your Profile"),
        actions: [
          GestureDetector(
            onTap: () async {
              await FirebaseAuth.instance.signOut();

              Navigator.pop(context);
            },
            child: const Row(
              children: [
                Icon(Icons.logout),
                Text(
                  "Logout",
                  style: TextStyle(fontFamily: "myfont",fontWeight: FontWeight.w600,color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 22,
                ),
                Center(
                  child: Stack(
                    children: [
                      (imgPath == null)
                          ? UserImg()
                          : ClipOval(
                              child: Image.file(
                                imgPath!,
                                width: 145,
                                height: 145,
                                fit: BoxFit.cover,
                              ),
                            ),
                      Positioned(
                          right: -12,
                          bottom: -10,
                          child: IconButton(
                              iconSize: 33,
                              color: Color.fromARGB(255, 16, 16, 16),
                              onPressed: () async {
                                await uploadImage2Screen();

                                if (imgPath != null) {
                                  // Upload image to firebase storage
                                  final storageRef =
                                      FirebaseStorage.instance.ref(imgName);
                                  await storageRef.putFile(imgPath!);
                                  // Get img url
                                  String urlll =
                                      await storageRef.getDownloadURL();

                                  users.doc(credential!.uid).update({
                                    "imglink": urlll,
                                  });
                                }
                              },
                              icon: Icon(Icons.edit))),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 22,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GetData(documentId: FirebaseAuth.instance.currentUser!.uid)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
