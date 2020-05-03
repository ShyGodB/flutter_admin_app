import 'package:flutter/material.dart';

class OrderInfoPage extends StatefulWidget {
  String arguments;
  OrderInfoPage({Key key, this.arguments = ''}) : super(key: key);

  @override
  _OrderInfoPageState createState() =>
      _OrderInfoPageState(arguments: this.arguments);
}

class _OrderInfoPageState extends State<OrderInfoPage> {
  String arguments;
  _OrderInfoPageState({Key key, this.arguments = '123123受到粉丝的12'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(this.arguments)),
        body: ListView(
          children: <Widget>[
            Text('这是订单详情页面，可从订单列表跳转'),
            RaisedButton(
              child: Text('点击返回'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ));
  }
}
