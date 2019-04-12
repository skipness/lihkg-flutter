import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

// import 'package:crypto/crypto.dart';

class HttpClient {
  static HttpClient _instance = new HttpClient._internal();
  HttpClient._internal();
  factory HttpClient() => _instance;

  Future<dynamic> get(String url) async {
    // var x = utf8.encode('jeams\$get\$https://lihkg.com/api_v2/thread/634747/page/1?order=reply_time\$\$fc108e0701575efb4a70b69db2779860d02b9d33\$1525597958');
    // var y = sha1.convert(x).toString();
    // print(y);
    final response = await http.get(url);
    if (response.statusCode < 200 || response.statusCode > 400) {
      throw Exception('Fail to get - ${response.statusCode}');
    }
    return json.decode(response.body);
  }

  Future<dynamic> post(String url, dynamic body) async {
    final response = await http.post(url, body: body);
    if (response.statusCode < 200 || response.statusCode > 400) {
      throw Exception('Fail to post - ${response.statusCode}');
    }
    return json.decode(response.body);
  }
}
