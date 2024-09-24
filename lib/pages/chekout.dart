// ignore_for_file: unused_import, prefer_const_constructors

import 'package:e_comarance_app/model/item.dart';
import 'package:e_comarance_app/provider/cart.dart';
import 'package:e_comarance_app/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: screen,
        appBar: AppBar(
          backgroundColor: appbar,
          title: Text(style: TextStyle(fontFamily: "myfont",fontSize: 22,fontWeight: FontWeight.w600),"Cart"),
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
                            style: TextStyle(fontFamily: "myfont",fontWeight: FontWeight.w600,),
                          );
                        })),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: BTNblue, shape: BoxShape.circle)),
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.add_shopping_cart)),
                  ],
                ),
                Consumer<Cart>(builder: ((context, classInstancee, child) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Text(style: TextStyle(fontFamily: "myfont",fontSize: 18,fontWeight: FontWeight.w600),"\$ ${classInstancee.total}"),
                  );
                }))
              ],
            )
          ],
        ),
        body: Consumer<Cart>(builder: ((context, cart, child) {
          return Stack(
            children: [
              Image.asset("assets/img/Ecommerce checkout laptop-amico.png"),
              Column(
                children: [
                  SingleChildScrollView(
                    child: SizedBox(
                      height: 500,
                      child: ListView.builder(
                          padding: const EdgeInsets.all(8),
                          itemCount: cart.selectitems.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: ListTile(
                                  subtitle: Text(
                                      " \$${cart.selectitems[index].price} - ${cart.selectitems[index].location}"),
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        AssetImage(cart.selectitems[index].imglink),
                                  ),
                                  title: Text("prodect ${index + 1}"),
                                  trailing: Consumer<Cart>(
                                      builder: ((context, cart, child) {
                                    return IconButton(
                                        onPressed: () {
                                          setState(() {
                                            cart.delete(cart.selectitems[index]);
                                          });
                                        },
                                        icon: Icon(Icons.remove));
                                  }))),
                            );
                          }),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(BTNblue),
                      padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                    ),
                    child: Text(
                      "Pay",
                      style: TextStyle(fontFamily: "myfont",fontWeight: FontWeight.w600,fontSize: 19),
                    ),
                  ),
                  SizedBox(
                    height: 33,
                  ),
                  Consumer<Cart>(builder: ((context, classInstancee, child) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Text(
                        "Total Is : \$${classInstancee.total}",
                        style: TextStyle(fontFamily: "myfont",fontWeight: FontWeight.w600,fontSize: 28),
                      ),
                    );
                  }))
                ],
              ),
            ],
          );
        })));
  }
}
