import 'package:flutter/material.dart';

import '../../../api//Index.dart';

class TimeListPage extends StatefulWidget {
  TimeListPage({Key key}) : super(key: key);

  @override
  _TimeListPageState createState() => _TimeListPageState();
}

class _TimeListPageState extends State<TimeListPage> {
  _getData() async {
    var res = await post('/tech/listAcceptTimes', { "date": "2020-05-02" });
    return res;
  }

  Widget _buildWidget(data) {
    data = data['data']['list'];
    List<Widget> list = [];
    for (var item in data) {
      var column = ListTile(
        title: Text("${item['realName'] ?? ''}  ${item['time']} 小时")
      );
      list.add(InkWell(
          child: Card(
            margin: EdgeInsets.all(10.0),
            child: column,
          ),
          onTap: () {
            print('接单时长');
          }));
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('接单时长'),
        ),
        body: ListView(
          children: list
        )
      );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: this._getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData == false) {
          return Text('');
        } else {
          return this._buildWidget(snapshot.data);
        }
      },
    );
  }
}
