import 'package:flutter/material.dart';

// import './Test.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    var count = 0;
    @override
    Widget build(BuildContext context) {
        return Column(
            children: <Widget>[
                Text('number is ${this.count}'),
                RaisedButton(
                    child: Text('点击++'),
                    onPressed: () {
                        setState(() {
                            this.count++;
                        });
                        // Navigator.of(context).push(MaterialPageRoute(
                        //         builder: (context) => TestPage()));
                    },
                )
            ]
        );
    }
}
