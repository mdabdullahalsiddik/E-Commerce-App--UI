// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore: unused_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_ui/Funcition/all_funcition.dart';
import 'package:ecommerce_ui/Funcition/firebase_funcition.dart';
import 'package:ecommerce_ui/Pages/buttom_bar_page.dart';
import 'package:ecommerce_ui/Pages/product_ditls_page.dart';
import 'package:ecommerce_ui/Static/all_colors.dart';
import 'package:ecommerce_ui/Widget/costom_appbar.dart';

// ignore: must_be_immutable
class ProductListPage extends StatefulWidget {
  int? index;

  String title;
  String id;
  ProductListPage({
    Key? key,
    this.index,
    required this.title,
    required this.id,
  }) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List data = [];
  List finalSearchList = [];
  // ignore: prefer_typing_uninitialized_variables
  var vlu;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    FirebaseGetData().productGetData(widget.title).then((value) {
      vlu = value;
      setState(() {
        data = finalSearchList;
        for (var element in value) {
          finalSearchList.add(element);
        }
      });
    });
    super.initState();
  }

  void searchData(String value) {
    setState(() {
      data = finalSearchList
          .where(
            (element) => element["title"].toString().toLowerCase().contains(
                  value.toLowerCase(),
                ),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: costomAppbar(
          context: context,
          title: Text(
            widget.title.toString(),
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          icon: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                       BottomNavigatorBarPage(),
                ),
              );
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
              CupertinoSearchTextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    searchData(value);
                  });
                },
              ),
             
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              data.isEmpty
                  ? const Center(child: Text("Not Found"))
                  : Expanded(
                      child: GridView.builder(
                        itemCount: data.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
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
                                    id: data[index]!.id.toString(),
                                    categoryTitle: widget.title.toString(),
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
                                          if (favoriteList
                                              .contains(data[index])) {
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
                                          color: favoriteList
                                                      .contains(data[index]) ==
                                                  true
                                              ? Colors.red
                                              : Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height * .1,
                                    width:
                                        MediaQuery.of(context).size.width * .4,
                                    child: Image.network(
                                      data[index]!.image.toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        .02,
                                  ),
                                  Text(
                                    data[index]!.title.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    "\$ ${data[index]!.price.toString()}",
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
      ),
      onWillPop: () async {
        return await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>  BottomNavigatorBarPage(),
          ),
        );
      },
    );
  }
}
