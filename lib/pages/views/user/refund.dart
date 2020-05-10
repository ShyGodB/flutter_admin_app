import 'package:flutter/material.dart';

import '../../../api//Index.dart';

class RefundListPage extends StatefulWidget {
  RefundListPage({Key key}) : super(key: key);

  @override
  _RefundListPageState createState() => _RefundListPageState();
}

class _RefundListPageState extends State<RefundListPage> {
    Map form = { "pageIndex": 1, "pageSize": 10 };

    _listRefund() async {
        var res = await get('/refund/list', form);
        return res['data']['list'];
    }

    Widget _buildWidget(data) {
        List<Widget> list = [];
        for (var item in data) {
            var column = Column(
                children: <Widget>[
                ListTile(title: Text("用户姓名：${item['userName'] ?? ''}")),
                ListTile(title: Text("手机号：${item['userPhone'] ?? ''}")),
                ListTile(title: Text("退款金额：${item['amount'] ?? ''}")),
                ListTile(title: Text("退款状态：${item['state'] ?? ''}")),
                ],
            );
            list.add(InkWell(
                child: Card(
                    margin: EdgeInsets.all(10.0),
                    child: column,
                ),
                onTap: () {
                    print('退款编号');
                }));
        }
        return Scaffold(
            appBar: AppBar(
            title: Text('退款列表'),
            ),
            body: ListView(
            children: list
            )
        );
    }

    @override
    Widget build(BuildContext context) {
        return FutureBuilder(
            future: this._listRefund(),
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
