import 'package:ecommerce_ui/Pages/buttom_bar_page.dart';
import 'package:ecommerce_ui/Pages/welcome_page.dart';
import 'package:ecommerce_ui/Static/all_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future splash() async {
    Future.delayed(const Duration(seconds: 5)).then(
      (value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => FirebaseAuth.instance.currentUser == null
                  ? const WelcomePage()
                  : const BottomNavigatorBarPage(),
            ),
            (route) => false);
      },
    );
  }

  @override
  void initState() {
    splash();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllColors.primaryColor,
      body: Center(
        child: Image.asset(
          "assets/images/logo.png",
          height: 100,
          width: 100,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
