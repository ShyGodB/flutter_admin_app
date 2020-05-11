import 'package:flutter/material.dart';

import '../../api/Index.dart';

import '../views/tech/info.dart';

class TechPage extends StatefulWidget {
  TechPage({Key key}) : super(key: key);

  @override
  _TechPageState createState() => _TechPageState();
}

class _TechPageState extends State<TechPage> {
    Map form = { "pageIndex": 1, "pageSize": 10 };

    _listTech() async {
        var res = await post('/tech/list', form);
        return res['data']['list'];
    }

    Widget _buildTechListWidget(data) {
        List<Widget> list = [];
        for (var item in data) {
            var column = ListTile(
                leading: item['headImg'] == null ?  Text('暂无头像') : CircleAvatar(backgroundImage: NetworkImage(item['headImg']),),
                title: Text("${item['realName']}    ${item['gender']}    ${item['phone']}   ${item['techState']['name']}"),
                subtitle: Text("${item['orders']}    ${item['clicks']}   ${item['state']}")
            );  
            list.add(InkWell(
                child: Card(
                    margin: EdgeInsets.all(10.0),
                    child: column,
                ),
                onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TechInfoPage(
                            arguments: item['techId'].toString(),
                            )));
                }));
        }
        return ListView(children: list);
    }

    @override
    Widget build(BuildContext context) {
        return FutureBuilder(
        future: this._listTech(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData == false) {
            return Text('');
            } else {
            return this._buildTechListWidget(snapshot.data);
            }
        },
        );
    }
}
