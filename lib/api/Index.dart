import 'package:dio/dio.dart';

String apiUrl = 'http://127.0.0.1:3101/api/admin';

dynamic get(String url) async {
  String reqUrl = apiUrl + url;
  Response res = await Dio().get(reqUrl);
  return res.data['data']['list'];
}

dynamic post(String url, data) async {
  String reqUrl = apiUrl + url;
  Response res = await Dio().post(reqUrl, data: data);
  return res.data;
}
