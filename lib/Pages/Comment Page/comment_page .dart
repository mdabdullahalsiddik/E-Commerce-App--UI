import 'package:ecommerce_ui/Static/all_colors.dart';
import 'package:ecommerce_ui/Widget/costom_appbar.dart';
import 'package:flutter/material.dart';

class CommentPage extends StatelessWidget {
  const CommentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: costomAppbar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
              ),
              child: Card(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  child: Column(
                    children: [
                      const ListTile(
                        leading: Icon(
                          Icons.person,
                          color: AllColors.primaryColor,
                        ),
                        title: Text(
                          "Sid",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.star,
                              size: 15,
                              color: AllColors.yellowColor,
                            ),
                            Icon(
                              Icons.star,
                              size: 15,
                              color: AllColors.yellowColor,
                            ),
                            Icon(
                              Icons.star,
                              size: 15,
                              color: AllColors.yellowColor,
                            ),
                            Icon(
                              Icons.star,
                              size: 15,
                              color: AllColors.yellowColor,
                            ),
                            Icon(
                              Icons.star,
                              size: 15,
                              color: AllColors.yellowColor,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 15,
                          ),
                          child: Text(
                            "Great, let's talk about sunglasses! Did you know that sunglasses not only protect your eyes from the sun's harmful rays, but they can also enhance your visual privacy and make you look fabulous? With so many styles and brands available, it can be overwhelming to choose the right pair. Consider your face shape, skin tone, and personal style when selecting a pair. And don't forget to opt for polarized lenses for added UV protection and reduced glare. Happy shopping! ",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.black.withOpacity(.5),
                            ),
                          ),
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
