import 'package:flutter/material.dart';

import '../../api/Index.dart';

import '../views/tech/info.dart';

class TechPage extends StatefulWidget {
  TechPage({Key key}) : super(key: key);

  @override
  _TechPageState createState() => _TechPageState();
}

class _TechPageState extends State<TechPage> {
  _listTech() async {
    var res = await get('/tech/list');
    return res;
  }

  Widget _buildTechListWidget(data) {
    List<Widget> list = [];
    for (var tech in data) {
      var column = Column(
        children: <Widget>[
          ListTile(title: Text("技师姓名：${tech['realName'] ?? ''}")),
          ListTile(title: Text("手机号：${tech['phone'] ?? '暂无'}")),
        ],
      );
      list.add(InkWell(
          child: Card(
            margin: EdgeInsets.all(10.0),
            child: column,
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TechInfoPage(
                      arguments: tech['techId'].toString(),
                    )));
          }));
    }
    return ListView(children: list);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: this._listTech(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData == false) {
          return Text('');
        } else {
          return this._buildTechListWidget(snapshot.data);
        }
      },
    );
  }
}
