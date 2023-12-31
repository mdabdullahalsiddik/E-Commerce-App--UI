import 'dart:convert';

import 'package:ecommerce_ui/Model/all_model.dart';
import 'package:ecommerce_ui/Pages/buttom_bar_page.dart';
import 'package:ecommerce_ui/Static/all_colors.dart';
import 'package:ecommerce_ui/Widget/costom_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

// ignore: must_be_immutable
class ProductDitlsPage extends StatefulWidget {
  String id;
  String categoryTitle;
  ProductDitlsPage({
    super.key,
    required this.id,
    required this.categoryTitle,
  });

  @override
  State<ProductDitlsPage> createState() => _ProductDitlsPageState();
}

class _ProductDitlsPageState extends State<ProductDitlsPage> {
  int selectSize = 0;
  int selectColor = 0;
  int lines = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: costomAppbar(
          context: context,
          icon: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: FutureBuilder(
              future: FirebaseDatabase.instance
                  .ref("Product")
                  .child(widget.categoryTitle)
                  .child(widget.id.toLowerCase())
                  .get()
                  .then((value) => ProductModel.fromJson(
                      jsonDecode(jsonEncode(value.value as Map)))),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .2,
                        child: Image.network(
                          snapshot.data!.image.toString(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            snapshot.data!.title.toString(),
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "\$${snapshot.data!.price.toString()}",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: AllColors.primaryColor),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        snapshot.data!.about.toString(),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.black.withOpacity(.5),
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: lines,
                      ),
                      lines == 1
                          ? TextButton(
                              onPressed: () {
                                setState(() {
                                  lines = 3;
                                });
                              },
                              child: const Text("Show More"),
                            )
                          : TextButton(
                              onPressed: () {
                                setState(() {
                                  lines = 1;
                                });
                              },
                              child: const Text("Show Less"),
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Color",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .10,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    snapshot.data!.color!.first.toString() == ""
                                        ? 0
                                        : snapshot.data!.color!.length,
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    width: MediaQuery.of(context).size.height *
                                        .12,
                                    child: InkWell(
                                      onTap: () {
                                        setState(
                                          () {
                                            selectColor = index;
                                          },
                                        );
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          side: BorderSide(
                                            color: selectColor == index
                                                ? Colors.black
                                                : AllColors.primaryColor,
                                          ),
                                        ),
                                        color: selectColor == index
                                            ? AllColors.primaryColor
                                            : Colors.white,
                                        child: Center(
                                          child: Text(
                                            snapshot.data!.color![index]
                                                .toString(),
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Colors.black.withOpacity(.5),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Size",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .1,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    snapshot.data!.size!.first.toString() == ""
                                        ? 0
                                        : snapshot.data!.size!.length,
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    width:
                                        MediaQuery.of(context).size.height * .1,
                                    child: InkWell(
                                      onTap: () {
                                        setState(
                                          () {
                                            selectSize = index;
                                          },
                                        );
                                      },
                                      child: Card(
                                        shape: StadiumBorder(
                                          side: BorderSide(
                                            color: selectSize == index
                                                ? Colors.black
                                                : AllColors.primaryColor,
                                            width: .5,
                                          ),
                                        ),
                                        color: selectSize == index
                                            ? AllColors.primaryColor
                                            : Colors.white,
                                        child: Center(
                                          child: Text(
                                            snapshot.data!.size![index]
                                                .toString(),
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Colors.black.withOpacity(.5),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                } else if (snapshot.hasError) {}
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),
        ),
        bottomNavigationBar: FutureBuilder(
          future: FirebaseDatabase.instance
              .ref("Product")
              .child(widget.categoryTitle)
              .child(widget.id.toLowerCase())
              .get()
              .then((value) => ProductModel.fromJson(
                  jsonDecode(jsonEncode(value.value as Map)))),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    await EasyLoading.show(status: 'loading...');

                    await FirebaseDatabase.instance
                        .ref("OderCart")
                        .child(
                            FirebaseAuth.instance.currentUser!.uid.toString())
                        .child(
                            "${snapshot.data!.categoryID.toString()}_${snapshot.data!.id.toString()}")
                        .set(
                          OderCartProductModel(
                            size: snapshot.data!.size!.isEmpty
                                ? null
                                : snapshot.data!.size![selectSize].toString(),
                            color: snapshot.data!.color!.isEmpty
                                ? null
                                : snapshot.data!.color![selectColor].toString(),
                            title: snapshot.data!.title.toString(),
                            image: snapshot.data!.image.toString(),
                            price: snapshot.data!.price,
                            id: snapshot.data!.id.toString(),
                            quantity: 1,
                            categoryID: snapshot.data!.categoryID.toString(),
                            totalprice: snapshot.data!.price,
                          ).toJson(),
                        );
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const BottomNavigatorBarPage(),
                      ),
                    );
                    EasyLoading.showSuccess('Great Success!');
                    EasyLoading.dismiss();
                  },
                  child: const Text(
                    "Add to Cart",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.hasError.toString());
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
