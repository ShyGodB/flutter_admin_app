import 'package:flutter/material.dart';

class UserTechCount extends StatelessWidget {
  final int userCount;
  final int techCount;

  UserTechCount({
    this.userCount, 
    this.techCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: Colors.orange,
              border: Border.all(width: 1.0, color: Colors.orange),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Column(children: <Widget>[
              Text('总用户人数', style: TextStyle(color: Colors.white)),
              Text('$userCount', style: TextStyle(color: Colors.white)),
          ],),
        )
      ),
      SizedBox(width: 20,),
      Expanded(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: Colors.lightGreen,
              border: Border.all(width: 1.0, color: Colors.lightGreen),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Column(children: <Widget>[
              Text('总技师人数', style: TextStyle(color: Colors.white)),
              Text('$techCount', style: TextStyle(color: Colors.white)),
          ],),
        )
      )
    ],);
  }
}