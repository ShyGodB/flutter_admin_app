import 'package:flutter/material.dart';
// import 'package:flutter_echarts/echarts_script.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import '../../api/Index.dart';


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

    _getEchart(week) {
        List times = [];
        List orders = [];
        List turnover = [];
        week.forEach((item) {
            times.add(item['time']);
            orders.add(item['totalOrder']);
            turnover.add(item['turnover']);
        });
        return Echarts(
            option: '''
                {
                    color: ["#65a031", "#fc7c00"],
                    title: {
                        text: "",
                        subtext: "",
                        top: 0
                    },
                    grid: {
                        height: 150,
                        top: 35
                    },
                    tooltip: {
                        trigger: "axis"
                    },
                    legend: {
                        data: ["单量", "交易额"],
                        top: 6
                    },
                    xAxis: {
                        type: 'category',
                        data: $times
                    },
                    yAxis: [
                        {
                            type: "value",
                            name: ""
                        },
                        {
                            type: "value",
                            name: "单量",
                            splitLine: {
                                show: false
                            }
                        }
                    ],
                    series: [{
                        name: '单量',
                        yAxisIndex: 1,
                        type: 'line',
                        data: $orders
                    }, {
                        name: '交易额',
                        type: 'bar',
                        data: $turnover
                    }]
                }
            ''',
        );
    }

    Widget _getUserTech(userCount, techCount) {
        return Row(children: <Widget>[
            Expanded(
                child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        border: Border.all(width: 1.0, color: Colors.orange),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Column(children: <Widget>[
                        Text('总用户人数', style: TextStyle(color: Colors.white)),
                        Text('$userCount', style: TextStyle(color: Colors.white)),
                    ],),
                )
            ),
            Container(width: 20,),
            Expanded(
                child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: Colors.lightGreen,
                        border: Border.all(width: 1.0, color: Colors.lightGreen),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Column(children: <Widget>[
                        Text('总技师人数', style: TextStyle(color: Colors.white)),
                        Text('$techCount', style: TextStyle(color: Colors.white)),
                    ],),
                )
            )
        ],);
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
        return Column(children: <Widget>[
            Container(
                height: 150,
                child: this._getEchart(week)
            ),
            Container(
                padding: EdgeInsets.all(20.0),
                child: this._getUserTech(userCount, techCount)
            ),
            Container(
                padding: EdgeInsets.all(20.0),
                child: this._getBottomWidget(today, yesterday, total)
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
                        child: this._buildWidget(snapshot.data),
                    );
                }
            },
        );
    }
}
