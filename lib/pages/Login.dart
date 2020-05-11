import 'package:flutter/material.dart';

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

void _onLogin() async {
    // 提交前，先验证各个表单字段是否合法
  //   if ((_formKey.currentState as FormState).validate()) {
  //     showLoading(context);
  //     User user;
  //     try {
  //       user = await Git(context).login(_unameController.text, _pwdController.text);
  //       // 因为登录页返回后，首页会build，所以我们传false，更新user后不触发更新
  //       Provider.of<UserModel>(context, listen: false).user = user;
  //     } catch (e) {
  //       //登录失败则提示
  //       if (e.response?.statusCode == 401) {
  //         showToast(GmLocalizations.of(context).userNameOrPasswordWrong);
  //       } else {
  //         showToast(e.toString());
  //       }
  //     } finally {
  //       // 隐藏loading框
  //       Navigator.of(context).pop();
  //     }
  //     if (user != null) {
  //       // 返回
  //       Navigator.of(context).pop();
  //     }
  //   }
  // }
}