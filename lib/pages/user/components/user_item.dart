import 'package:flutter/material.dart';
import '../../views/user/info.dart';

class UserItem extends StatelessWidget {
  final String userId;
  final String realName;
  final String nickName;
  final String phone;
  final String gender;
  final String headImg;
  final String state;
  final String amount;
  final String regTime;

  UserItem({
    @required this.userId,
    this.realName = '',
    this.nickName = '',
    this.phone = '',
    this.gender = '男',
    this.headImg,
    this.state = '正常',
    this.amount = '0',
    this.regTime = ''
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
                          Row(children: <Widget>[Text('${realName ?? nickName}  $gender')]),
                          Row(children: <Widget>[Text('$phone')]),
                          Row(children: <Widget>[Text('$amount')]),
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
                      Text('注册时间:  $regTime'),
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
            builder: (context) => UserInfo(
              arguments: userId,
            )
          )
        );
      }
    );
  }
}