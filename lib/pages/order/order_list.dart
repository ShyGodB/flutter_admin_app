import 'package:flutter/material.dart';
import '../../api/Index.dart';
import 'components/order_item.dart';


class OrderList extends StatefulWidget {
  OrderList({Key key}) : super(key: key);

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('订单'),
        actions: <Widget>[
          Icon(Icons.search),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 2,
          tabs: <Widget>[
            Text('当前订单'),
            Text('历史订单'),
            Text('超时订单'),
            Text('拒单订单'),
          ],)
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Orders(orderType: 'current'),
          Orders(orderType: 'history'),
          Orders(orderType: 'overTime'),
          Orders(orderType: 'refuse'),
        ],
      ),
    );
  }
}



class Orders extends StatefulWidget {
  final String orderType;
  Orders({Key key, this.orderType = 'current'}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState(orderType: orderType);
}

class _OrdersState extends State<Orders> {
  String orderType;
  
  _OrdersState({
    this.orderType
  });

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
    this.form['orderType'] = orderType;
    var res = await post('/order/list', form);
    this.data.addAll(res['data']['list']);
    return res['data']['list'];
  }

  _getMoreData() async {
    setState(() {
      ifLoading = true;
    });
    this.form['pageIndex']++;
    this.form['orderType'] = orderType;
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
    this.form['orderType'] = orderType;
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