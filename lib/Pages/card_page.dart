import 'package:ecommerce_ui/Static/all_colors.dart';
import 'package:ecommerce_ui/Widget/costom_appbar.dart';
import 'package:ecommerce_ui/Widget/costom_button.dart';
import 'package:flutter/material.dart';

class CardPage extends StatefulWidget {
  Map product = {};
   CardPage({super.key, required this.product,});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: costomAppbar(context: context, icon: IconButton(
      onPressed: 
          () {
            Navigator.pop(context);
          },
      icon: const Icon(
        Icons.arrow_back_outlined,
        color: Colors.black,
      ),
    )),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .25,
            child: Card(
              color: AllColors.yellowColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Text No ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        Card(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "CARD",
                              style: TextStyle(
                                color: AllColors.primaryColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Text(
                      "XXXX XXXX XXXX XXXX",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "Dinajpur",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .05,
          ),
          const Text(
            "Card",
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .05,
          ),
          Text(
            "Card Number",
            style: TextStyle(
              color: Colors.black.withOpacity(.7),
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .02,
          ),
          Text(
            "XXXX XXXX XXXX XXXX",
            style: TextStyle(
              color: Colors.black.withOpacity(.7),
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DropdownButton<String>(
                hint: const Text("Data"),
                items: <String>['2020', '2021', '2023', '2024']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
              ),
              DropdownButton<String>(
                hint: const Text("Data"),
                items: <String>['2020', '2021', '2023', '2024']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .05,
          ),
          CostomButton(onTap: () {}, text: "OK")
        ]),
      ),
    );
  }
}
