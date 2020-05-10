import 'package:flutter/material.dart';
// import '../../api/Index.dart';

class TestPage extends StatefulWidget {
    TestPage({Key key}) : super(key: key);

    @override
    _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
    List<String> data = List<String>();
    ScrollController controller;
    bool ifLoading = false;
    Map form = { "pageIndex": 1, "pageSize": 10 };
    List<Widget> list = [];

    @override
    void initState() {
        super.initState();
        controller = new ScrollController();
        List.generate(30, (i) => data.add("item is $i"));
    }

    @override
    Widget build(BuildContext context) {
        return Stack(children: <Widget>[
            RefreshIndicator(
                backgroundColor: Colors.blue,
                onRefresh: () {
                    return Future.delayed(Duration(seconds: 1), () {
                        data.insert(0, 'add the item');
                        setState(() {
                        data = data;
                        });
                    });
                },
                child: NotificationListener(
                    onNotification: (scroll) {
                        if (!ifLoading && scroll.metrics.maxScrollExtent <= controller.offset + 200) {
                            setState(() {
                                this.ifLoading = true;
                            });
                            List.generate(30, (i) {
                                data.add("item is ${data.length + i}");
                            });
                            Future.delayed(Duration(seconds: 2), () {
                                setState(() {
                                    data = data;
                                    ifLoading = false;
                                });
                            });
                        }
                        return;
                    },
                    child: ListView.builder(
                        controller: controller,
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                            return Container(
                                height: 80.0,
                                child: Text(data[index])
                            );
                        }
                    ),
                )
            ),
            ifLoading ? Center(child: CircularProgressIndicator()) : Container()
        ]);
    }
}
