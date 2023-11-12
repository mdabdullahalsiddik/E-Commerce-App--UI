import 'package:ecommerce_ui/Funcition/all_funcition.dart';
import 'package:ecommerce_ui/Static/all_colors.dart';
import 'package:ecommerce_ui/Widget/costom_appbar.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
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
  int selectSize = 0;
  int selectColor = 0;
  int lines = 1;

 
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
        
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .08,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.product["color"].length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.height * .08,
                            child: InkWell(
                              onTap: () {
                                setState(
                                  () {
                                    selectColor = index;
                                  },
                                );
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  side: BorderSide(
                                    color: selectColor == index
                                        ? Colors.black
                                        : AllColors.primaryColor,
                                  ),
                                ),
                                color: selectColor == index
                                    ? AllColors.primaryColor
                                    : Colors.white,
                                child: Center(
                                  child: Text(
                                    widget.product["color"][index].toString(),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(.5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .1,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.product["size"].length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.height * .1,
                            child: InkWell(
                              onTap: () {
                                setState(
                                  () {
                                    selectSize = index;
                                  },
                                );
                              },
                              child: Card(
                                shape: StadiumBorder(
                                  side: BorderSide(
                                    color: selectSize == index
                                        ? Colors.black
                                        : AllColors.primaryColor,
                                    width: .5,
                                  ),
                                ),
                                color: selectSize == index
                                    ? AllColors.primaryColor
                                    : Colors.white,
                                child: Center(
                                  child: Text(
                                    widget.product["size"][index].toString(),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(.5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
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
            setState(() {
              allProduct.add(widget.product);
            });
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
