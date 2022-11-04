import 'package:flutter/material.dart';
import '../../../api/index.dart';

import '../order/info.dart';

class CommentOfUserToTechPage extends StatefulWidget {
  final String arguments;
  CommentOfUserToTechPage({Key key, this.arguments = ''}) : super(key: key);

  @override
  _CommentOfUserToTechPageState createState() => _CommentOfUserToTechPageState(arguments: this.arguments);
}

class _CommentOfUserToTechPageState extends State<CommentOfUserToTechPage> {
  String arguments;
  _CommentOfUserToTechPageState({Key key, this.arguments = ''});

  _getData() async {
    var res = await post('/tech/listCommentTo', { "techId": this.arguments });
    return res['data']['list'];
  }

  Widget _buildWidget(data) {
    List<Widget> list = [];
    if (data.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('评论:技师对此用户'),
        ),
        body: Text('暂无数据')
      );
    }
    for (var item in data) {
      var column = Column(
        children: <Widget>[
          ListTile(title: Text("用户姓名：${item['userName'] ?? ''}  ${item['userPhone']}")),
          Divider(),
          ListTile(title: Text("分数：${item['score'] ?? ''}")),
          ListTile(title: Text("内容：${item['content'] ?? ''}")),
          ListTile(title: Text("时间：${item['createdAt'] ?? ''}")),
        ],
      );
      list.add(InkWell(
          child: Card(
            margin: EdgeInsets.all(10.0),
            child: column,
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => OrderInfoPage(
                      arguments: item['orderId'] ?? item['orderId'].toString() ?? '',
                    )));
          }));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('评论:技师对此用户'),
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