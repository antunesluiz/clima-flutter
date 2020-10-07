import 'package:flutter/material.dart';

class Label {
  static smallTextSpan(String rotulo){
    return TextSpan(
      text: rotulo + "\n",
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
    );
  }

  static medium(String rotulo){
    return Text(
      rotulo + "\n",
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 40,
      ),
      textAlign: TextAlign.center,
    );
  }

  static large(String rotulo){
    return Text(
      rotulo + "\n",
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 80,
      ),
    );
  }
}