import 'package:flutter/material.dart';

import '../../../api//Index.dart';

class ReviewListPage extends StatefulWidget {
  ReviewListPage({Key key}) : super(key: key);

  @override
  _ReviewListPageState createState() => _ReviewListPageState();
}

class _ReviewListPageState extends State<ReviewListPage> {
    Map form = { "pageIndex": 1, "pageSize": 10 };
    _getData() async {
        var res = await get('/review/list', form);
        return res['data']['list'];
    }

    Widget _buildWidget(data) {
        List<Widget> list = [];
        for (var item in data) {
        var column = Column(
            children: <Widget>[
            ListTile(title: Text("用户姓名：${item['userName'] ?? ''}")),
            ListTile(title: Text("用户手机：${item['userPhone'] ?? ''}")),
            ListTile(title: Text("用户来源：${item['source'] ?? ''}")),
            ListTile(
                title: Text("回访人：${item['reviewUserName'] ?? ''}"),
                subtitle: Text("回访时间：${item['createdAt'] ?? ''} "),
            ),
            ],
        );
        list.add(InkWell(
            child: Card(
                margin: EdgeInsets.all(10.0),
                child: column,
            ),
            onTap: () {
                print('呼叫');
            }));
        }
        return Scaffold(
            appBar: AppBar(
            title: Text('回访记录'),
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
