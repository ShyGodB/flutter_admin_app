import 'package:flutter_admin_app/api/index.dart';
import 'package:flutter/material.dart';

class StatisticPage extends StatefulWidget {
  StatisticPage({Key key}) : super(key: key);

  @override
  _StatisticPageState createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  _StatisticPageState({Key key});

  @override
  void initState() {
    super.initState();
    _getData().then((res) {
      return res;
    });
  }

  dynamic _getData() async {
    var res = await post('/index/appStatistics', {
      "type": 1,
      "starTime": 0,
      "endTime": 0
    });
    return res;
  }

  Widget buildUserWidget() {
    return Text('3');
  }

  Widget buildOrderWidget() {
    return Text('2');
  }

  Widget buildTechWidget() {
    return Text('1');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              title: Text('业绩统计'),
              centerTitle: true,
              bottom: TabBar(
                  indicatorColor: Colors.red,
                  indicatorWeight: 3,
                  tabs: <Widget>[
                    Tab(text: '按年'),
                    Tab(text: '按月'),
                    Tab(text: '按天'),
                  ]),
            ),
            body: TabBarView(children: <Widget>[
              this.buildUserWidget(),
              this.buildOrderWidget(),
              this.buildTechWidget()
            ])));
  }
}
