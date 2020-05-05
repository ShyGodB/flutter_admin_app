import 'package:flutter/material.dart';

import '../../api/Index.dart';

import '../views/tech/info.dart';

class TechPage extends StatefulWidget {
  TechPage({Key key}) : super(key: key);

  @override
  _TechPageState createState() => _TechPageState();
}

class _TechPageState extends State<TechPage> {
  List techList;

  @override
  void initState() { 
    super.initState();
    _listUser().then((res) {
      setState(() {
        techList = res.toList();
      });
    });
  }

  _listUser() async {
    var res = await get('/tech/list');
    return res;
  }

  List<Widget> _buildTechListWidget() {
    List<Widget> list = [];
    for (var tech in techList) {
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
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: this._buildTechListWidget()
    );
  }
}
