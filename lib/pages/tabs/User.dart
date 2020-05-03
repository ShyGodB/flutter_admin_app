import 'package:flutter/material.dart';

import '../../api//Index.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
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
    var res = await get('/user/list');
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
          ListTile(title: Text('余额：' + item['amount'])),
          ListTile(title: Text('注册时间：' + item['regTime'])),
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
