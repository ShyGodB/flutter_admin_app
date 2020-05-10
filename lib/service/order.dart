import 'package:dio/dio.dart';

String apiUrl = 'http://127.0.0.1:3101/api/admin';
// authtoken = "d470c3c5eab81afa2293d504782e5c4d"

dynamic orderAction(String url, data) async {
    String reqUrl = apiUrl + url;
    Response res = await Dio().post(reqUrl, data: data);
    return res.data;
}