import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

class WebClient extends http.BaseClient {
  final String userId;
  final String token;
  http.Client _httpClient;

  WebClient({this.userId, this.token}) {
    _httpClient = http.Client();
  }

  String _getExcetionMessage(http.Response response) {
    return "${response.statusCode} ${response.request.method}";
  }

  @override
  Future<http.Response> get(url, {Map<String, String> headers}) async {
    final response = await super.get(url, headers: headers);
    return response.statusCode < 200 || response.statusCode > 400
        ? throw http.ClientException(
            _getExcetionMessage(response), response.request.url)
        : response;
  }

  @override
  Future<http.Response> post(url,
      {Map<String, String> headers, body, Encoding encoding}) async {
    final response =
        await super.post(url, body: body, headers: headers, encoding: encoding);
    return response.statusCode < 200 || response.statusCode > 400
        ? throw http.ClientException(
            _getExcetionMessage(response), response.request.url)
        : response;
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    if (userId == null || token == null) return _httpClient.send(request);
    final String time = "${DateTime.now().millisecondsSinceEpoch}";
    final String digest = sha1
        .convert(utf8.encode(
            "jeams\$${request.method.toLowerCase()}\$${request.url}\$\$$token\$$time"))
        .toString();
    request.headers["x-li-user"] = userId;
    request.headers["x-li-digest"] = digest;
    request.headers["x-li-request-time"] = time;
    return _httpClient.send(request);
  }
}
