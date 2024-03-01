import 'package:flutter/material.dart';

Widget customBtn({
  required Function onTap,
  required String text,
  Color? color,
}) {
  return InkWell(
    onTap: () {
      onTap();
    },
    child: Container(
      padding: const EdgeInsets.symmetric(
        vertical: 14,
        horizontal: 30,
      ),
      decoration: BoxDecoration(
          color: color ?? const Color.fromRGBO(0, 202, 93, 1),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
