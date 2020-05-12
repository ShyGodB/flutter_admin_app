import 'package:flutter/material.dart';
import '../../api/Index.dart';
import 'components/order_item.dart';

class OrderList extends StatefulWidget {
  OrderList({Key key}) : super(key: key);

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
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
    var res = await post('/order/list', form);
    this.data.addAll(res['data']['list']);
    return res['data']['list'];
  }

  _getMoreData() async {
    setState(() {
      ifLoading = true;
    });
    this.form['pageIndex']++;
    var res = await post('/order/list', form);
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
          return Container(
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
                      return OrderItem(
                        orderId: this.data[index]['orderId'].toString(),
                        techName: this.data[index]['techName'].toString(),
                        userName: this.data[index]['userName'].toString(),
                        projectsName: this.data[index]['projectsName'].toString(),
                        addTime: this.data[index]['addTime'].toString(),
                        amount: this.data[index]['payPrice'].toString(),
                        state: this.data[index]['state'].toString(),
                        stateNum: this.data[index]['stateNum'].toString(),
                      );
                    },
                    controller: _controller,
                  ),
                  onRefresh: this._refresh,
                ),
                ifLoading ? Center(child: CircularProgressIndicator()) : Container()
              ],
            )
          );
        }
      },
    );
  }
}
