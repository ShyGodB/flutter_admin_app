import 'package:flutter/material.dart';
import '../../../api/Index.dart';

class UserReviewPage extends StatefulWidget {
  final String arguments;
  UserReviewPage({Key key, this.arguments = ''}) : super(key: key);

  @override
  _UserReviewPageState createState() => _UserReviewPageState(arguments: this.arguments);
}

class _UserReviewPageState extends State<UserReviewPage> {
  String arguments;
  _UserReviewPageState({Key key, this.arguments = ''});

  Map form = { "pageIndex": 1, "pageSize": 10 };

  _getData() async {
    if (arguments != '') form['userId'] = arguments;
    var res = await post('/review/list', form);
    return res['data']['list'];
  }

  Widget _buildWidget(data) {
    List<Widget> list = [];
    if (data.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('回访记录'),
        ),
        body: Text('暂无数据')
      );
    }
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
            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (context) => OrderInfoPage(
            //           arguments: item['orderId'] ?? item['orderId'].toString() ?? '',
            //         )));
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