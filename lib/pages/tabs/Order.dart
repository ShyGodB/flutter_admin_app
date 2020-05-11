import 'package:flutter/material.dart';
import '../../api/Index.dart';

import '../views/order/info.dart';

class OrderPage extends StatefulWidget {
    OrderPage({Key key}) : super(key: key);

    @override
    _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
    ScrollController _controller = new ScrollController();
    bool ifLoading = false;
    Map form = { "pageIndex": 1, "pageSize": 10 };
    List data = [];

    var min = 0;
    var max = 0;

    @override
    void initState() {
        super.initState();
        _controller.addListener(() {
            var maxScroll = _controller.position.maxScrollExtent;
            var pixel = _controller.position.pixels;
            if (pixel > maxScroll && !ifLoading) {
                setState(() {
                    ifLoading = true;
                });
                this.form['pageIndex']++;
                _getData();
            }
        });
    }

    _getData() async {
        var res = await post('/order/list', form);
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

    List<Widget> _getDropdownButtonItems(state) {
        List<DropdownMenuItem> list = [];
        if (state == 1) list.add(DropdownMenuItem(child: Text('接单'), value: '接单'));
        if (state == 2) list.add(DropdownMenuItem(child: Text('出发'), value: '出发'));
        if (state == 3) list.add(DropdownMenuItem(child: Text('到达'), value: '到达'));
        if (state == 4) list.add(DropdownMenuItem(child: Text('开始'), value: '开始'));
        if (state == 5) list.add(DropdownMenuItem(child: Text('完成'), value: '完成'));
        if (state < 6) list.add(DropdownMenuItem(child: Text('取消'), value: '取消'));
        return list;
    }

    Widget _getItem(context, index) {
        var item = this.data[index];
        return InkWell(
            child: Card(
                color: Colors.white,
                elevation: 6.0,
                margin: EdgeInsets.all(10.0),
                child: Column(
                    children: <Widget>[
                        Row(
                            children: <Widget>[
                                Expanded(
                                    child: ListTile(
                                        title: Text("技师姓名  ${item['techName']}"),
                                    )
                                ),
                                Expanded(
                                    child: ListTile(
                                        title: Text("${item['state']}", textAlign: TextAlign.right,)
                                    )
                                ),
                                item['stateNum'] < 6 ? DropdownButton(
                                    hint: Text('操作'),
                                    items: this._getDropdownButtonItems(item['stateNum']),
                                    iconSize: 48.0,
                                    style: TextStyle(
                                        color: Colors.green,
                                    ),
                                    elevation: 24,
                                    onChanged: (value) {
                                        // if (value == '接单') {
                                        //     orderAction('/order/accept', { "orderId": item['orderId'] });
                                        //     print('确定帮助技师接单?');
                                        // } else if (value == '出发') {
                                        //     orderAction('/order/leave', { "orderId": item['orderId'] });
                                        //     print('确定帮助技师出发?');
                                        // } else if (value == '到达') {
                                        //     orderAction('/order/arrive', { "orderId": item['orderId'] });
                                        //     print('确定帮助技师到达?');
                                        // } else if (value == '开始') {
                                        //     orderAction('/order/start', { "orderId": item['orderId'] });
                                        //     print('确定开始?');
                                        // } else if (value == '完成') {
                                        //     orderAction('/order/end', { "orderId": item['orderId'] });
                                        //     print('确定服务完成?');
                                        // } else if (value == '取消') {
                                        //     orderAction('/order/cancel', { "orderId": item['orderId'] });
                                        //     print('确定取消此订单?');
                                        // }
                                    },
                                ) : Container()
                            ],
                        ),
                        // Divider(),
                        ListTile(
                            title: Text("项目名称  ${item['projectsName']}"),
                            subtitle: Text("${item['addTime']}         ¥ ${item['payPrice']}"),
                        ),
                    ],
                )
            ),
            onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OrderInfoPage(
                        arguments: item['orderId'] ?? item['orderId'].toString() ?? '',
                        )));
            }
        );
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
                    this.data.addAll(snapshot.data);
                    return Stack(
                        children: <Widget>[
                            RefreshIndicator(
                                backgroundColor: Colors.blue,
                                child: ListView.builder(
                                    itemCount: data.length,
                                    itemBuilder: (context, index) {
                                        return this._getItem(context, index);
                                    },
                                    controller: _controller,
                                ),
                                onRefresh: this._refresh,
                            ),
                            ifLoading ? Center(child: CircularProgressIndicator()) : Container()
                        ],
                    );
                }
            },
        );
    }
}
