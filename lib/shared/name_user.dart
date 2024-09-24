// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class getname extends StatefulWidget {
  

  @override
  State<getname> createState() => _getnameState();
}

class _getnameState extends State<getname> {
  @override
  Widget build(BuildContext context) {
    final datacontroler = TextEditingController();

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
          return Text(credential.displayName.toString(),
              style: TextStyle(
                fontSize: 22,
          ));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text(" ${data["full_name"]}",
              style: TextStyle(
                fontSize: 22,
              ));
        }

        return Text("loading");
      },
    );
  }
}
