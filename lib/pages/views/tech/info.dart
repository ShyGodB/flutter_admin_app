import 'package:flutter_admin_app/api/Index.dart';
import 'package:flutter/material.dart';

import './order.dart';
import './comment.dart';
import './growth.dart';

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
            decoration: BoxDecoration(color: Colors.white),
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
                    title: Text('审核时间'),
                  )
                ),
                Expanded(
                  child: ListTile(
                    title: Text("${data['authTime'] ?? ''}", textAlign: TextAlign.right,),
                  )
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    leading: Icon(Icons.location_city),
                    title: Text('归属'),
                  )
                ),
                Expanded(
                  child: ListTile(
                    title: Text("${data['agentName'] ?? '未知'}", textAlign: TextAlign.right,),
                  )
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text('从业年份'),
                  )
                ),
                Expanded(
                  child: ListTile(
                    title: Text("${data['jobYear'] ?? ''}", textAlign: TextAlign.right,),
                  )
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text('状态'),
                  )
                ),
                Expanded(
                  child: ListTile(
                    title: Text("${data['state'] ?? ''}", textAlign: TextAlign.right,),
                  )
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text('简介'),
                  )
                ),
                Expanded(
                  child: ListTile(
                    title: Text("${data['remark'] ?? ''}", textAlign: TextAlign.right,),
                  )
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text('当前位置'),
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
                                arguments: data['techId'].toString() ?? '',
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
                              Text('用户评论')
                            ],
                          ),
                        )
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CommentOfUserToTechPage(
                                arguments: data['techId'].toString() ?? '',
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
                              Icon(Icons.cloud_queue),
                              Text('成长记录')
                            ],
                          ),
                        )
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => GrowtListPage(
                                arguments: data['techId'].toString() ?? '',
                              )));
                      },
                    ),
                  ),
                ],
              )
            )
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