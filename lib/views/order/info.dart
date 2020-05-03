import 'package:flutter/material.dart';

class OrderInfoPage extends StatefulWidget {
  OrderInfoPage({Key key, String arguments}) : super(key: key);

  @override
  _OrderInfoPageState createState() => _OrderInfoPageState();
}

class _OrderInfoPageState extends State<OrderInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('订单详情')),
        body: ListView(
          children: <Widget>[
            Text('这是订单详情页面，可从订单列表跳转'),
            RaisedButton(
              child: Text('点击返回'),
              onPressed: () {
                print('123123');
                Navigator.pop(context);
              },
            )
          ],
        ));
  }
}
