import 'package:app_admin_edtuina/api/Index.dart';
import 'package:flutter/material.dart';

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
  Map record;
  Map tech = {"realName": '123'};
  Map user = {"realName": '123'};
  List calls;
  _OrderInfoPageState({Key key, this.arguments = ''});

  @override
  void initState() {
    super.initState();
    if (this.arguments != '') {
      _getOrder().then((res) {
        setState(() {
          this.order = res['data']['order'];
          this.record = res['data']['record'];
          this.tech = res['data']['tech'];
          this.user = res['data']['user'];
          this.calls = res['data']['calls'];
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
        Center(child: CircleAvatar(child: Image.network(this.user['headImg']))),
        Text('姓名：' + this.user['realName']),
        Text('性别' + this.user['gender']),
        Text('手机号：' + this.user['phone']),
        RaisedButton(
            child: Text('查看详情'),
            onPressed: () {
              print('用户详情 is ');
            })
      ],
    );
  }

  Widget buildTechWidget() {
    return ListView(
      children: <Widget>[
        Container(
            child: Center(
                child: CircleAvatar(
                    child: Image.network(this.tech['headImg'],
                        width: 200.0, height: 200.0)))),
        Text('姓名：' + this.user['realName']),
        Text('性别' + this.user['gender']),
        Text('手机号：' + this.user['phone']),
        RaisedButton(
            child: Text('查看详情'),
            onPressed: () {
              print('技师详情 is ');
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
              ListView(
                children: <Widget>[
                  RaisedButton(
                    child: Text('点击返回2'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
              this.buildTechWidget()
            ])));
  }
}
