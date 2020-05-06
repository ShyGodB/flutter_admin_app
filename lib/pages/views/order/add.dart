import 'package:flutter_admin_app/api/Index.dart';
import 'package:flutter/material.dart';

class AddOrderPage extends StatefulWidget {
  final String arguments;
  AddOrderPage({Key key, this.arguments = ''}) : super(key: key);

  @override
  _AddOrderPageState createState() =>
      _AddOrderPageState(arguments: this.arguments);
}

class _AddOrderPageState extends State<AddOrderPage> {
  String arguments;
  _AddOrderPageState({Key key, this.arguments = ''});

  Map user;
  @override
  void initState() {
    super.initState();
    if (this.arguments != '') {
      _getOrder().then((res) {
        setState(() {
          user = res;
        });
      });
    }
  }

  dynamic _getOrder() async {
    var res = await post('/user/info', {"userId": this.arguments});
    return res['data'];
  }

  Widget _buildWidget() {
    return Text('123');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('补单'),
        ),
        body: this._buildWidget()
      )
    );
  }
}
