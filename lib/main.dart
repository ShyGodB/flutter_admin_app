import 'package:flutter_admin_app/routes/routes.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        textSelectionColor: Colors.red,
        selectedRowColor: Colors.red,
        unselectedWidgetColor: Colors.white,
        scaffoldBackgroundColor: Color(0xffeeeeee),
        backgroundColor: Color(0xffeeeeee),
      ),
      initialRoute: '/',
      onGenerateRoute: onGenerateRoute,
    );
  }
}
