// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';

InputDecoration formDecoration(String labelText, IconData iconData) {
  return InputDecoration(
    errorStyle: const TextStyle(fontSize: 10),
    prefixIcon: Icon(
      iconData,
      color: Colors.indigo,
    ),
    errorMaxLines: 3,
    labelText: labelText,
    enabledBorder: enabledBorder,
    focusedBorder: focusedBorder,
    errorBorder: errorBorder,
  );
}

const enabledBorder = UnderlineInputBorder(
  borderRadius: const BorderRadius.all(
    Radius.circular(12.0),
  ),
  borderSide: BorderSide(
    color: Colors.indigoAccent,
  ),
);

const focusedBorder = UnderlineInputBorder(
  borderRadius: const BorderRadius.all(
    Radius.circular(12.0),
  ),
  borderSide: BorderSide(
    color: Colors.indigoAccent,
  ),
);

const errorBorder = UnderlineInputBorder(
  borderRadius: const BorderRadius.all(
    Radius.circular(12.0),
  ),
  borderSide: BorderSide(
    color: Colors.red,
  ),
);
