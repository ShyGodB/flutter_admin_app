import 'package:flutter/material.dart';
import '../../../api/index.dart';

import '../order/info.dart';

class TechOrderPage extends StatefulWidget {
  final String arguments;
  TechOrderPage({Key key, this.arguments = ''}) : super(key: key);

  @override
  _TechOrderPageState createState() => _TechOrderPageState(arguments: this.arguments);
}

class _TechOrderPageState extends State<TechOrderPage> {
  String arguments;
  _TechOrderPageState({Key key, this.arguments = ''});

  _listOrder() async {
    var res = await post('/order/list', { "techId": this.arguments });
    return res['data']['list'];
  }

  Widget _buildOrderListWidget(data) {
    List<Widget> list = [];
    if (data.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('用户历史订单'),
        ),
        body: Text('暂无数据')
      );
    }
    for (var item in data) {
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
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => OrderInfoPage(
                      arguments: item['orderId'] ?? item['orderId'].toString() ?? '',
                    )));
          }));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('用户历史订单'),
      ),
      body: ListView(
        children: list
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: this._listOrder(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData == false) {
          return Text('');
        } else {
          return this._buildOrderListWidget(snapshot.data);
        }
      },
    );
  }
}
