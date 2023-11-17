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
  int itemNumber = 1;
  int money = 50;
  int itemMoney = 50;
  String selectItem = '';

  List<Map<String, dynamic>> itemQTY = [
    {
      "qty": 1,
      "tp": 50,
      "netTp": 50,
    },
    {
      "qty": 1,
      "tp": 70,
      "netTp": 70,
    },
    {
      "qty": 1,
      "tp": 60,
      "netTp": 60,
    },
    {
      "qty": 1,
      "tp": 40,
      "netTp": 40,
    },
    {
      "qty": 1,
      "tp": 100,
      "netTp": 100,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: costomAppbar(context: context,
      title: Text("Cart", style: TextStyle(color: Colors.black,),)
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: allProduct.length,
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
                          allProduct[index]["image"],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            allProduct[index]["title"].toString(),
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
                                    if (itemQTY[index]['qty'] < 10) {
                                      setState(() {
                                        itemQTY[index]['qty'] -= 1;
                                        itemQTY[index]['netTp'] = itemQTY[index]
                                                ['qty'] *
                                            itemQTY[index]['tp'];
                                      });
                                    }
                                  },
                                  icon: const Icon(Icons.remove),
                                ),
                                Text(
                                  itemQTY[index]['qty'].toString(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (itemQTY[index]['qty'] < 10) {
                                      setState(() {
                                        itemQTY[index]['qty'] += 1;
                                        itemQTY[index]['netTp'] = itemQTY[index]
                                                ['qty'] *
                                            itemQTY[index]['tp'];
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
                            // Text(
                            //   allProduct[index]["size"].toString(),
                            //   style: const TextStyle(
                            //     fontWeight: FontWeight.bold,
                            //     color: AllColors.primaryColor,
                            //   ),
                            // ),
                            // Text(
                            //   allProduct[index]["color"].toString(),
                            //   style: const TextStyle(
                            //     fontWeight: FontWeight.bold,
                            //     color: AllColors.primaryColor,
                            //   ),
                            // ),
                            Text(
                              "\$ ${allProduct[index]["price"]}",
                              style: const TextStyle(
                                fontSize: 30,
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
      bottomNavigationBar: allProduct.isEmpty
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
                    allProduct.clear();
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
