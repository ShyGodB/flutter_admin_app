import 'package:flutter_admin_app/api/Index.dart';
import 'package:flutter/material.dart';

class TechInfoPage extends StatefulWidget {
  final String arguments;
  TechInfoPage({Key key, this.arguments = ''}) : super(key: key);

  @override
  _TechInfoPageState createState() =>
      _TechInfoPageState(arguments: this.arguments);
}

class _TechInfoPageState extends State<TechInfoPage> {
  String arguments;
  _TechInfoPageState({Key key, this.arguments = ''});

  dynamic _getData() async {
    var res = await post('/tech/detail', {"techId": this.arguments});
    return res['data'];
  }

  Widget _buildWidget(data) {
    return Scaffold(
        appBar: AppBar(
          title: Text('技师详情'),
        ),
        body: ListView(
        children: <Widget>[
          Container(
            height: 200.0,
            decoration: BoxDecoration(color: Colors.blueGrey),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(data['headImg'])
                    )
                  )
                ),
                Text(data['realName'] ?? data['nickName' ?? '暂无姓名']),
                Text('手机系统: 未知'),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text("¥ 0"),
                          Text('账户余额')
                        ]
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text("¥ 0"),
                          Text('总收入')
                        ]
                      ),
                    )
                  ]
                )
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
            title: Text("手机号 ${data['phone'] ?? '暂无'}"),
          ),
          ListTile(
            leading: Icon(Icons.ac_unit),
            title: Text("生日 ${data['birthday'] ?? '未知'}"),
          ),
          ListTile(
            leading: Icon(Icons.ac_unit),
            title: Text("注册时间 ${data['regTime'] ?? ''}"),
          ),
          ListTile(
            leading: Icon(Icons.ac_unit),
            title: Text("城市 ${data['city'] ?? ''}"),
          ),
          ListTile(
            leading: Icon(Icons.ac_unit),
            title: Text("位置"),
            subtitle: Text(data['location'] ?? ''),
          ),
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData == false) {
          return Text('');
        } else {
          return this._buildWidget(snapshot.data);
        }
      }
    );
  }
}