import 'package:ecommerce_ui/Funcition/firebase_funcition.dart';
import 'package:ecommerce_ui/Pages/authentication/account_page.dart';
import 'package:ecommerce_ui/Pages/favorit_page.dart';
import 'package:ecommerce_ui/Pages/home_page.dart';
import 'package:ecommerce_ui/Pages/item_cart_page.dart';
import 'package:ecommerce_ui/Static/all_colors.dart';
import 'package:flutter/material.dart';

class BottomNavigatorBarPage extends StatefulWidget {
  const BottomNavigatorBarPage({
    super.key,
  });

  @override
  State<BottomNavigatorBarPage> createState() => _BottomNavigatorBarPageState();
}

class _BottomNavigatorBarPageState extends State<BottomNavigatorBarPage> {
  int selectIndex = 0;

  List<Widget> pages = [
    const HomePage(),
    const FavoritePage(),
    const CartItemPage(),
    const AccountPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[selectIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 0,
        unselectedFontSize: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: selectIndex,
        onTap: (index) {
          setState(
            () {
              selectIndex = index;
            },
          );
        },
        selectedIconTheme: const IconThemeData(
          color: AllColors.primaryColor,
        ),
        unselectedIconTheme: IconThemeData(
          color: Colors.black.withOpacity(0.5),
        ),
        items: [
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: ""),
          BottomNavigationBarItem(
            icon: StreamBuilder(
              stream: FirebaseGetData().favoriteGetData().asStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Badge(
                    label: Text(
                      snapshot.data!.length.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Icon(Icons.favorite_border),
                  );
                }
                return const Badge(
                  label: Text(
                    "0",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: Icon(Icons.shopping_cart_outlined),
                );
              },
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: StreamBuilder(
              stream: FirebaseGetData().productCartListGetData().asStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Badge(
                    label: Text(
                      snapshot.data!.length.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Icon(Icons.shopping_cart_outlined),
                  );
                }
                return const Badge(
                  label: Text(
                    "0",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: Icon(Icons.shopping_cart_outlined),
                );
              },
            ),
            label: "",
          ),
         
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "",
          ),
        ],
      ),
    );
  }
}
