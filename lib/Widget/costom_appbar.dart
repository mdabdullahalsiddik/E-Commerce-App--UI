import 'package:flutter/material.dart';

PreferredSizeWidget? costomAppbar({
  void Function()? onPressed,
  var context,
  var icon,
Widget? title
}) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    centerTitle: true,
    leading: icon?? const Text(""),
    title: title ??const Text(
      "Lorem ipsum",
      style: TextStyle(
        color: Colors.black,
      ),
    ),
  );
}
