import 'package:flutter/material.dart';

class Dimensions{
  static double height(context){
    return MediaQuery.of(context).size.height;
  }
  static double width(context){
    return MediaQuery.of(context).size.width;
  }
}