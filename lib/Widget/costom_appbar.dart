import 'package:flutter/material.dart';

PreferredSizeWidget? costomAppbar({
  void Function()? onPressed,
}) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    centerTitle: true,
    leading: IconButton(
      onPressed: onPressed,
      icon: const Icon(
        Icons.arrow_back_outlined,
      ),
    ),
    title: const Text(
      "Lorem iqsum",
      style: TextStyle(
        color: Colors.black,
      ),
    ),
  );
}
