import 'dart:io';

import 'package:ecommerce_ui/Data/data_model.dart';
import 'package:ecommerce_ui/Funcition/firebase_funcition.dart';
import 'package:ecommerce_ui/Pages/authentication/SinginPage.dart';
import 'package:ecommerce_ui/Pages/product_list.dart';
import 'package:ecommerce_ui/Static/all_colors.dart';
import 'package:ecommerce_ui/Widget/costom_textfromfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List searchList = [];
  List finalSearchList = [];
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    FirebaseGetData().categoryGetData().then((value) {
      print(value.length);
      setState(() {
        searchList = finalSearchList;
        for (var element in value) {
          finalSearchList.add(element);
        }
      });
    });
    // setState(() {
    //   searchList = finalSearchList;
    //   for (var element in productModel) {
    //     finalSearchList.add(element);
    //   }
    // });

    super.initState();
  }

  void searchData(String value) {
    setState(() {
      searchList = finalSearchList
          .where(
            (element) => element["title"].toString().toLowerCase().contains(
                  value.toLowerCase(),
                ),
          )
          .toList();
    });
    print("***********${finalSearchList.length}********");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.white,
          drawer: Drawer(
              child: ListView(
            children: [
              const UserAccountsDrawerHeader(
                accountName: Text("data"),
                accountEmail: Text("data"),
              ),
              InkWell(
                onTap: () {
                  showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Confirmation"),
                        content: const Text("Are you sura exit."),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                  style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                      AllColors.primaryColor,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context, false);
                                  },
                                  child: const Text(
                                    "No",
                                    style: TextStyle(color: Colors.black),
                                  )),
                              ElevatedButton(
                                  style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                      AllColors.primaryColor,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      FirebaseAuth.instance.signOut();
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const SingInPage(),
                                        ),
                                        (route) => false,
                                      );
                                    });
                                  },
                                  child: const Text("Yes",
                                      style: TextStyle(color: Colors.black))),
                            ],
                          )
                        ],
                      );
                    },
                  );
                },
                child: ListTile(
                  leading: IconButton(
                    onPressed: () {
                      // setState(() {
                      //   FirebaseAuth.instance.signOut();
                      //   Navigator.pushAndRemoveUntil(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (_) => const SingInPage(),
                      //     ),
                      //     (route) => false,
                      //   );
                      // });
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                  ),
                  title: const Text(
                    "Log Out",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          )),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: Column(
              children: [
                CostomTextField(
                  controller: searchController,
                  onChanged: (p0) {
                    setState(() {
                      searchData(p0);
                    });
                  },
                  hintText: "Search",
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  suffixIcon: searchController.text.isEmpty
                      ? null
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              searchList.clear();
                              searchController.clear();
                              // for (var element in finalSearchList) {
                              //   searchList.add(element);
                              // }
                              searchList = finalSearchList;
                            });
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                        ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                searchList.isEmpty
                    ? const Center(child: Text("Not Found"))
                    : Expanded(
                        child: GridView.builder(
                          itemCount: searchList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 1,
                            childAspectRatio: .9,
                          ),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductListPage(
                                      //index: searchList[index],
                                      title: searchList[index].title.toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                color: AllColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                        searchList[index].image.toString(),
                                        // snapshot.data![index].image
                                        //     .toString(),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .02,
                                    ),
                                    Text(
                                      //   searchList[index]!["category_title"]
                                      // snapshot.data![index].title
                                      //     .toString(),
                                      searchList[index].title.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ],
            ),
          ),
        ),
        onWillPop: () async {
          return (await showDialog(
            barrierDismissible: true,
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Confirmation"),
                content: const Text("Are you sura exit."),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              AllColors.primaryColor,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: const Text(
                            "No",
                            style: TextStyle(color: Colors.black),
                          )),
                      ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              AllColors.primaryColor,
                            ),
                          ),
                          onPressed: () {
                            exit(0);
                          },
                          child: const Text("Yes",
                              style: TextStyle(color: Colors.black))),
                    ],
                  )
                ],
              );
            },
          ));
        });
  }
}
