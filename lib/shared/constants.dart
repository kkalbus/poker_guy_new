import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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

var pgButtonTextDecoration = TextStyle(
  fontSize: 12.0.sp,
  color: Colors.black,
);

var textDecoration = TextStyle(
  fontSize: 18.0.sp,
  color: Colors.black,
  // fontWeight: FontWeight.bold,
);
