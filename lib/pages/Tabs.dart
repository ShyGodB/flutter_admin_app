import 'package:flutter/material.dart';

import 'home/home.dart';
import 'order/order_list.dart';
import 'user/user_list.dart';
import 'tech/tech_list.dart';
import 'app/app.dart';

class Tabs extends StatefulWidget {
  Tabs({Key key}) : super(key: key);

  @override
  _TabState createState() => _TabState();
}

class _TabState extends State<Tabs> {
  int _currentIndex = 0;
  List _pageList = [
    Home(),
    OrderList(),
    UserList(),
    TechList(),
    App(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: this._pageList[this._currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: '订单'),
            BottomNavigationBarItem(
                icon: Icon(Icons.people), label: '用户'),
            BottomNavigationBarItem(
                icon: Icon(Icons.supervised_user_circle), label: '技师'),
            BottomNavigationBarItem(icon: Icon(Icons.apps), label: '应用')
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: this._currentIndex,
          onTap: (int index) {
            setState(() {
              this._currentIndex = index;
            });
          },
        ));
  }
}
