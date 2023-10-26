import 'package:ecommerce_ui/Static/all_colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CostomButton extends StatelessWidget {
  String text;
  void Function()? onTap;
  CostomButton({
    super.key,
    required this.text,
   required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 70,
        width: MediaQuery.of(context).size.width,
        child: Card(
          color: AllColors.primaryColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
