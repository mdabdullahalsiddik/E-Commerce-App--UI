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
  List<Map<String,dynamic>> itemQTY = [
    {
      "qty" : 1,
      "tp" : 50,
      "netTp" : 50,
    },
    {
      "qty" : 1,
      "tp" : 70,
      "netTp" : 70,
    },
    {
      "qty" : 1,
      "tp" : 60,
      "netTp" : 60,
    },
    {
      "qty" : 1,
      "tp" : 40,
      "netTp" : 40,
    },
    {
      "qty" : 1,
      "tp" : 100,
      "netTp" : 100,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: costomAppbar(context: context),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: itemQTY.length,
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
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6wuxE6zi1F1TiZ9y6BxufHRuqu3WXvJMWOg&usqp=CAU",
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Apple",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Card(
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if(itemQTY[index]['qty'] > 1){
                                      setState(() {
                                        itemQTY[index]['qty'] -= 1;
                                        itemQTY[index]['netTp']  = itemQTY[index]['qty'] * itemQTY[index]['tp'];
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
                                    if(itemQTY[index]['qty'] < 10){
                                      setState(() {
                                        itemQTY[index]['qty'] += 1;
                                        itemQTY[index]['netTp']  = itemQTY[index]['qty'] * itemQTY[index]['tp'];
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
                         "\$ ${itemQTY[index]['netTp']}",
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
    );
  }
}
