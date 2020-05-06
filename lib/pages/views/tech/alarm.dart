import 'package:flutter/material.dart';

import '../../../api//Index.dart';

class AlarmListPage extends StatefulWidget {
  AlarmListPage({Key key}) : super(key: key);

  @override
  _AlarmListPageState createState() => _AlarmListPageState();
}

class _AlarmListPageState extends State<AlarmListPage> {
  _getData() async {
    var res = await get('/alarm/list');
    return res;
  }

  Widget _buildWidget(data) {
    List<Widget> list = [];
    for (var item in data) {
      var column = Column(
        children: <Widget>[
          ListTile(title: Text("技师姓名：${item['techName'] ?? ''}")),
          ListTile(title: Text("用户姓名：${item['userName'] ?? ''}")),
          ListTile(title: Text("技师手机：${item['techPhone'] ?? ''}")),
          ListTile(title: Text("用户手机：${item['userPhone'] ?? ''}")),
          ListTile(title: Text("呼叫时间：${item['callTime'] ?? ''}")),
          ListTile(title: Text("呼叫地址：${item['address'] ?? ''}")),
        ],
      );
      list.add(InkWell(
          child: Card(
            margin: EdgeInsets.all(10.0),
            child: column,
          ),
          onTap: () {
            print('呼叫');
          }));
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('技师呼叫'),
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
