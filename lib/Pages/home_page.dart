import 'package:ecommerce_ui/Data/data_model.dart';
import 'package:ecommerce_ui/Pages/authentication/SinginPage.dart';
import 'package:ecommerce_ui/Pages/product_list.dart';
import 'package:ecommerce_ui/Static/all_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
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
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: GridView.builder(
          itemCount: productModel.length,
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
                    builder: (context) => ProductListPage(
                        productList: productModel[index]!['data']),
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
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * .1,
                    //   //width: MediaQuery.of(context).size.width * .4,
                    //   child: Image.network(
                    //     productModel[index]!["image"].toString(),
                    //     fit: BoxFit.cover,
                    //   ),
                    //),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        productModel[index]!["image"].toString(),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Text(
                      productModel[index]!["category_title"].toString(),
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
