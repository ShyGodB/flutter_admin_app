import 'package:flutter_admin_app/api/Index.dart';
import 'package:flutter/material.dart';

class TechInfoPage extends StatefulWidget {
  String arguments;
  TechInfoPage({Key key, this.arguments = ''}) : super(key: key);

  @override
  _TechInfoPageState createState() =>
      _TechInfoPageState(arguments: this.arguments);
}

class _TechInfoPageState extends State<TechInfoPage> {
  String arguments;
  _TechInfoPageState({Key key, this.arguments = ''});

  Map tech;
  @override
  void initState() {
    super.initState();
    if (this.arguments != '') {
      _getOrder().then((res) {
        setState(() {
          tech = res;
        });
      });
    }
  }

  dynamic _getOrder() async {
    var res = await post('/tech/detail', {"techId": this.arguments});
    return res['data'];
  }

  Widget _buildTechInfoWidget() {
    return ListView(
      children: <Widget>[
        Container(
          height: 160.0,
          child: Column(
            children: <Widget>[
              Center(
                child: CircleAvatar(
                  child: Image.network(this.tech['headImg'], fit: BoxFit.cover)
                )
              ),
              Text(this.tech['realName'] ?? this.tech['nickName' ?? '暂无姓名']),
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
            title: Text("手机号 ${this.tech['phone'] ?? '暂无'}"),
          ),
        ListTile(
          leading: Icon(Icons.ac_unit),
          title: Text("生日 ${this.tech['birthday'] ?? '未知'}"),
        ),
        ListTile(
          leading: Icon(Icons.ac_unit),
          title: Text("注册时间 ${this.tech['regTime'] ?? ''}"),
        ),
        ListTile(
          leading: Icon(Icons.ac_unit),
          title: Text("城市 ${this.tech['city'] ?? ''}"),
        ),
        ListTile(
          leading: Icon(Icons.ac_unit),
          title: Text("位置"),
          subtitle: Text(this.tech['location'] ?? ''),
        ),
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('技师详情'),
        ),
        body: this._buildTechInfoWidget()
    );
  }
}
