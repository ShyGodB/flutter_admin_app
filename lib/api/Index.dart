import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

String apiUrl = 'http://10.0.2.2:3101/api/admin'; // android
// String apiUrl = 'http://127.0.0.1:3101/api/admin'; // ios 
// authtoken = "d470c3c5eab81afa2293d504782e5c4d"

dynamic get(String url, data) async {
  String reqUrl = apiUrl + url;
  Response res = await Dio().get(reqUrl, queryParameters: data);
  return res.data;
}

dynamic post(String url, data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String authtoken = prefs.getString('authtoken');
  String reqUrl = apiUrl + url;
  Map<String, dynamic> httpHeaders = {
    'Accept': 'application/json,*/*',
    'Content-Type': 'application/json',
    'authtoken': authtoken
  };
  Response res = await Dio().post(reqUrl, data: data, options: Options(headers: httpHeaders));
  return res.data;
}