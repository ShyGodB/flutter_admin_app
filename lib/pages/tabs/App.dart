import 'package:flutter/material.dart';

class AppPage extends StatefulWidget {
  AppPage({Key key, arguments}) : super(key: key);

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  List<Widget> _buildGridView() {
    List<Widget> list = [];
    for (int i = 0; i < 20; i++) {
      list.add(Container(
          alignment: Alignment.center,
          color: Colors.blue,
          child: Text('第$i条数据')));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 3, // 子 Widget 的列数
        crossAxisSpacing: 10.0, // 水平子 Widget 之间的距离
        mainAxisSpacing: 10.0, // 垂直子 Widget 之间的距离
        padding: EdgeInsets.all(10.0), // 内边距
        childAspectRatio: 0.7, // 子 Widget 宽高比
        children: this._buildGridView());
  }
}
