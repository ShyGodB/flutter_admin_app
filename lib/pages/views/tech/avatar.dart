import 'package:flutter/material.dart';

import '../../../api//Index.dart';

class AvatarListPage extends StatefulWidget {
  AvatarListPage({Key key}) : super(key: key);

  @override
  _AvatarListPageState createState() => _AvatarListPageState();
}

class _AvatarListPageState extends State<AvatarListPage> {
  _getData() async {
    var res = await get('/tech/listAvatar');
    return res;
  }

  Widget _buildWidget(data) {
    List<Widget> list = [];
    for (var item in data) {
      var column = ListTile(
          leading: CircleAvatar(child: Image.network(item['avatar'])),
          title: Text("技师姓名：${item['techName'] ?? ''} ( ${item['state'] ?? '审核中'} )"),
          subtitle: Text("上传时间：${item['createdAt'] ?? ''}"),
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
          title: Text('头像审核'),
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
