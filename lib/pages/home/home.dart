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
  Map form = {"pageIndex": 1, "pageSize": 10};

  _getData() async {
    var res = await post('/index/data', form);
    return res;
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
          child: HomeEchart(orders: orders, times: times, turnover: turnover)),
      Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: UserTechCount(
                      userCount: userCount, techCount: techCount)),
              Container(
                  child: Column(
                children: <Widget>[
                  BottomItem(
                      title: '交易额',
                      today: today['turnover'].toString(),
                      yestoday: yesterday['turnover'].toString(),
                      total: total['turnover'].toString()),
                  BottomItem(
                      title: '总单量',
                      today: today['totalOrder'].toString(),
                      yestoday: yesterday['totalOrder'].toString(),
                      total: total['totalOrder'].toString()),
                  BottomItem(
                      title: '超时接单',
                      today: today['overTimeOrder'].toString(),
                      yestoday: yesterday['overTimeOrder'].toString(),
                      total: total['overTimeOrder'].toString()),
                  BottomItem(
                      title: '用户取消',
                      today: today['cancelOrder'].toString(),
                      yestoday: yesterday['cancelOrder'].toString(),
                      total: total['cancelOrder'].toString()),
                  BottomItem(
                      title: '交通费',
                      today: today['transFee'].toString(),
                      yestoday: yesterday['transFee'].toString(),
                      total: total['transFee'].toString()),
                  BottomItem(
                      title: '优惠卷',
                      today: today['couponFee'].toString(),
                      yestoday: yesterday['couponFee'].toString(),
                      total: total['couponFee'].toString()),
                ],
              ))
            ],
          ))
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
