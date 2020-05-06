import 'package:flutter/material.dart';

import '../../../api//Index.dart';

class GrowtListPage extends StatefulWidget {
  GrowtListPage({Key key}) : super(key: key);

  @override
  _GrowtListPageState createState() => _GrowtListPageState();
}

class _GrowtListPageState extends State<GrowtListPage> {
  _getData() async {
    var res = await get('/tech/listGrowth');
    return res;
  }

  Widget _buildWidget(data) {
    List<Widget> list = [];
    for (var item in data) {
      var column = Column(
        children: <Widget>[
          ListTile(title: Text("技师姓名：${item['techName'] ?? ''}")),
          ListTile(title: Text("技师手机：${item['techPhone'] ?? ''}")),
          ListTile(
            title: Text("灯色：${item['light'] ?? ''}"),
            subtitle: Text("原因: ${item['reason'] ?? ''}")
          ),
          ListTile(
            title: Text("添加人：${item['creatorName'] ?? ''}"),
            subtitle: Text('添加时间：${item['createdAt'] ?? ''}'),
          ),
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
          title: Text('成长记录'),
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
