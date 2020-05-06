import 'package:flutter/material.dart';

import '../../../api//Index.dart';

class GrowtListPage extends StatefulWidget {
  final String arguments;
  GrowtListPage({Key key, this.arguments = ''}) : super(key: key);

  @override
  _GrowtListPageState createState() => _GrowtListPageState(arguments: this.arguments);
}

class _GrowtListPageState extends State<GrowtListPage> {
  String arguments;
  _GrowtListPageState({Key key, this.arguments = ''});

  _getData() async {
    var res = await post('/tech/listGrowth', { "techId": arguments });
    return res['data']['list'];
  }

  Widget _buildWidget(data) {
    List<Widget> list = [];
    if (data.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('成长记录'),
        ),
        body: Text('暂无数据')
      );
    }
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
