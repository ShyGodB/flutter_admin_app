import 'package:flutter/material.dart';

class BottomItem extends StatelessWidget {
  final String title;
  final String today;
  final String yestoday;
  final String total;

  BottomItem({
    this.title, 
    this.today,
    this.yestoday, 
    this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        border: Border.all(width: 2.0, color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Row(children: <Widget>[
          Expanded(
              child: Column(children: <Widget>[
                  Icon(Icons.money_off),
                  Text('$title'),
              ],)
          ),
          Container(height: 30, child: VerticalDivider(color: Colors.grey)),
          Expanded(
              child: Column(children: <Widget>[
                  Text("$today"),
                  Text('今日'),
              ],)
          ),
          Container(height: 30, child: VerticalDivider(color: Colors.grey)),
          Expanded(
              child: Column(children: <Widget>[
                  Text("$yestoday"),
                  Text('昨日'),
              ],)
          ),
          Container(height: 30, child: VerticalDivider(color: Colors.grey)),
          Expanded(
              child: Column(children: <Widget>[
                  Text("$total"),
                  Text('累计'),
              ],)
          ),
      ],),
    );
  }
}