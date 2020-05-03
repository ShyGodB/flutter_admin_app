import 'package:flutter/material.dart';

class OrderInfoPage extends StatefulWidget {
  OrderInfoPage({Key key, String arguments}) : super(key: key);

  @override
  _OrderInfoPageState createState() => _OrderInfoPageState();
}

class _OrderInfoPageState extends State<OrderInfoPage> {
  List tmpList = [];

  get arguments => null;

  initState() {
    super.initState();
    print('orderId is $arguments');
  }

  @override
  Widget build(BuildContext context) {
    return Text('订单详情');
  }
}
