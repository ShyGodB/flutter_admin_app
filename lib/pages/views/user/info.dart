import 'package:flutter_admin_app/api/Index.dart';
import 'package:flutter/material.dart';

import '../tech/order.dart';

class UserInfoPage extends StatefulWidget {
  final String arguments;
  UserInfoPage({Key key, this.arguments = ''}) : super(key: key);

  @override
  _UserInfoPageState createState() =>
      _UserInfoPageState(arguments: this.arguments);
}

class _UserInfoPageState extends State<UserInfoPage> {
  String arguments;
  _UserInfoPageState({Key key, this.arguments = ''});

  dynamic _getData() async {
    var res = await post('/user/info', {"userId": this.arguments});
    return res['data'];
  }

  Widget _buildWidget(data) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('用户详情'),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              height: 160.0,
              decoration: BoxDecoration(color: Colors.grey),
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
                  Text(data['realName'] ?? '暂无姓名'),
                  Text('手机系统: 未知')
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    leading: Icon(Icons.account_balance_wallet),
                    title: Text('可提现余额'),
                  )
                ),
                Expanded(
                  child: ListTile(
                    title: Text('0', textAlign: TextAlign.right,),
                  )
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    leading: Icon(Icons.account_balance),
                    title: Text('充值余额'),
                  )
                ),
                Expanded(
                  child: ListTile(
                    title: Text('0', textAlign: TextAlign.right,),
                  )
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    leading: Icon(Icons.account_balance),
                    title: Text('邀请余额'),
                  )
                ),
                Expanded(
                  child: ListTile(
                    title: Text('0', textAlign: TextAlign.right,),
                  )
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    leading: Icon(Icons.phone_iphone),
                    title: Text('手机号'),
                  )
                ),
                Expanded(
                  child: ListTile(
                    title: Text("${data['phone'] ?? '暂无'}", textAlign: TextAlign.right,),
                  )
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    leading: Icon(Icons.clear_all),
                    title: Text('生日'),
                  )
                ),
                Expanded(
                  child: ListTile(
                    title: Text("${data['birthday'] ?? ''}", textAlign: TextAlign.right,),
                  )
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    leading: Icon(Icons.timeline),
                    title: Text('注册时间'),
                  )
                ),
                Expanded(
                  child: ListTile(
                    title: Text("${data['regTime'] ?? ''}", textAlign: TextAlign.right,),
                  )
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    leading: Icon(Icons.location_city),
                    title: Text('城市'),
                  )
                ),
                Expanded(
                  child: ListTile(
                    title: Text("${data['city'] ?? '暂无'}", textAlign: TextAlign.right,),
                  )
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text('用户位置'),
                  )
                ),
                Expanded(
                  child: ListTile(
                    title: Text("${data['location'] ?? ''}", textAlign: TextAlign.right,),
                  )
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.timelapse),
                              Text('历史订单')
                            ],
                          ),
                        )
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TechOrderPage(
                                arguments: data['userId'] ?? data['userId'].toString() ?? '',
                              )));
                      },
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.comment),
                              Text('技师评论')
                            ],
                          ),
                        )
                      ),
                      onTap: () {
                        print(123);
                      },
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.cloud_queue),
                              Text('优惠卷')
                            ],
                          ),
                        )
                      ),
                      onTap: () {
                        print(123);
                      },
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.rate_review),
                              Text('回访记录')
                            ],
                          ),
                        )
                      ),
                      onTap: () {
                        print(123);
                      },
                    ),
                  ),
                ],
              )
            )
          ]
        )
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
