import 'package:flutter_admin_app/api/Index.dart';
import 'package:flutter/material.dart';

import '../tech/info.dart';
import '../user/info.dart';

class OrderInfoPage extends StatefulWidget {
  String arguments;
  OrderInfoPage({Key key, this.arguments = ''}) : super(key: key);

  @override
  _OrderInfoPageState createState() =>
      _OrderInfoPageState(arguments: this.arguments);
}

class _OrderInfoPageState extends State<OrderInfoPage> {
  String arguments;
  Map order = {"orderId": '123'};
  // Map record;
  Map tech = {"realName": '123'};
  Map user = {"realName": '123'};
  // List calls;
  _OrderInfoPageState({Key key, this.arguments = ''});

  @override
  void initState() {
    super.initState();
    if (this.arguments != '') {
      _getOrder().then((res) {
        setState(() {
          this.order = res['data']['order'];
          // this.record = res['data']['record'];
          this.tech = res['data']['tech'];
          this.user = res['data']['user'];
          // this.calls = res['data']['calls'];
        });
      });
    }
  }

  dynamic _getOrder() async {
    var res = await post('/order/detail', {"orderId": this.arguments});
    return res;
  }

  Widget buildUserWidget() {
    return ListView(
      children: <Widget>[
        Center(
          child: Container(
            width: 200,
            height: 200,
            child: CircleAvatar(
              radius: 50,
              child: Image.network(
                this.user['headImg'],
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
            Text(this.user['realName'] ?? '暂无')
          ],
        ),
        Row(
          children: <Widget>[
            Text('性别：'),
            Text(this.user['gender'].toString() ?? '女')
          ],
        ),
        Row(
          children: <Widget>[
            Text('手机号：'),
            Text(this.user['phone'] ?? '暂无')
          ],
        ),
        RaisedButton(
            child: Text('查看详情'),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => UserInfoPage(
                      arguments: this.user['userId'].toString(),
                    )));
            })
      ],
    );
  }

  Widget buildOrderWidget() {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text('订单编号: ${this.order['orderId']}')
        ),
        ListTile(
          title: Text('服务项目: ${this.order['projectsName']}')
        ),
        ListTile(
          title: Text('服务费: ${this.order['payService']}')
        ),
        ListTile(
          title: Text('交通费: ${this.order['payTrans']}')
        ),
        ListTile(
          title: Text('下单时间: ${this.order['addTime']}')
        ),
      ],
    );
  }

  Widget buildTechWidget() {
    return ListView(
      children: <Widget>[
        Center(
          child: Container(
            width: 200,
            height: 200,
            child: CircleAvatar(
              radius: 50,
              child: Image.network(
                this.tech['headImg'],
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
            Text(this.tech['realName'] ?? '暂无')
          ],
        ),
        Row(
          children: <Widget>[
            Text('性别：'),
            Text(this.tech['gender'].toString() ?? '女')
          ],
        ),
        Row(
          children: <Widget>[
            Text('手机号：'),
            Text(this.tech['phone'] ?? '暂无')
          ],
        ),
        RaisedButton(
            child: Text('查看详情'),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TechInfoPage(
                      arguments: this.tech['techId'].toString(),
                    )));
            })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
              this.buildUserWidget(),
              this.buildOrderWidget(),
              this.buildTechWidget()
            ])));
  }
}
