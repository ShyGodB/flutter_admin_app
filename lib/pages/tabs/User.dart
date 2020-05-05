import 'package:flutter/material.dart';

import '../../api//Index.dart';

import '../views/user/info.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  _listUser() async {
    var res = await get('/user/list');
    return res;
  }

  Widget _buildUserListWidget(data) {
    List<Widget> list = [];
    for (var user in data) {
      var column = Column(
        children: <Widget>[
          ListTile(title: Text("用户姓名：${user['realName'] ?? user['nickName'] ?? ''}")),
          ListTile(title: Text("手机号：${user['phone'] ?? '暂无'}")),
        ],
      );
      list.add(InkWell(
          child: Card(
            margin: EdgeInsets.all(10.0),
            child: column,
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => UserInfoPage(
                      arguments: user['userId'].toString(),
                    )));
          }));
    }
    return ListView(
      children: list
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: this._listUser(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData == false) {
          return Text('');
        } else {
          return this._buildUserListWidget(snapshot.data);
        }
      },
    );
  }
}
