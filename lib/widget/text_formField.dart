import 'package:flutter/material.dart';

Widget customTextFormField({
  required String hintText,
  required TextEditingController textController,
  bool isReadOnly = false,
  Function? onTap,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 4,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: const Color.fromRGBO(0, 0, 85, 0.1),
    ),
    child: TextFormField(
      maxLines: 1,
      controller: textController,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color.fromRGBO(0, 0, 0, 0.8),
          fontWeight: FontWeight.w300,
          fontSize: 13,
        ),
        border: const UnderlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(0),
            ),
            borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
      ),
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      onTap: () {
        onTap!();
      },
      autofocus: true,
      readOnly: isReadOnly,
    ),
  );
}
