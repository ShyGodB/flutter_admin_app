import 'package:flutter/material.dart';
// import 'package:flutter_echarts/echarts_script.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import '../../api/Index.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    Map form = { "pageIndex": 1, "pageSize": 10 };

    Map week;
    _getData() async {
        var res = await get('/index/data', form);
        this.week = {
            "day": res['data']['week'].map((item) => item['time']),
            "orders": res['data']['week'].map((item) => item['totalOrder']),
            "pay": res['data']['week'].map((item) => item['turnover']),
        };
        return week;
    }

    _getEchart() {
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
                        data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
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
                        data: [10, 20, 30, 40, 50, 60, 70],
                    }, {
                        name: '交易额',
                        type: 'bar',
                        data: [100, 200, 300, 400, 500, 600, 700]
                    }]
                }
            ''',
        );
    }

    Widget _getUserTech() {
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
                        Text('36384', style: TextStyle(color: Colors.white)),
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
                        Text('376', style: TextStyle(color: Colors.white)),
                    ],),
                )
            )
        ],);
    }

    Widget _getBottomWidget() {
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
                            Text('12312'),
                            Text('今日'),
                        ],)
                    ),
                    Container(height: 30, child: VerticalDivider(color: Colors.grey)),
                    Expanded(
                        child: Column(children: <Widget>[
                            Text('13212'),
                            Text('昨日'),
                        ],)
                    ),
                    Container(height: 30, child: VerticalDivider(color: Colors.grey)),
                    Expanded(
                        child: Column(children: <Widget>[
                            Text('2591万'),
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
                            Text('12312'),
                            Text('今日'),
                        ],)
                    ),
                    Container(height: 30, child: VerticalDivider(color: Colors.grey)),
                    Expanded(
                        child: Column(children: <Widget>[
                            Text('13212'),
                            Text('昨日'),
                        ],)
                    ),
                    Container(height: 30, child: VerticalDivider(color: Colors.grey)),
                    Expanded(
                        child: Column(children: <Widget>[
                            Text('2591万'),
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
                            Text('12312'),
                            Text('今日'),
                        ],)
                    ),
                    Container(height: 30, child: VerticalDivider(color: Colors.grey)),
                    Expanded(
                        child: Column(children: <Widget>[
                            Text('13212'),
                            Text('昨日'),
                        ],)
                    ),
                    Container(height: 30, child: VerticalDivider(color: Colors.grey)),
                    Expanded(
                        child: Column(children: <Widget>[
                            Text('2591万'),
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
                            Text('12312'),
                            Text('今日'),
                        ],)
                    ),
                    Container(height: 30, child: VerticalDivider(color: Colors.grey)),
                    Expanded(
                        child: Column(children: <Widget>[
                            Text('13212'),
                            Text('昨日'),
                        ],)
                    ),
                    Container(height: 30, child: VerticalDivider(color: Colors.grey)),
                    Expanded(
                        child: Column(children: <Widget>[
                            Text('2591万'),
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
                            Text('12312'),
                            Text('今日'),
                        ],)
                    ),
                    Container(height: 30, child: VerticalDivider(color: Colors.grey)),
                    Expanded(
                        child: Column(children: <Widget>[
                            Text('13212'),
                            Text('昨日'),
                        ],)
                    ),
                    Container(height: 30, child: VerticalDivider(color: Colors.grey)),
                    Expanded(
                        child: Column(children: <Widget>[
                            Text('2591万'),
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
                            Text('12312'),
                            Text('今日'),
                        ],)
                    ),
                    Container(height: 30, child: VerticalDivider(color: Colors.grey)),
                    Expanded(
                        child: Column(children: <Widget>[
                            Text('13212'),
                            Text('昨日'),
                        ],)
                    ),
                    Container(height: 30, child: VerticalDivider(color: Colors.grey)),
                    Expanded(
                        child: Column(children: <Widget>[
                            Text('2591万'),
                            Text('累计'),
                        ],)
                    ),
                ],),
            )
        ],);
    }

    Widget _buildWidget() {
        return Column(children: <Widget>[
            Container(
                height: 150,
                child: this._getEchart()
            ),
            Container(
                padding: EdgeInsets.all(20.0),
                child: this._getUserTech()
            ),
            Container(
                padding: EdgeInsets.all(20.0),
                child: this._getBottomWidget()
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
                            child: this._buildWidget(),
                        );
                }
            },
        );
    }
}
