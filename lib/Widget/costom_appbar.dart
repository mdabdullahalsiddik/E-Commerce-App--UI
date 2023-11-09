import 'package:flutter/material.dart';

PreferredSizeWidget? costomAppbar({
  void Function()? onPressed,
  var context,
  var icon,
}) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    centerTitle: true,
    leading: icon?? Text(""),
    title: const Text(
      "Lorem iqsum",
      style: TextStyle(
        color: Colors.black,
      ),
    ),
  );
}
