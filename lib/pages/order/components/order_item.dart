import 'package:flutter/material.dart';
import '../../views/order/info.dart';

class OrderItem extends StatelessWidget {
  final String orderId;
  final String techName;
  final String userName;
  final String projectsName;
  final String addTime;
  final String amount;
  final String state;
  final String stateNum;


  OrderItem({
    this.orderId,
    this.techName, 
    this.userName,
    this.projectsName,
    this.addTime,
    this.amount,
    this.state,
    this.stateNum,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          border: Border.all(width: 2.0, color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Column(
          children: <Widget>[
            Row(children: <Widget>[
              Expanded(
                child: Text(
                  "技师姓名  $techName",
                  style: TextStyle(
                    fontSize: 16
                  )
                ),
              ),
              Expanded(
                child: Text("$state", 
                  textAlign: TextAlign.end, 
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 16
                  )
                ),
              ),
            ]),
            Divider(),
            Row(children: <Widget>[Text('用户姓名  $userName', textAlign: TextAlign.left),]),
            Row(children: <Widget>[Text('项目名称  $projectsName'),]),
            Row(children: <Widget>[Text('下单时间  $addTime'),]),
            Row(children: <Widget>[Text('消费金额  $amount'),]),
          ],
        )
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => OrderInfoPage(
              arguments: orderId,
            )
          )
        );
      }
    );
  }
}