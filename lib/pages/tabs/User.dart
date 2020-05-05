import 'package:flutter/material.dart';

import '../../api//Index.dart';

import '../views/user/info.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List userList;

  @override
  void initState() { 
    super.initState();
    _listUser().then((res) {
      setState(() {
        userList = res.toList();
      });
    });
  }

  _listUser() async {
    var res = await get('/user/list');
    return res;
  }

  List<Widget> _buildUserListWidget() {
    List<Widget> list = [];
    for (var user in userList) {
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
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: this._buildUserListWidget()
    );
  }
}
