import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpClient {
  static HttpClient _instance = new HttpClient._internal();
  HttpClient._internal();
  factory HttpClient() => _instance;

  Future<dynamic> get(String url, {Map<String, String> headers}) async {
    final response = await http.get(url, headers: headers);
    if (response.statusCode < 200 || response.statusCode > 400) {
      throw Exception('Fail to get - ${response.statusCode}');
    }
    return json.decode(response.body);
  }

  Future<dynamic> post(String url, dynamic body,
      {Map<String, String> headers}) async {
    final response = await http.post(url, body: body, headers: headers);
    if (response.statusCode < 200 || response.statusCode > 400) {
      throw Exception('Fail to post - ${response.statusCode}');
    }
    return json.decode(response.body);
  }
}
