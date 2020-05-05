import 'package:flutter_admin_app/api/Index.dart';
import 'package:flutter/material.dart';

class UserInfoPage extends StatefulWidget {
  String arguments;
  UserInfoPage({Key key, this.arguments = ''}) : super(key: key);

  @override
  _UserInfoPageState createState() =>
      _UserInfoPageState(arguments: this.arguments);
}

class _UserInfoPageState extends State<UserInfoPage> {
  String arguments;
  _UserInfoPageState({Key key, this.arguments = ''});

  Map user;
  @override
  void initState() {
    super.initState();
    if (this.arguments != '') {
      _getOrder().then((res) {
        setState(() {
          user = res;
        });
      });
    }
  }

  dynamic _getOrder() async {
    var res = await post('/user/info', {"userId": this.arguments});
    return res['data'];
  }

  Widget _buildUserInfoWidget() {
    return ListView(
      children: <Widget>[
        Container(
          height: 160.0,
          child: Column(
            children: <Widget>[
              Center(
                child: CircleAvatar(
                  child: Image.network(
                    this.user['headImg'], 
                    fit: BoxFit.cover
                  )
                )
              ),
              Text(this.user['realName'] ?? this.user['nickName' ?? '暂无姓名']),
              Text('手机系统: 未知')
            ],
          ),
        ),
        ListTile(
          leading: Icon(Icons.ac_unit),
          title: Text('充值余额 0'),
        ),
        ListTile(
          leading: Icon(Icons.ac_unit),
          title: Text('退款余额 0'),
        ),
        ListTile(
          leading: Icon(Icons.ac_unit),
          title: Text('邀请奖励 0'),
        ),
          ListTile(
            leading: Icon(Icons.ac_unit),
            title: Text("手机号 ${this.user['phone'] ?? '暂无'}"),
          ),
        ListTile(
          leading: Icon(Icons.ac_unit),
          title: Text("生日 ${this.user['birthday'] ?? '未知'}"),
        ),
        ListTile(
          leading: Icon(Icons.ac_unit),
          title: Text("注册时间 ${this.user['regTime'] ?? ''}"),
        ),
        ListTile(
          leading: Icon(Icons.ac_unit),
          title: Text("城市 ${this.user['city'] ?? ''}"),
        ),
        ListTile(
          leading: Icon(Icons.ac_unit),
          title: Text("位置"),
          subtitle: Text(this.user['location'] ?? ''),
        ),
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('用户详情'),
        ),
        body: this._buildUserInfoWidget()
      )
    );
  }
}
