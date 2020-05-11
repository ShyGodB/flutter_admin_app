import 'package:flutter/material.dart';
import 'package:flutter_admin_app/api/Index.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPagetate createState() => _LoginPagetate();
}


class _LoginPagetate extends State<LoginPage> {
  String phone;
  String password;
  GlobalKey<FormState> _loginFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login-bg.png'),
            fit: BoxFit.fill,
          ),
        ),
        padding: EdgeInsets.all(10.0),
        child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.people),
                  labelText: '手机号',
                  hintText: '请输入手机号',
                ),
                onSaved: (value) {
                  print('手机号');
                  phone = value;
                },
                validator: (value) {
                  return value == null || value.length != 11 ? '请输入正确的手机号' : null;
                },
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  icon: Icon(Icons.lock),
                  labelText: '密码',
                  hintText: '请输入密码',
                ),
                onSaved: (value) {
                  print('密码');
                  password = value;
                },
                validator: (value) {
                  return value == null || value.length < 6 ? '密码不应少于6位' : null;
                },
              ),
              SizedBox(height: 20,),
              Container(
                width: double.infinity,
                height: 44,
                child: RaisedButton(
                  child: Text('登陆', style: TextStyle(color: Colors.white)),
                  color: Colors.blue,
                  onPressed: () {
                    _loginFormKey.currentState.save();
                    _loginFormKey.currentState.validate();
                    print('phone: $phone    password: $password');
                    _onLogin(phone, password);
                  },
                )
              )
            ],
          ),
        )
      )
    );
  }
}

void _onLogin(String phone, String password) async {
  Map form = { "phone": phone, "password": password };
  final res = await post('/index/appLogin', form);
  if (res['success']) {
    print('登陆成功');
  } else {
    print('登陆失败');
  }
}