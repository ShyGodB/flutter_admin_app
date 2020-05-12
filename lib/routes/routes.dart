import 'package:flutter/material.dart';
import 'package:flutter_admin_app/pages/tabs.dart';
import 'package:flutter_admin_app/pages/Login.dart';


final routes = {
  '/': (context) => Tabs(),
  '/login': (context) => Login(),
};

dynamic onGenerateRoute = (RouteSettings settings) {
  // 登陆验证
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguements: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  } else {
    final Route route =
        MaterialPageRoute(builder: (context) => pageContentBuilder(context));
    return route;
  }
};
