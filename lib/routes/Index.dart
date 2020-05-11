import 'package:flutter/material.dart';

import 'package:flutter_admin_app/pages/tabs.dart';
import 'package:flutter_admin_app/pages/tabs/Home.dart';
import 'package:flutter_admin_app/pages/tabs/Order.dart';
import 'package:flutter_admin_app/pages/tabs/User.dart';
import 'package:flutter_admin_app/pages/tabs/Tech.dart';
import 'package:flutter_admin_app/pages/tabs/App.dart';
import 'package:flutter_admin_app/pages/Login.dart';

final routes = {
  '/': (context) => Tabs(),
  '/home': (context) => HomePage(),
  '/order': (context) => OrderPage(),
  '/user': (context) => UserPage(),
  '/tech': (context) => TechPage(),
  '/app': (context) => AppPage(),
  '/login': (context) => LoginPage(),
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
