import 'package:ecommerce_ui/Funcition/all_funcition.dart';
import 'package:ecommerce_ui/Pages/buttom_bar_page.dart';
import 'package:ecommerce_ui/Pages/product_ditls_page.dart';
import 'package:ecommerce_ui/Static/all_colors.dart';
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
      body:favoriteList.isEmpty
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
          : Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: GridView.builder(
          itemCount: favoriteList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                      product: favoriteList[index],
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
                            setState(() {
                              favoriteList.remove(
                                favoriteList[index]!,
                              );
                            });
                          },
                          icon: Icon(
                            Icons.favorite,
                            size: 15,
                            color:
                                favoriteList.contains(favoriteList[index]!) ==
                                        true
                                    ? Colors.red
                                    : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .1,
                      width: MediaQuery.of(context).size.width * .4,
                      child: Image.network(
                        favoriteList[index]!["image"].toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Text(
                      favoriteList[index]!["title"].toString(),
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
    );
  }
}
