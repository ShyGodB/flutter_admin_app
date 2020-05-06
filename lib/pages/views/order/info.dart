import 'package:flutter_admin_app/api/Index.dart';
import 'package:flutter/material.dart';

import '../tech/info.dart';
import '../user/info.dart';

class OrderInfoPage extends StatefulWidget {
  final String arguments;
  OrderInfoPage({Key key, this.arguments = ''}) : super(key: key);

  @override
  _OrderInfoPageState createState() =>
      _OrderInfoPageState(arguments: this.arguments);
}

class _OrderInfoPageState extends State<OrderInfoPage> {
  String arguments;
  _OrderInfoPageState({Key key, this.arguments = ''});

  dynamic _getData() async {
    var res = await post('/order/detail', {"orderId": this.arguments});
    return res;
  }

  Widget buildUserWidget(data) {
    return ListView(
      children: <Widget>[
        Center(
          child: Container(
            width: 200,
            height: 200,
            child: CircleAvatar(
              radius: 50,
              child: Image.network(
                data['headImg'],
                width: 200.0, 
                height: 200.0,
                fit: BoxFit.cover,
              )
            )
          )
        ),
        Row(
          children: <Widget>[
            Text('姓名：'),
            Text(data['realName'] ?? '暂无')
          ],
        ),
        Row(
          children: <Widget>[
            Text('性别：'),
            Text(data['gender'].toString() ?? '女')
          ],
        ),
        Row(
          children: <Widget>[
            Text('手机号：'),
            Text(data['phone'] ?? '暂无')
          ],
        ),
        RaisedButton(
            child: Text('查看详情'),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => UserInfoPage(
                      arguments: data['userId'].toString(),
                    )));
            })
      ],
    );
  }

  Widget buildOrderWidget(data) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text('订单编号: ${data['orderId']}')
        ),
        ListTile(
          title: Text('服务项目: ${data['projectsName']}')
        ),
        ListTile(
          title: Text('服务费: ${data['payService']}')
        ),
        ListTile(
          title: Text('交通费: ${data['payTrans']}')
        ),
        ListTile(
          title: Text('下单时间: ${data['addTime']}')
        ),
      ],
    );
  }

  Widget buildTechWidget(data) {
    return ListView(
      children: <Widget>[
        Center(
          child: Container(
            width: 200,
            height: 200,
            child: CircleAvatar(
              radius: 50,
              child: Image.network(
                data['headImg'],
                width: 200.0, 
                height: 200.0,
                fit: BoxFit.cover,
              )
            )
          )
        ),
        Row(
          children: <Widget>[
            Text('姓名：'),
            Text(data['realName'] ?? '暂无')
          ],
        ),
        Row(
          children: <Widget>[
            Text('性别：'),
            Text(data['gender'].toString() ?? '女')
          ],
        ),
        Row(
          children: <Widget>[
            Text('手机号：'),
            Text(data['phone'] ?? '暂无')
          ],
        ),
        RaisedButton(
            child: Text('查看详情'),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TechInfoPage(
                      arguments: data['techId'].toString(),
                    )));
            })
      ],
    );
  }

  Widget _buildWidget(data) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              title: Text('订单详情'),
              centerTitle: true,
              bottom: TabBar(
                  indicatorColor: Colors.red,
                  indicatorWeight: 3,
                  tabs: <Widget>[
                    Tab(text: '用户'),
                    Tab(text: '订单'),
                    Tab(text: '技师'),
                  ]),
            ),
            body: TabBarView(children: <Widget>[
              this.buildUserWidget(data['data']['user']),
              this.buildOrderWidget(data['data']['order']),
              this.buildTechWidget(data['data']['tech'])
            ])));
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
