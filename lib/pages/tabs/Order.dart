import 'package:flutter/material.dart';
import '../../api/Index.dart';

class OrderPage extends StatefulWidget {
  OrderPage({Key key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List tmpList = [];
  initState() {
    super.initState();
    _getData().then((val) {
      setState(() {
        tmpList = val.toList();
      });
    });
  }

  _getData() async {
    var res = await get('/order/list');
    return res;
  }

  List<Widget> buildList() {
    List<Widget> list = [];
    for (var item in tmpList) {
      var column = Column(
        children: <Widget>[
          ListTile(title: Text('技师姓名：' + item['techName'])),
          Divider(),
          ListTile(title: Text('项目名称：' + item['projectsName'])),
          ListTile(title: Text('下单时间：' + item['addTime'])),
          ListTile(title: Text('实付金额：' + item['payPrice'].toString())),
        ],
      );
      list.add(InkWell(
          child: Card(
            margin: EdgeInsets.all(10.0),
            child: column,
          ),
          onTap: () {
            Navigator.pushNamed(context, '/order/info',
                arguments: item['orderId']);
          }));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: this.buildList());
  }
}
