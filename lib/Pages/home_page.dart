import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_ui/Funcition/all_funcition.dart';
import 'package:ecommerce_ui/Funcition/firebase_funcition.dart';
import 'package:ecommerce_ui/Model/user_modul.dart';
import 'package:ecommerce_ui/Pages/authentication/SinginPage.dart';
import 'package:ecommerce_ui/Pages/product_list.dart';
import 'package:ecommerce_ui/Static/all_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List searchList = [];
  List finalSearchList = [];
  bool loding = false;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    FirebaseGetData().favoriteGetData().then((value) {
      setState(() {
        for (var element in value) {
          favoriteList.add(element);
        }
        print("***********************$favoriteList");
      });
    });
    FirebaseGetData().categoryGetData().then((value) {
      setState(() {
        for (var element in value) {
          finalSearchList.add(element);
        }
        searchList = finalSearchList;
      });
    });

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
      loding = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.white,
          drawer: FutureBuilder(
              future: FirebaseDatabase.instance
                  .ref("User")
                  .child(FirebaseAuth.instance.currentUser!.email
                      .toString()
                      .replaceAll(".", ""))
                  .get()
                  .then(
                    (value) => UserInfoModel.fromJson(
                      jsonDecode(
                        jsonEncode(value.value as Map),
                      ),
                    ),
                  ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Drawer(
                    child: ListView(
                      children: [
                        UserAccountsDrawerHeader(
                          decoration: const BoxDecoration(
                            color: AllColors.primaryColor,
                          ),
                          accountName: Text(
                            snapshot.data!.name.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                            ),
                          ),
                          accountEmail: Text(
                            snapshot.data!.mail.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              barrierDismissible: true,
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  title: const Text(
                                    "Log Out?",
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
                                        onPressed: () {
                                          setState(() async {
                                            await EasyLoading.show(
                                                status: 'loading...');
                                            // ignore: use_build_context_synchronously
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    const SingInPage(),
                                              ),
                                              (route) => false,
                                            );
                                            FirebaseAuth.instance.signOut();
                                            EasyLoading.showSuccess(
                                                'Great Success!');
                                            EasyLoading.dismiss();
                                          });
                                        },
                                        child: const Text("Yes")),
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
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.hashCode.toString());
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
          ),
          body: loding
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: Column(
                    children: [
                      CupertinoSearchTextField(
                        controller: searchController,
                        onChanged: (value) {
                          setState(() {
                            searchData(value);
                          });
                        },
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
                                            title: searchList[index]
                                                .title
                                                .toString(),
                                            id: searchList[index].id.toString(),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      color: AllColors.primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 50,
                                            backgroundImage: NetworkImage(
                                              searchList[index]
                                                  .image
                                                  .toString(),
                                            ),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .02,
                                          ),
                                          Text(
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
