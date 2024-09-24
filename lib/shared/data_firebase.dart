// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GetData extends StatefulWidget {
  final String documentId;

  const GetData({super.key, required this.documentId});

  @override
  State<GetData> createState() => _GetDataState();
}

class _GetDataState extends State<GetData> {
  @override
  Widget build(BuildContext context) {
    final datacontroler = TextEditingController();

    final credential = FirebaseAuth.instance.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('Users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Email : ${credential!.email}",
                style: TextStyle(
                  fontSize: 27,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "created at : ${credential!.metadata.creationTime.toString().substring(0, 11)} ",
                style: TextStyle(
                  fontSize: 27,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Last Signin : ${credential!.metadata.lastSignInTime.toString().substring(2, 16)}     ",
                style: TextStyle(
                  fontSize: 27,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Name : ${credential.displayName}",
                    style: TextStyle(
                      fontSize: 27,
                    ),
                  ),
                ],
              ),
            ],
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Email : ${credential!.email}",
                style: TextStyle(
                  fontSize: 27,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "created at : ${credential!.metadata.creationTime.toString().substring(0, 11)} ",
                style: TextStyle(
                  fontSize: 27,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Last Signin : ${credential!.metadata.lastSignInTime.toString().substring(2, 16)}     ",
                style: TextStyle(
                  fontSize: 27,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Name : ${data["full_name"]}",
                    style: TextStyle(
                      fontSize: 27,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(11)),
                              child: Container(
                                padding: EdgeInsets.all(22),
                                height: 200,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextField(
                                        controller: datacontroler,
                                        maxLength: 20,
                                        decoration: InputDecoration(
                                            hintText: "Add new Name")),
                                    SizedBox(
                                      height: 22,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              setState(() {
                                                users
                                                    .doc(credential!.uid)
                                                    .update({
                                                  "full_name":
                                                      datacontroler.text
                                                });
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Edit",
                                              style: TextStyle(fontSize: 22),
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(fontSize: 22),
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.edit))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Title : ${data["title"]}",
                    style: TextStyle(
                      fontSize: 27,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(11)),
                              child: Container(
                                padding: EdgeInsets.all(22),
                                height: 200,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextField(
                                        controller: datacontroler,
                                        maxLength: 20,
                                        decoration: InputDecoration(
                                            hintText: "Add New Title")),
                                    SizedBox(
                                      height: 22,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              setState(() {
                                                users
                                                    .doc(credential!.uid)
                                                    .update({
                                                  "title": datacontroler.text
                                                });
                                              });

                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Edit",
                                              style: TextStyle(fontSize: 22),
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(fontSize: 22),
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.edit))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Age : ${data["age"]}",
                    style: TextStyle(
                      fontSize: 27,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(11)),
                              child: Container(
                                padding: EdgeInsets.all(22),
                                height: 200,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextField(
                                        controller: datacontroler,
                                        keyboardType: TextInputType.number,
                                        maxLength: 20,
                                        decoration: InputDecoration(
                                            hintText: "Add New Age")),
                                    SizedBox(
                                      height: 22,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              setState(() {
                                                users
                                                    .doc(credential!.uid)
                                                    .update({
                                                  "age": datacontroler.text
                                                });
                                              });

                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Edit",
                                              style: TextStyle(fontSize: 22),
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(fontSize: 22),
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.edit))
                ],
              ),
            ],
          );
        }

        return Text("loading");
      },
    );
  }
}
