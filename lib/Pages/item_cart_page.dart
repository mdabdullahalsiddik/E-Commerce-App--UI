// ignore_for_file: avoid_print

import 'package:ecommerce_ui/Funcition/firebase_funcition.dart';
import 'package:ecommerce_ui/Model/all_model.dart';
import 'package:ecommerce_ui/Pages/buttom_bar_page.dart';
import 'package:ecommerce_ui/Static/all_colors.dart';
import 'package:ecommerce_ui/Widget/costom_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CartItemPage extends StatefulWidget {
  const CartItemPage({super.key});

  @override
  State<CartItemPage> createState() => _CartItemPageState();
}

class _CartItemPageState extends State<CartItemPage> {
  // ignore: non_constant_identifier_names
  List t_price = [];
  int i = 0;
  double tP = 0;

  void tPrice() async {
    await FirebaseGetData().productCartListGetData().then((value) {
      for (int i = 0; i < value.length; i++) {
        tP += value[i].price;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    tPrice();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: StreamBuilder(
        stream: FirebaseGetData().productCartListGetData().asStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: costomAppbar(
                  context: context,
                  title: const Text(
                    "Cart",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  )),
              body: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      child: InkWell(
                        onLongPress: () {
                          setState(() {});
                          showDialog(
                            context: context,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                title: const Text(
                                  "Delete Product?",
                                  style: TextStyle(color: Colors.red),
                                ),
                                content: const Text("Are you sure?"),
                                actions: [
                                  CupertinoDialogAction(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("No"),
                                  ),
                                  CupertinoDialogAction(
                                      onPressed: () async {
                                        try {
                                          await EasyLoading.show(
                                              status: 'loading...');
                                          setState(() {
                                            FirebaseDatabase.instance
                                                .ref("OderCart")
                                                .child(FirebaseAuth
                                                    .instance.currentUser!.uid
                                                    .toString())
                                                .child(
                                                    "${snapshot.data![index].categoryID.toString()}_${snapshot.data![index].id.toString()}")
                                                .remove();

                                            Navigator.pop(context);
                                            tP = 0;
                                            tPrice();
                                          });
                                          EasyLoading.showSuccess(
                                              'Great Success!');
                                          EasyLoading.dismiss();
                                        } catch (e) {
                                          print(e);
                                        }
                                      },
                                      child: const Text("Yes")),
                                ],
                              );
                            },
                          );
                        },
                        child: Card(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height / 5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .3,
                                    child: Image.network(
                                      snapshot.data![index].image.toString(),
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data![index].title.toString(),
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Card(
                                      child: Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if (int.parse(snapshot
                                                        .data![index].quantity
                                                        .toString()) >
                                                    1) {
                                                  FirebaseDatabase.instance
                                                      .ref("OderCart")
                                                      .child(FirebaseAuth
                                                          .instance
                                                          .currentUser!
                                                          .uid
                                                          .toString())
                                                      .child(
                                                          "${snapshot.data![index].categoryID.toString()}_${snapshot.data![index].id.toString()}")
                                                      .update({
                                                    "quantity": int.parse(
                                                            snapshot
                                                                .data![index]
                                                                .quantity
                                                                .toString()) -
                                                        1,
                                                  });
                                                  var q = int.parse(snapshot
                                                          .data![index].quantity
                                                          .toString()) -
                                                      1;
                                                  FirebaseDatabase.instance
                                                      .ref("OderCart")
                                                      .child(FirebaseAuth
                                                          .instance
                                                          .currentUser!
                                                          .uid
                                                          .toString())
                                                      .child(
                                                          "${snapshot.data![index].categoryID.toString()}_${snapshot.data![index].id.toString()}")
                                                      .update({
                                                    "price": snapshot
                                                            .data![index]
                                                            .totalprice *
                                                        q,
                                                  });
                                                }
                                                tP = 0;
                                                tPrice();
                                              });
                                            },
                                            icon: const Icon(Icons.remove),
                                          ),
                                          Text(
                                            snapshot.data![index].quantity
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if (int.parse(snapshot
                                                        .data![index].quantity
                                                        .toString()) <
                                                    10) {
                                                  FirebaseDatabase.instance
                                                      .ref("OderCart")
                                                      .child(FirebaseAuth
                                                          .instance
                                                          .currentUser!
                                                          .uid
                                                          .toString())
                                                      .child(
                                                          "${snapshot.data![index].categoryID.toString()}_${snapshot.data![index].id.toString()}")
                                                      .update({
                                                    "quantity": int.parse(
                                                            snapshot
                                                                .data![index]
                                                                .quantity
                                                                .toString()) +
                                                        1,
                                                  });
                                                  var q = int.parse(snapshot
                                                          .data![index].quantity
                                                          .toString()) +
                                                      1;

                                                  FirebaseDatabase.instance
                                                      .ref("OderCart")
                                                      .child(FirebaseAuth
                                                          .instance
                                                          .currentUser!
                                                          .uid
                                                          .toString())
                                                      .child(
                                                          "${snapshot.data![index].categoryID.toString()}_${snapshot.data![index].id.toString()}")
                                                      .update({
                                                    "price": snapshot
                                                            .data![index]
                                                            .totalprice *
                                                        q,
                                                  });
                                                }
                                                tP = 0;
                                                tPrice();
                                              });
                                            },
                                            icon: const Icon(Icons.add),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        snapshot.data![index].size == null
                                            ? ''
                                            : "Size: ${snapshot.data![index].size.toString()}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AllColors.primaryColor,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data![index].color == null
                                            ? ''
                                            : "Color: ${snapshot.data![index].color.toString()}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AllColors.primaryColor,
                                        ),
                                      ),
                                      Text(
                                        "\$ ${snapshot.data![index].price.toString()}",
                                        style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              bottomNavigationBar: snapshot.data!.isEmpty
                  ? Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const BottomNavigatorBarPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Add Item",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Total Price :",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "$tP",
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                await EasyLoading.show(status: 'loading...');
                                setState(() async {
                                  var data = snapshot.data!;
                                  int i = 0;
                                  for (int index = 0;
                                      index <= data.length;
                                      index++) {
                                    i = index;

                                    await FirebaseDatabase.instance
                                        .ref("Oder")
                                        .child(FirebaseAuth
                                            .instance.currentUser!.email
                                            .toString()
                                            .replaceAll(".", ""))
                                        .child(
                                            "${snapshot.data![i].categoryID.toString()}_${snapshot.data![i].id.toString()}")
                                        .set(
                                          OderProductModel(
                                            size: snapshot.data![i].size!,
                                            color: snapshot.data![i].color
                                                .toString(),
                                            title: snapshot.data![i].title
                                                .toString(),
                                            image: snapshot.data![i].image
                                                .toString(),
                                            price: snapshot.data![i].price,
                                            id: snapshot.data![i].id.toString(),
                                            quantity:
                                                snapshot.data![i].quantity,
                                            categoryID: snapshot
                                                .data![i].categoryID
                                                .toString(),
                                            mail: FirebaseAuth
                                                .instance.currentUser!.email
                                                .toString(),
                                            totalprice: tP,
                                          ).toJson(),
                                        );
                                    setState(() {
                                      FirebaseDatabase.instance
                                          .ref("OderCart")
                                          .child(FirebaseAuth
                                              .instance.currentUser!.uid
                                              .toString())
                                          .child(
                                              "${snapshot.data![i].categoryID.toString()}_${snapshot.data![i].id.toString()}")
                                          .remove();
                                    });

                                    EasyLoading.showSuccess('Great Success!');
                                    EasyLoading.dismiss();
                                  }
                                });

                                // ignore: use_build_context_synchronously
                              },
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: const Center(
                                  child: Text(
                                    "Buy Now ",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
