import 'package:flutter/material.dart';
import '../../../api/Index.dart';

class UserCouponPage extends StatefulWidget {
  final String arguments;
  UserCouponPage({Key key, this.arguments = ''}) : super(key: key);

  @override
  _UserCouponPageState createState() => _UserCouponPageState(arguments: this.arguments);
}

class _UserCouponPageState extends State<UserCouponPage> {
  String arguments;
  _UserCouponPageState({Key key, this.arguments = ''});

  _getData() async {
    var res = await post('/coupon/listUserCoupon', { "userId": this.arguments });
    return res['data']['list'];
  }

  Widget _buildWidget(data) {
    List<Widget> list = [];
    if (data.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('优惠卷'),
        ),
        body: Text('暂无数据')
      );
    }
    for (var item in data) {
      var column = Column(
        children: <Widget>[
          ListTile(title: Text("名字：${item['name'] ?? ''}")),
          Divider(),
          ListTile(title: Text("金额：${item['amount'] ?? ''}")),
          ListTile(title: Text("状态：${item['state'] ?? ''}")),
          ListTile(title: Text("过期时间：${item['endTime'] ?? ''}")),
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
        title: Text('优惠卷'),
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