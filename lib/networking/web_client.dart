import 'dart:async';
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

class WebClient extends http.BaseClient {
  final String userId;
  final String token;
  final String deviceId;
  http.Client _httpClient;

  WebClient(
      {@required this.userId, @required this.token, @required this.deviceId}) {
    _httpClient = http.Client();
  }

  String _getExcetionMessage(http.Response response) {
    return "${response.statusCode} ${response.request.method}";
  }

  @override
  Future<http.Response> get(url, {Map<String, String> headers}) async {
    final response =
        await super.get(url, headers: getHeaders(url, 'get', headers: headers));
    return response.statusCode < 200 || response.statusCode > 400
        ? throw http.ClientException(
            _getExcetionMessage(response), response.request.url)
        : response;
  }

  @override
  Future<http.Response> post(url,
      {Map<String, String> headers, body, Encoding encoding}) async {
    final response = await super.post(url,
        body: body,
        headers: getHeaders(url, 'post', postValue: body, headers: headers),
        encoding: encoding);
    return response.statusCode < 200 || response.statusCode > 400
        ? throw http.ClientException(
            _getExcetionMessage(response), response.request.url)
        : response;
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _httpClient.send(request);
  }

  String digest(dynamic url, String method, String time, String postValue) {
    final String time = "${DateTime.now().millisecondsSinceEpoch}";
    final String digest = sha1
        .convert(utf8.encode(
            "jeams\$$method\$${url.toString().toLowerCase()}\$${(postValue == null || postValue.isEmpty) ? '' : postValue}\$$token\$$time"))
        .toString();
    return digest;
  }

  Map<String, String> getHeaders(String url, String method,
      {String postValue = '', Map<String, String> headers}) {
    if (userId == null || token == null) return {"x-li-device": deviceId};
    final String time = "${DateTime.now().millisecondsSinceEpoch}";
    Map<String, String> header = {
      "x-li-user": userId,
      "x-li-digest": digest(url, method, time, postValue),
      "x-li-request-time": time,
      "x-li-device": deviceId
    };
    if (postValue != null && postValue.isNotEmpty)
      header.addAll({"content-type": "application/x-www-form-urlencoded"});
    return header;
  }
}
