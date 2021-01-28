import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.all(12.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.green, width: 2.0),
  ),
);

const pgButtonTextDecoration = TextStyle(
  fontSize: 20,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

const buttonTextDecoration = TextStyle(
  fontSize: 18.0,
  color: Color(0xFF2a662d),
  fontWeight: FontWeight.bold,
);

const textDecoration = TextStyle(
  letterSpacing: .5,
  fontSize: 18.0,
  color: Colors.black,
  // fontWeight: FontWeight.bold,
);
