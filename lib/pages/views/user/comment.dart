import 'package:flutter/material.dart';
import '../../../api/Index.dart';

import '../order/info.dart';

class CommentOfTechToUserPage extends StatefulWidget {
  final String arguments;
  CommentOfTechToUserPage({Key key, this.arguments = ''}) : super(key: key);

  @override
  _CommentOfTechToUserPageState createState() => _CommentOfTechToUserPageState(arguments: this.arguments);
}

class _CommentOfTechToUserPageState extends State<CommentOfTechToUserPage> {
  String arguments;
  _CommentOfTechToUserPageState({Key key, this.arguments = ''});

  _getData() async {
    var res = await post('/user/listCommentTo', { "userId": this.arguments });
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
          ListTile(title: Text("技师姓名：${item['techName'] ?? ''}")),
          Divider(),
          ListTile(title: Text("用户行为：${item['behavior'] ?? ''}")),
          ListTile(title: Text("评论时间：${item['createdAt'] ?? ''}")),
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