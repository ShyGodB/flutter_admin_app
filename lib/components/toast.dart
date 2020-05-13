import 'package:flutter/material.dart';

class MessageToast {
  static Widget success(String msg) {
    return Center(
      child: Card(
        color: Colors.black,
        child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Text(
          '登陆成功',
          style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          ),
        ),
        ),
      ),
      ); 
  }
}