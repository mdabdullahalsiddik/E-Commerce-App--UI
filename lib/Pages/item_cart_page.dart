import 'package:ecommerce_ui/Funcition/all_funcition.dart';
import 'package:ecommerce_ui/Pages/buttom_bar_page.dart';
import 'package:ecommerce_ui/Static/all_colors.dart';
import 'package:ecommerce_ui/Widget/costom_appbar.dart';
import 'package:flutter/material.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({super.key});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: costomAppbar(
          context: context,
          title: const Text(
            "Cart",
            style: TextStyle(
              color: Colors.black,
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: cartItemList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
              ),
              child: Card(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: Image.network(
                          cartItemList[index].image.toString(),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cartItemList[index].title.toString(),
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Card(
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if (cartItemList[index].quantity > 1) {
                                      setState(() {
                                        cartItemList[index].quantity -= 1;
                                        cartItemList[index].price =
                                            cartItemList[index].quantity *
                                                cartItemList[index].totalPrice;
                                      });
                                    }
                                  },
                                  icon: const Icon(Icons.remove),
                                ),
                                Text(
                                  cartItemList[index].quantity.toString(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (cartItemList[index].quantity < 10) {
                                      setState(() {
                                        cartItemList[index].quantity += 1;

                                        cartItemList[index].price =
                                            cartItemList[index].quantity *
                                                cartItemList[index].totalPrice;
                                      });
                                    }
                                  },
                                  icon: const Icon(Icons.add),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              cartItemList[index].size == null
                                  ? ''
                                  : "Size: ${cartItemList[index].size.toString()}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AllColors.primaryColor,
                              ),
                            ),
                            Text(
                              cartItemList[index].color == null
                                  ? ''
                                  : "Color: ${cartItemList[index].color.toString()}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AllColors.primaryColor,
                              ),
                            ),
                            Text(
                              "\$ ${cartItemList[index].price.toString()}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AllColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: cartItemList.isEmpty
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
                horizontal: 20,
                vertical: 10,
              ),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    cartItemList.clear();
                  });
                },
                child: const Text(
                  "Buy Now",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
    );
  }
}
