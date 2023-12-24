import 'dart:convert';

import 'package:ecommerce_ui/Model/user_modul.dart';
import 'package:ecommerce_ui/Static/all_colors.dart';
import 'package:ecommerce_ui/Widget/costom_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: costomAppbar(context: context),
      body: StreamBuilder(
        stream: FirebaseDatabase.instance
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
            )
            .asStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 70,
                          backgroundImage: NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLs9tGlth8wVAXub3lEy03EDamsQF4qC1lOg&usqp=CAU",
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          snapshot.data!.name.toString(),
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 18,
                              color: AllColors.primaryColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Lalbug",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(.5),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.email,
                        color: AllColors.primaryColor,
                      ),
                      title: Text(
                        snapshot.data!.mail.toString(),
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.call,
                        color: AllColors.primaryColor,
                      ),
                      title: Text(
                        snapshot.data!.phone.toString(),
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
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
