import 'package:flutter/material.dart';

import 'package:app_admin_edtuina/pages/Tabs.dart';
import 'package:app_admin_edtuina/pages/tabs/Home.dart';
import 'package:app_admin_edtuina/pages/tabs/Order.dart';
import 'package:app_admin_edtuina/pages/tabs/User.dart';
import 'package:app_admin_edtuina/pages/tabs/Tech.dart';
import 'package:app_admin_edtuina/pages/tabs/App.dart';
import 'package:app_admin_edtuina/views/order/info.dart';

final routes = {
  '/': (context) => Tabs(),
  '/home': (context) => HomePage(),
  '/order': (context) => OrderPage(),
  '/user': (context) => UserPage(),
  '/tech': (context) => TechPage(),
  '/app': (context) => AppPage(),
  '/order/info': (context, {arguments}) => OrderInfoPage(arguments: arguments),
};

dynamic onGenerateRoute = (RouteSettings settings) {
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
