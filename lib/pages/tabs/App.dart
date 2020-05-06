import 'package:flutter/material.dart';

import '../views/user/refund.dart';
import '../views/user/rechage.dart';
import '../views/user/feedback.dart';
import '../views/tech/alarm.dart';
import '../views/tech/avatar.dart';
import '../views/home/review.dart';
import '../views/tech/growth.dart';
import '../views/home/statistic.dart';
import '../views/tech/time.dart';
import '../views/order/add.dart';


class AppPage extends StatefulWidget {
  AppPage({Key key, arguments}) : super(key: key);

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 3, // 子 Widget 的列数
        crossAxisSpacing: 5.0, // 水平子 Widget 之间的距离
        mainAxisSpacing: 5.0, // 垂直子 Widget 之间的距离
        padding: EdgeInsets.all(5.0), // 内边距
        childAspectRatio: 0.8, // 子 Widget 宽高比
        children: <Widget>[
          InkWell(
            child: Container(
              alignment: Alignment.center,
              color: Colors.blue,
              child: Text('退款列表')
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => RefundListPage()));
            },
          ),
          InkWell(
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  color: Colors.blue,
                  child: Text('充值记录')
                )
              ]
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => RechargeListPage()));
            },
          ),
          InkWell(
            child: Container(
              alignment: Alignment.center,
              color: Colors.blue,
              child: Text('技师呼叫')
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AlarmListPage()));
            },
          ),
          InkWell(
            child: Container(
              alignment: Alignment.center,
              color: Colors.blue,
              child: Text('意见反馈')
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FeedbackListPage()));
            },
          ),
          InkWell(
            child: Container(
              alignment: Alignment.center,
              color: Colors.blue,
              child: Text('头像审核')
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AvatarListPage()));
            },
          ),
          InkWell(
            child: Container(
              alignment: Alignment.center,
              color: Colors.blue,
              child: Text('回访记录')
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ReviewListPage()));
            },
          ),
          InkWell(
            child: Container(
              alignment: Alignment.center,
              color: Colors.blue,
              child: Text('成长记录')
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => GrowtListPage()));
            },
          ),
          InkWell(
            child: Container(
              alignment: Alignment.center,
              color: Colors.blue,
              child: Text('业绩统计')
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => StatisticPage()));
            },
          ),
          InkWell(
            child: Container(
              alignment: Alignment.center,
              color: Colors.blue,
              child: Text('接单时长')
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TimeListPage()));
            },
          ),
          InkWell(
            child: Container(
              alignment: Alignment.center,
              color: Colors.blue,
              child: Text('渠道补单')
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddOrderPage()));
            },
          ),
          InkWell(
            child: Container(
              alignment: Alignment.center,
              color: Colors.blue,
              child: Text('退出')
            ),
            onTap: () {
              print('退出');
            },
          ),
        ]
    );
  }
}
