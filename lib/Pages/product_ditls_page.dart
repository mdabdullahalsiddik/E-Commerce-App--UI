import 'package:ecommerce_ui/Pages/item_page.dart';
import 'package:ecommerce_ui/Static/all_colors.dart';
import 'package:ecommerce_ui/Widget/costom_appbar.dart';
import 'package:flutter/material.dart';

class ProductDitlsPage extends StatefulWidget {
  Map product = {};
  ProductDitlsPage({
    super.key,
    required this.product,
  });

  @override
  State<ProductDitlsPage> createState() => _ProductDitlsPageState();
}

class _ProductDitlsPageState extends State<ProductDitlsPage> {
  double vlu = 0;
  int lines = 1;
  String selectedProductColor = '0';
  List productColorList = [
    Colors.grey.shade400,
    Colors.black,
    Colors.grey,
    Colors.deepOrange,
    Colors.yellow,
    Colors.green,
    Colors.teal,
    Colors.cyan,
    Colors.blue,
    Colors.red,
  ];
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .2,
                child: Image.network(
                  widget.product["image"].toString(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.product["title"].toString(),
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "\$${widget.product["price"].toString()}",
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AllColors.primaryColor),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              // Text(
              //   "Great, let's talk about sunglasses! Did you know that sunglasses not only protect your eyes from the sun's harmful rays, but they can also enhance your visual privacy and make you look fabulous? With so many styles and brands available, it can be overwhelming to choose the right pair. Consider your face shape, skin tone, and personal style when selecting a pair. And don't forget to opt for polarized lenses for added UV protection and reduced glare. Happy shopping! ",
              //   textAlign: TextAlign.start,
              //   style: TextStyle(
              //     color: Colors.black.withOpacity(.5),
              //   ),
              // ),
              Text(
                widget.product["about"].toString(),
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black.withOpacity(.5),
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: lines,
              ),
              lines == 1
                  ? TextButton(
                      onPressed: () {
                        setState(() {
                          lines = 3;
                        });
                      },
                      child: const Text("Show More"),
                    )
                  : TextButton(
                      onPressed: () {
                        setState(() {
                          lines = 1;
                        });
                      },
                      child: const Text("Show Less"),
                    ),

              const SizedBox(
                height: 10,
              ),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Color",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              // Column(
              //   children: [
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         IconButton(
              //           onPressed: () {},
              //           icon: const Icon(
              //             Icons.circle_outlined,
              //             color: Colors.black,
              //           ),
              //         ),
              //         IconButton(
              //           onPressed: () {},
              //           icon: const Icon(
              //             Icons.circle,
              //             color: Colors.black,
              //           ),
              //         ),
              //         IconButton(
              //           onPressed: () {},
              //           icon: const Icon(
              //             Icons.circle,
              //             color: Colors.green,
              //           ),
              //         ),
              //         IconButton(
              //           onPressed: () {},
              //           icon: const Icon(
              //             Icons.circle,
              //             color: Colors.blue,
              //           ),
              //         ),
              //         IconButton(
              //           onPressed: () {},
              //           icon: const Icon(
              //             Icons.circle,
              //             color: Colors.blueGrey,
              //           ),
              //         ),
              //       ],
              //     ),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         IconButton(
              //           onPressed: () {},
              //           icon: const Icon(
              //             Icons.circle,
              //             color: Colors.brown,
              //           ),
              //         ),
              //         IconButton(
              //           onPressed: () {},
              //           icon: const Icon(
              //             Icons.circle,
              //             color: Colors.red,
              //           ),
              //         ),
              //         IconButton(
              //           onPressed: () {},
              //           icon: const Icon(
              //             Icons.circle,
              //             color: Colors.cyan,
              //           ),
              //         ),
              //         IconButton(
              //           onPressed: () {},
              //           icon: const Icon(
              //             Icons.circle,
              //             color: Colors.deepPurple,
              //           ),
              //         ),
              //         IconButton(
              //           onPressed: () {},
              //           icon: const Icon(
              //             Icons.circle,
              //             color: Colors.grey,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              GridView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5),
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedProductColor = index.toString();
                        });
                      },
                      child: index.toString() == selectedProductColor
                          ? CircleAvatar(
                              child: Icon(
                                Icons.circle,
                                color: productColorList[index],
                              ),
                            )
                          : Icon(
                              Icons.circle,
                              color: productColorList[index],
                            ),
                    );
                  }),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Size",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Slider(
                value: vlu,
                activeColor: AllColors.yellowColor,
                min: 0,
                max: 100,
                label: vlu.toString(),
                onChanged: (value) {
                  setState(() {
                    vlu = value;
                  });
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ItemPage()));
          },
          child: const Text(
            "Add to Cart",
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
