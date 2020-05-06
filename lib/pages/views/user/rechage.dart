import 'package:flutter/material.dart';

import '../../../api//Index.dart';

class RechargeListPage extends StatefulWidget {
  RechargeListPage({Key key}) : super(key: key);

  @override
  _RechargeListPageState createState() => _RechargeListPageState();
}

class _RechargeListPageState extends State<RechargeListPage> {
  _getData() async {
    var res = await get('/user/listRecharge');
    return res;
  }

  Widget _buildWidget(data) {
    List<Widget> list = [];
    for (var item in data) {
      var column = Column(
        children: <Widget>[
          ListTile(title: Text("用户姓名：${item['userName'] ?? ''}")),
          ListTile(title: Text("手机号：${item['userPhone'] ?? ''}")),
          ListTile(title: Text("退款金额：${item['amount'] ?? ''}")),
          ListTile(title: Text("退款状态：${item['state'] ?? ''}")),
        ],
      );
      list.add(InkWell(
          child: Card(
            margin: EdgeInsets.all(10.0),
            child: column,
          ),
          onTap: () {
            print('退款编号');
          }));
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('充值列表'),
        ),
        body: ListView(
          children: list
        )
      );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: this._getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData == false) {
          return Text('');
        } else {
          return this._buildWidget(snapshot.data);
        }
      },
    );
  }
}
