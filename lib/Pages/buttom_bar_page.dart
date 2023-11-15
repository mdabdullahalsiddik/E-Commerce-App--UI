import 'package:ecommerce_ui/Pages/authentication/account_page.dart';
import 'package:ecommerce_ui/Pages/chat_page.dart';
import 'package:ecommerce_ui/Pages/favorit_page.dart';
import 'package:ecommerce_ui/Pages/home_page.dart';
import 'package:ecommerce_ui/Pages/item_cart_page.dart';
import 'package:ecommerce_ui/Static/all_colors.dart';
import 'package:flutter/material.dart';

class ButtomNavigatorBarPage extends StatefulWidget {
  const ButtomNavigatorBarPage({super.key});

  @override
  State<ButtomNavigatorBarPage> createState() => _ButtomNavigatorBarPageState();
}

class _ButtomNavigatorBarPageState extends State<ButtomNavigatorBarPage> {
  int selectIndex = 0;

  List<Widget> pages = [
    const HomePage(),
    const FavoritePage(),
    const ItemPage(),
    ChatPage(),
    const AccountPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: ""),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_sharp),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "",
          ),
        ],
      ),
    );
  }
}
