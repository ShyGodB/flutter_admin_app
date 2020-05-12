import 'package:flutter/material.dart';

import '../../api//Index.dart';

import '../views/user/info.dart';

class UserList extends StatefulWidget {
  UserList({Key key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
    Map form = { "pageIndex": 1, "pageSize": 10 };
    _listUser() async {
        var res = await post('/user/list', form);
        return res['data']['list'];
    }

  Widget _buildUserListWidget(data) {
    List<Widget> list = [];
    for (var user in data) {
        var column = ListTile(
            leading: CircleAvatar(backgroundImage: NetworkImage(user['headImg']),),
            title: Text("${user['realName'] ?? user['nickName']}   ${user['gender']}  ${user['phone']}"),
            subtitle: Text("${user['regTime']}    状态 ${user['state']}")
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
