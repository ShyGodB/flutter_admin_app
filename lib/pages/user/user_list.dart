import 'package:flutter/material.dart';
import '../../api/index.dart';
import 'components/user_item.dart';

class UserList extends StatefulWidget {
  UserList({Key key}) : super(key: key);

  @override
  _TechListState createState() => _TechListState();
}

class _TechListState extends State<UserList> {
  ScrollController _controller = new ScrollController();
  bool ifLoading = false;
  Map form = { "pageIndex": 1, "pageSize": 10 };
  List data = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixel = _controller.position.pixels;
      if (pixel == maxScroll && !ifLoading) {
        _getMoreData();
      }
    });
  }

  _getData() async {
    var res = await post('/user/list', form);
    this.data.addAll(res['data']['list']);
    return res['data']['list'];
  }

  _getMoreData() async {
    setState(() {
      ifLoading = true;
    });
    this.form['pageIndex']++;
    var res = await post('/user/list', form);
    setState(() {
      ifLoading = false;
      this.data.addAll(res['data']['list']);
    });
    return res['data']['list'];
  }

  Future _refresh() async {
    form['pageIndex'] += 1;
    form['pageSize'] = 10;
    data.clear();
    form = form;
    setState(() {
      ifLoading = true;
    });
    await _getData();
    
    return null;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: this._getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        this.ifLoading = false;
        if (snapshot.hasData == false) {
            return Center(child: CircularProgressIndicator());
        } else {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('用户'),
              actions: <Widget>[
                Icon(Icons.search)
              ],
            ),
            body: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 10),
              color: Color(0xffeeeeee),
              child: Stack(
                children: <Widget>[
                  RefreshIndicator(
                    backgroundColor: Colors.blue,
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return UserItem(
                          userId: this.data[index]['userId'].toString(),
                          realName: this.data[index]['realName'].toString(),
                          nickName: this.data[index]['nickName'].toString(),
                          phone: this.data[index]['phone'].toString(),
                          gender: this.data[index]['gender'].toString(),
                          headImg: this.data[index]['headImg'].toString(),
                          state: this.data[index]['state'].toString(),
                          amount: this.data[index]['amount'].toString(),
                          regTime: this.data[index]['regTime'].toString(),
                        );
                      },
                      controller: _controller,
                    ),
                    onRefresh: this._refresh,
                  ),
                  ifLoading ? Center(child: CircularProgressIndicator()) : Container()
                ],
              )
            )
          );
        }
      },
    );
  }
}
