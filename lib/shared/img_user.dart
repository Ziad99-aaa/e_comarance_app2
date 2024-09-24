// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserImg extends StatefulWidget {
  const UserImg({
    super.key,
  });

  @override
  State<UserImg> createState() => _UserImgState();
}

class _UserImgState extends State<UserImg> {
  @override
  Widget build(BuildContext context) {
    final credential = FirebaseAuth.instance.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('Users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(credential!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return CircleAvatar(
            radius: 77,
            backgroundColor: Color.fromARGB(255, 173, 173, 173),
            backgroundImage: NetworkImage(credential.photoURL.toString()),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return CircleAvatar(
            radius: 77,
            backgroundColor: Color.fromARGB(255, 173, 173, 173),
            backgroundImage: NetworkImage("${data['imglink']}"),
          );
        }

        return Text("loading");
      },
    );
  }
}
