import 'package:ecommerce_ui/Funcition/all_funcition.dart';
import 'package:ecommerce_ui/Funcition/firebase_funcition.dart';
import 'package:ecommerce_ui/Pages/buttom_bar_page.dart';
import 'package:ecommerce_ui/Pages/product_ditls_page.dart';
import 'package:ecommerce_ui/Pages/product_list.dart';
import 'package:ecommerce_ui/Static/all_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Favorite",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: favoriteList.isEmpty
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
            : StreamBuilder(
                stream: FirebaseGetData().favoriteGetData().asStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: GridView.builder(
                        itemCount: data.length,
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
                                  builder: (context) => ProductDitlsPage(
                                    id: data[index].id.toString(),
                                    categoryTitle:
                                        data[index].categoryTitle.toString(),
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(
                                  color: AllColors.primaryColor,
                                  width: 2.0,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          setState(() async {
                                            await FirebaseDatabase.instance
                                                .ref("Favorite")
                                                .child(FirebaseAuth
                                                    .instance.currentUser!.uid
                                                    .toString())
                                                .child(
                                                    "${data[index].categoryID.toString()}_${data[index].id.toString()}")
                                                .remove();
                                          });
                                        },
                                        icon: const Icon(Icons.favorite,
                                            size: 15, color: Colors.red),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height * .1,
                                    width:
                                        MediaQuery.of(context).size.width * .4,
                                    child: Image.network(
                                      data[index].image.toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        .02,
                                  ),
                                  Text(
                                    data[index].title.toString(),
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
                    );
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("Data Not Found"));
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ));
  }
}
