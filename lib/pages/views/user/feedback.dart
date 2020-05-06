import 'package:flutter/material.dart';

import '../../../api//Index.dart';

class FeedbackListPage extends StatefulWidget {
  FeedbackListPage({Key key}) : super(key: key);

  @override
  _FeedbackListPageState createState() => _FeedbackListPageState();
}

class _FeedbackListPageState extends State<FeedbackListPage> {
  _getData() async {
    var res = await get('/feedback/list');
    return res;
  }

  Widget _buildWidget(data) {
    List<Widget> list = [];
    for (var item in data) {
      var column = Column(
        children: <Widget>[
          ListTile(title: Text("用户姓名：${item['userName'] ?? ''}")),
          ListTile(title: Text("手机号：${item['userPhone'] ?? ''}")),
          ListTile(title: Text("咨询：${item['content'] ?? ''}")),
          ListTile(title: Text("回复：${item['replyContent'] ?? ''}")),
        ],
      );
      list.add(InkWell(
          child: Card(
            margin: EdgeInsets.all(10.0),
            child: column,
          ),
          onTap: () {
            print('意见反馈1');
          }));
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('意见反馈'),
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
