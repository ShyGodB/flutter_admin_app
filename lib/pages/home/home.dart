import 'package:flutter/material.dart';
import 'package:flutter_admin_app/api/Index.dart';
import 'components/echart.dart';
import 'components/user_tech.dart';
import 'components/bottom_item.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map form = { "pageIndex": 1, "pageSize": 10 };

  _getData() async {
      var res = await post('/index/data', form);
      return res;
  }

  Widget _getBottomWidget(today, yesterday, total) {
      return Column(children: <Widget>[
          Container(
              padding: EdgeInsets.all(10.0),
              child: Row(children: <Widget>[
                  Expanded(
                      child: Column(children: <Widget>[
                          Icon(Icons.money_off),
                          Text('交易额'),
                      ],)
                  ),
                  Container(height: 30, child: VerticalDivider(color: Colors.grey)),
                  Expanded(
                      child: Column(children: <Widget>[
                          Text("${today['turnover']}"),
                          Text('今日'),
                      ],)
                  ),
                  Container(height: 30, child: VerticalDivider(color: Colors.grey)),
                  Expanded(
                      child: Column(children: <Widget>[
                          Text("${yesterday['turnover']}"),
                          Text('昨日'),
                      ],)
                  ),
                  Container(height: 30, child: VerticalDivider(color: Colors.grey)),
                  Expanded(
                      child: Column(children: <Widget>[
                          Text("${total['turnover']}"),
                          Text('累计'),
                      ],)
                  ),
              ],),
          ),
          Container(
              padding: EdgeInsets.all(10.0),
              child: Row(children: <Widget>[
                  Expanded(
                      child: Column(children: <Widget>[
                          Icon(Icons.money_off),
                          Text('总单量'),
                      ],)
                  ),
                  Container(height: 30, child: VerticalDivider(color: Colors.grey)),
                  Expanded(
                      child: Column(children: <Widget>[
                          Text("${today['totalOrder']}"),
                          Text('今日'),
                      ],)
                  ),
                  Container(height: 30, child: VerticalDivider(color: Colors.grey)),
                  Expanded(
                      child: Column(children: <Widget>[
                          Text("${yesterday['totalOrder']}"),
                          Text('昨日'),
                      ],)
                  ),
                  Container(height: 30, child: VerticalDivider(color: Colors.grey)),
                  Expanded(
                      child: Column(children: <Widget>[
                          Text("${total['totalOrder']}"),
                          Text('累计'),
                      ],)
                  ),
              ],),
          ),
          Container(
              padding: EdgeInsets.all(10.0),
              child: Row(children: <Widget>[
                  Expanded(
                      child: Column(children: <Widget>[
                          Icon(Icons.money_off),
                          Text('超时接单'),
                      ],)
                  ),
                  Container(height: 30, child: VerticalDivider(color: Colors.grey)),
                  Expanded(
                      child: Column(children: <Widget>[
                          Text("${today['overTimeOrder']}"),
                          Text('今日'),
                      ],)
                  ),
                  Container(height: 30, child: VerticalDivider(color: Colors.grey)),
                  Expanded(
                      child: Column(children: <Widget>[
                          Text("${yesterday['overTimeOrder']}"),
                          Text('昨日'),
                      ],)
                  ),
                  Container(height: 30, child: VerticalDivider(color: Colors.grey)),
                  Expanded(
                      child: Column(children: <Widget>[
                          Text("${total['overTimeOrder']}"),
                          Text('累计'),
                      ],)
                  ),
              ],),
          ),
          Container(
              padding: EdgeInsets.all(10.0),
              child: Row(children: <Widget>[
                  Expanded(
                      child: Column(children: <Widget>[
                          Icon(Icons.money_off),
                          Text('用户取消'),
                      ],)
                  ),
                  Container(height: 30, child: VerticalDivider(color: Colors.grey)),
                  Expanded(
                      child: Column(children: <Widget>[
                          Text("${today['cancelOrder']}"),
                          Text('今日'),
                      ],)
                  ),
                  Container(height: 30, child: VerticalDivider(color: Colors.grey)),
                  Expanded(
                      child: Column(children: <Widget>[
                          Text("${yesterday['cancelOrder']}"),
                          Text('昨日'),
                      ],)
                  ),
                  Container(height: 30, child: VerticalDivider(color: Colors.grey)),
                  Expanded(
                      child: Column(children: <Widget>[
                          Text("${total['cancelOrder']}"),
                          Text('累计'),
                      ],)
                  ),
              ],),
          ),
          Container(
              padding: EdgeInsets.all(10.0),
              child: Row(children: <Widget>[
                  Expanded(
                      child: Column(children: <Widget>[
                          Icon(Icons.money_off),
                          Text('交通费'),
                      ],)
                  ),
                  Container(height: 30, child: VerticalDivider(color: Colors.grey)),
                  Expanded(
                      child: Column(children: <Widget>[
                          Text("${today['transFee']}"),
                          Text('今日'),
                      ],)
                  ),
                  Container(height: 30, child: VerticalDivider(color: Colors.grey)),
                  Expanded(
                      child: Column(children: <Widget>[
                          Text("${yesterday['transFee']}"),
                          Text('昨日'),
                      ],)
                  ),
                  Container(height: 30, child: VerticalDivider(color: Colors.grey)),
                  Expanded(
                      child: Column(children: <Widget>[
                          Text("${total['transFee']}"),
                          Text('累计'),
                      ],)
                  ),
              ],),
          ),
          Container(
              padding: EdgeInsets.all(10.0),
              child: Row(children: <Widget>[
                  Expanded(
                      child: Column(children: <Widget>[
                          Icon(Icons.money_off),
                          Text('优惠卷'),
                      ],)
                  ),
                  Container(height: 30, child: VerticalDivider(color: Colors.grey)),
                  Expanded(
                      child: Column(children: <Widget>[
                          Text("${today['couponFee']}"),
                          Text('今日'),
                      ],)
                  ),
                  Container(height: 30, child: VerticalDivider(color: Colors.grey)),
                  Expanded(
                      child: Column(children: <Widget>[
                          Text("${yesterday['couponFee']}"),
                          Text('昨日'),
                      ],)
                  ),
                  Container(height: 30, child: VerticalDivider(color: Colors.grey)),
                  Expanded(
                      child: Column(children: <Widget>[
                          Text("${total['couponFee']}"),
                          Text('累计'),
                      ],)
                  ),
              ],),
          )
      ],);
  }

  Widget _buildWidget(res) {
    var week = res['data']['week'];
    var today = res['data']['today'];
    var yesterday = res['data']['yesterday'];
    var total = res['data']['total'];
    var userCount = res['data']['userCount'];
    var techCount = res['data']['techCount'];
    List times = [];
    List orders = [];
    List turnover = [];
    week.forEach((item) {
        times.add(item['time']);
        orders.add(item['totalOrder']);
        turnover.add(item['turnover']);
    });
    return ListView(children: <Widget>[
        Container(
            height: 150,
            child: HomeEchart(orders: orders, times: times, turnover: turnover)
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Column(children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: UserTechCount(userCount: userCount, techCount: techCount)
            ),
            Container(
              child: Column(children: <Widget>[
                BottomItem(title: '交易额', today: today['turnover'].toString(), yestoday: yesterday['turnover'].toString(), total: total['turnover'].toString()),
                BottomItem(title: '总单量', today: today['totalOrder'].toString(), yestoday: yesterday['totalOrder'].toString(), total: total['totalOrder'].toString()),
                BottomItem(title: '超时接单', today: today['overTimeOrder'].toString(), yestoday: yesterday['overTimeOrder'].toString(), total: total['overTimeOrder'].toString()),
                BottomItem(title: '用户取消', today: today['cancelOrder'].toString(), yestoday: yesterday['cancelOrder'].toString(), total: total['cancelOrder'].toString()),
                BottomItem(title: '交通费', today: today['transFee'].toString(), yestoday: yesterday['transFee'].toString(), total: total['transFee'].toString()),
                BottomItem(title: '优惠卷', today: today['couponFee'].toString(), yestoday: yesterday['couponFee'].toString(), total: total['couponFee'].toString()),
              ],)
            )
          ],)
        )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: this._getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData == false) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Container(
            color: Color(0xffeeeeee),
            child: this._buildWidget(snapshot.data),
          );
        }
      },
    );
  }
}