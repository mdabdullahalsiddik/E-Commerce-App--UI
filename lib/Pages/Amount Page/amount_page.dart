import 'package:ecommerce_ui/Widget/costom_appbar.dart';
import 'package:flutter/material.dart';

class AmountPage extends StatefulWidget {
  const AmountPage({super.key});

  @override
  State<AmountPage> createState() => _AmountPageState();
}

class _AmountPageState extends State<AmountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: costomAppbar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .1,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "\$50389",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .1,
            ),
            Row(
              children: [
                const Icon(
                  Icons.arrow_back_ios_rounded,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .78,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 62.54545593261719,
                          child: ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            scrollDirection: Axis.horizontal,
                            itemCount: 20,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                width: 64,
                                child: Container(
                                  margin: const EdgeInsets.all(5),
                                  color:
                                      const Color(0xFFD8D3D3).withOpacity(.5),
                                  child: const Center(child: Text("14 Age")),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .01,
            ),
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: 5,
              itemBuilder: (context, index) {
                return const ListTile(
                  leading: Text(
                    "Siddik",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
