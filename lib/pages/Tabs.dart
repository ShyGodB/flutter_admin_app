import 'package:flutter/material.dart';

import 'tabs/Home.dart';
import 'tabs/Order.dart';
// import 'tabs/User.dart';
// import 'tabs/Tech.dart';
import 'tabs/App.dart';

class Tabs extends StatefulWidget {
  Tabs({Key key}) : super(key: key);

  @override
  _TabState createState() => _TabState();
}

class _TabState extends State<Tabs> {
  int _currentIndex = 0;
  List _pageList = [
    HomePage(),
    OrderPage(),
    // UserPage(),
    // TechPage(),
    AppPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('edtuina后台')),
        body: this._pageList[this._currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
            BottomNavigationBarItem(icon: Icon(Icons.book), title: Text('订单')),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.people), title: Text('用户')),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.supervised_user_circle), title: Text('技师')),
            BottomNavigationBarItem(icon: Icon(Icons.apps), title: Text('应用'))
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
