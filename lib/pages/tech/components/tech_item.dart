import 'package:flutter/material.dart';
import '../../views/tech/info.dart';

class TechItem extends StatelessWidget {
  final String techId;
  final String realName;
  final String phone;
  final String gender;
  final String acceptState;
  final String age;
  final String headImg;
  final String attribution;
  final String orders;
  final String clicks;
  final String state;
  final String amount;

  TechItem({
    @required this.techId,
    this.realName = '',
    this.phone = '',
    this.gender = '女',
    this.acceptState = '服务中',
    this.age = '0 岁',
    this.headImg,
    this.attribution = '深圳',
    this.orders = '0',
    this.clicks = '0',
    this.state = '正常',
    this.amount = '0'
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
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  width: 60,
                  height: 60,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(headImg),
                  ),
                ),
                SizedBox(height: 8),
                Text('深圳', textAlign: TextAlign.center,)
              ],
            ),
            Divider(),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(children: <Widget>[Text('$realName  $gender  $acceptState')]),
                          Row(children: <Widget>[Text('$age')]),
                          Row(children: <Widget>[Text('$phone')]),
                        ],
                      ),
                      Center(
                        child: FlatButton(
                          // icon: Icon(Icons.edit),
                          child: Text('操作'),
                          onPressed: () {
                            print('操作');
                          },
                        ),
                      )
                    ],
                  ), 
                  Divider(),
                  Row(
                    children: <Widget>[
                      Text('单量:  $orders'),
                      SizedBox(width: 12,),
                      Text('点击量:  $clicks'),
                      SizedBox(width: 30,),
                      Text('状态:  $state')
                    ],
                  )
                ],
              ),
            )
          ],
        )
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TechInfo(
              arguments: techId,
            )
          )
        );
      }
    );
  }
}