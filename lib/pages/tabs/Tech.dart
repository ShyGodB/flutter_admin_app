import 'package:flutter/material.dart';

import '../../api/Index.dart';

class TechPage extends StatefulWidget {
  TechPage({Key key}) : super(key: key);

  @override
  _TechPageState createState() => _TechPageState();
}

class _TechPageState extends State<TechPage> {
  List tmpList;
  initState() {
    super.initState();
    _getData().then((val) {
      setState(() {
        tmpList = val.toList();
      });
    });
  }

  _getData() async {
    var res = await get('/tech/list');
    return res;
  }

  List<Widget> buildList() {
    List<Widget> list = [];
    for (var item in tmpList) {
      var column = Column(
        children: <Widget>[
          ListTile(title: Text('姓名：' + item['realName'])),
          Divider(),
          ListTile(title: Text('手机：' + item['phone'])),
          ListTile(title: Text('年龄：' + item['age'])),
          ListTile(title: Text('单量：' + item['orders'].toString())),
        ],
      );
      list.add(InkWell(
          child: Card(
            margin: EdgeInsets.all(10.0),
            child: column,
          ),
          onTap: () {
            print(item['orderId']);
          }));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: this.buildList());
  }
}
