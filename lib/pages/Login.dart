import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPagetate createState() => _LoginPagetate();
}


class _LoginPagetate extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/imgs/login-bg.png'),
          fit: BoxFit.fill
        )
      ),
      child: Form(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('登陆', style: TextStyle(color: Colors.white)),
              color: Colors.blue,
              onPressed: () {
                print('点击登陆按钮');
              },
            )
          ],
        ),
      )
    );
  }
}