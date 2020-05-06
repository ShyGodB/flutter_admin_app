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

  Widget _buildOrderTimeWidget(data) {
    List<Widget> list = [];
    if (data['addTime'] != null && data['addTime'] != '') list.add(ListTile(title: Text('下单时间: ${data['addTime']}')));
    if (data['payTime'] != null && data['payTime'] != '') list.add(ListTile(title: Text('支付时间: ${data['payTime']}')));
    if (data['acceptTime'] != null && data['acceptTime'] != '') list.add(ListTile(title: Text('接单时间: ${data['acceptTime']}')));
    if (data['leaveTime'] != null && data['leaveTime'] != '') list.add(ListTile(title: Text('出发时间: ${data['leaveTime']}')));
    if (data['arriveTime'] != null && data['arriveTime'] != '') list.add(ListTile(title: Text('到达时间: ${data['arriveTime']}')));
    if (data['startTime'] != null && data['startTime'] != '') list.add(ListTile(title: Text('开始时间: ${data['startTime']}')));
    if (data['endTime'] != null && data['endTime'] != '') list.add(ListTile(title: Text('完成时间: ${data['endTime']}')));
    if (data['cancelTime'] != null && data['cancelTime'] != '') list.add(ListTile(title: Text('取消时间: ${data['cancelTime']}')));

    return ListView(
      children: list
    );
  }

  Widget _buildOrderDetailWidget(data) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text('订单编号: ${data['orderId']}')
        ),
        ListTile(
          title: Text('服务项目: ${data['projectsName']}')
        ),
        ListTile(
          title: Text("联系人: ${data['contacName']}  ${data['contactPhone']}")
        ),
        ListTile(
          title: Text('服务时间: ${data['serviceTime']}')
        ),
        ListTile(
          title: Text('服务时长: ${data['duration']}')
        ),
        ListTile(
          title: Text('服务地址: ${data['serveAddress']}')
        ),
        ListTile(
          title: Text('下单时技师位置: ${data['addTechAddress']}')
        ),
        ListTile(
          title: Text('出发位置: ${data['leaveTechAddress']}')
        ),
        ListTile(
          title: Text('车费详情: ${data['tranMsg']}')
        ),
        ListTile(
          title: Text('用户备注: ${data['userRemark']}')
        ),
        ListTile(
          title: Text('技师备注: ${data['techRemark']}')
        ),
        Container(
          child: Row(
            children: <Widget>[
              Column(children: <Widget>[
                Text('现场照片'),
                Image.network(data['sceneImg'] ?? 'http://pictest.edtuina.com/activity/1588750996086ihpp.png')
              ]),
              Column(children: <Widget>[
                Text('用户签名'),
                Image.network(data['userSign'] ?? 'http://pictest.edtuina.com/activity/1588750996086ihpp.png')
              ]),
            ]
          )
        )
      ],
    );
  }

  Widget _buildPayInfoWidget(data) {
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

  Widget buildUserWidget(data) {
    if (data == null) return Text('无用户信息');
    return ListView(
      children: <Widget>[
        Center(
          child: Container(
            width: 200,
            height: 200,
            child: CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(data['headImg'])
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
    if (data == null) return Text('无订单信息');

    return DefaultTabController(
      length: 3, 
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: Colors.orange,
            indicatorWeight: 3,
            tabs: <Widget>[
              Tab(text: '时间'),
              Tab(text: '详情'),
              Tab(text: '支付')
            ],
          )
        ),
        body: TabBarView(children: <Widget>[
          this._buildOrderTimeWidget(data),
          this._buildOrderDetailWidget(data),
          this._buildPayInfoWidget(data)
        ],)
      )
    );
  }

  Widget buildTechWidget(data) {
    if (data == null) return Text('无技师信息');
    return ListView(
      children: <Widget>[
        Center(
          child: Container(
            width: 200,
            height: 200,
            child: CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(data['headImg'])
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
                  ]
              ),
            ),
            body: TabBarView(children: <Widget>[
              this.buildUserWidget(data['data']['user']),
              this.buildOrderWidget(data['data']['order']),
              this.buildTechWidget(data['data']['tech'])
            ])
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
