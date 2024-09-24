// ignore_for_file: prefer_const_constructors, sort_child_properties_last, camel_case_types, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_comarance_app/pages/chekout.dart';
import 'package:e_comarance_app/pages/details.dart';
import 'package:e_comarance_app/pages/login.dart';
import 'package:e_comarance_app/pages/profile_page.dart';
import 'package:e_comarance_app/provider/cart.dart';
import 'package:e_comarance_app/shared/colors.dart';
import 'package:e_comarance_app/shared/img_user.dart';
import 'package:e_comarance_app/shared/name_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/item.dart';

class home extends StatefulWidget {
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  late Cart cart;
  bool darkmode = false;
  @override
  Widget build(BuildContext context) {
    final credential = FirebaseAuth.instance.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    return Scaffold(
      backgroundColor: screen,
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 12),
          itemCount: item.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(30)),
              margin: EdgeInsets.only(top: 10),
              child: GridTile(
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => details(
                            prodect: item[index],
                          ),
                        ),
                      );
                    },
                    // use ClipRRect & Positioned
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          right: 0,
                          left: 1,
                          top: -2,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(55),
                              child: Image.asset(item[index].imglink)),
                        ),
                      ],
                    )),
                footer: GridTileBar(
                  backgroundColor: Color.fromRGBO(15, 45, 89, 0.718),
                  trailing: Consumer<Cart>(
                      builder: ((context, classInstancee, child) {
                    return IconButton(
                        color: Colors.white,
                        onPressed: () {
                          classInstancee.add(item[index]);
                        },
                        icon: Icon(Icons.add));
                  })),
                  leading: Text(
                    "\$${item[index].price}",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  title: Text(
                    "",
                  ),
                ),
              ),
            );
          }),
      drawer: Drawer(
        backgroundColor: screen,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/img/wall.jpg"),
                          fit: BoxFit.cover),
                    ),
                    accountName: getname(),
                    accountEmail: Text(credential!.email.toString()),
                    currentAccountPictureSize: Size.square(77),
                    currentAccountPicture: UserImg()
                    // NetworkImage(user.photoURL!)

                    ),
                ListTile(
                    title: Text("Home"),
                    leading: Icon(Icons.home),
                    onTap: () {
                      Navigator.pop(context);
                    }),
                ListTile(
                    title: Text("My products"),
                    leading: Icon(Icons.add_shopping_cart),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Checkout()),
                      );
                    }),
                ListTile(
                    title: Text("About"),
                    leading: Icon(Icons.help_center),
                    onTap: () {}),
                ListTile(
                    title: Text("Profile"),
                    leading: Icon(Icons.person),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    }),
                ListTile(
                    title: Text("Logout"),
                    leading: Icon(Icons.exit_to_app),
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                    }),
                // ListTile(title: Text("Logout"),leading: darkmode?Icon(Icons.dark_mode):Icon(Icons.light_mode),onTap: () {setState(() {darkmode = !darkmode ; }); }),
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: 12),
              child: Text("Developed by ziad Ramy © 2024",
                  style: TextStyle(
                      fontFamily: "myfont",
                      fontWeight: FontWeight.w600,
                      fontSize: 16)),
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: appbar,
        title: Text(style: TextStyle(fontFamily: "myfont",fontSize: 22,fontWeight: FontWeight.w600),"Home"),
        actions: [
          Row(
            children: [
              Stack(
                children: [
                  Container(
                      child: Consumer<Cart>(
                          builder: ((context, classInstancee, child) {
                        return Text(
                          "${classInstancee.selectitems.length}",
                          style: TextStyle(
                              fontFamily: "myfont",
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        );
                      })),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: BTNblue, shape: BoxShape.circle)),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Checkout()),
                        );
                      },
                      icon: Icon(Icons.add_shopping_cart)),
                ],
              ),
              Consumer<Cart>(builder: ((context, classInstancee, child) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Text(
                    "\$ ${classInstancee.total}",
                    style: TextStyle(
                        fontFamily: "myfont",
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                );
              }))
            ],
          )
        ],
      ),
    );
  }
}
