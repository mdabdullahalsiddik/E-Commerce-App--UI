// ignore: unused_import
import 'package:ecommerce_ui/Data/data_model.dart';
import 'package:ecommerce_ui/Funcition/all_funcition.dart';
import 'package:ecommerce_ui/Pages/product_ditls_page.dart';
import 'package:ecommerce_ui/Static/all_colors.dart';
import 'package:ecommerce_ui/Widget/costom_appbar.dart';
import 'package:ecommerce_ui/Widget/costom_textfromfield.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProductListPage extends StatefulWidget {
  Map productList = {};
  ProductListPage({
    super.key,
    required this.productList,
  });

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List data = [];
  @override
  void initState() {
    setState(() {
      data = widget.productList.values.toList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: costomAppbar(
        context: context,
        icon: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: Column(
          children: [
            CostomTextField(
              hintText: "Search",
              prefixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            Expanded(
              child: GridView.builder(
                itemCount: data.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 1,
                  childAspectRatio: .7,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDitlsPage(
                            product: data[index],
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
                                  if (favoriteList.contains(data[index])) {
                                    setState(() {
                                      favoriteList.remove(
                                        data[index],
                                      );
                                    });
                                  } else {
                                    setState(() {
                                      favoriteList.add(
                                        data[index],
                                      );
                                    });
                                  }
                                },
                                icon: Icon(
                                  Icons.favorite,
                                  size: 15,
                                  color:
                                      favoriteList.contains(data[index]) == true
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
                              data[index]!["image"].toString(),
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .02,
                          ),
                          Text(
                            data[index]!["title"].toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "\$ ${data[index]!["price"].toString()}",
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
          ],
        ),
      ),
    );
  }
}
