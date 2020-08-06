import 'package:flutter/material.dart';
import 'package:flutter_admin_app/api/Index.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_admin_app/components/toast.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _Logintate createState() => _Logintate();
}


class _Logintate extends State<Login> {
  String phone;
  String password;
  GlobalKey<FormState> _loginFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white54,
          // image: DecorationImage(
          //   image: AssetImage('assets/images/login-bg.png'),
          //   fit: BoxFit.fill,
          // ),
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
                  onPressed: () async {
                    _loginFormKey.currentState.save();
                    _loginFormKey.currentState.validate();
                    bool result = await _onLogin(phone, password);
                    if (result) {
                      Navigator.pushNamed(context, '/');
                    } else {
                      print('登陆失败');
                    }
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

Future _onLogin(String phone, String password) async {
  Map form = { "phone": phone, "password": password };
  final res = await post('/index/appLogin', form);
  if (res['success'] == true) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map userinfo = res['data'];
    String authtoken = res['authtoken'];
    await prefs.setString('userinfo', userinfo.toString());
    await prefs.setString('authtoken', authtoken);
    return true;
  } else {
    print('登陆失败');
    return false;
  }
}