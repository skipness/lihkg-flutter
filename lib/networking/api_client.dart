import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:lihkg_flutter/networking/http_client.dart';
import 'package:lihkg_flutter/model/model.dart';

class ApiClient {
  static const String _baseUrl = 'https://lihkg.com/api_v2';
  HttpClient _httpClient = HttpClient();

  Map<String, String> _createHeader(
      String method, String url, String userId, String token) {
    final String digest = sha1
        .convert(utf8.encode(
            'jeams\$$method\$$url\$\$$token\$${DateTime.now().millisecondsSinceEpoch}'))
        .toString();
    return {
      "x-li-user": userId,
      "x-li-digest": digest,
      "x-li-request-time": "${DateTime.now().millisecondsSinceEpoch}"
    };
  }

  Future<SysProps> fetchSysProps() async {
    final response = await _httpClient.get('$_baseUrl/system/property');
    return SysProps.fromJson(response);
  }

  Future<Category> fetchCategory(
    String url,
    String catId,
    int page, {
    int count = 60,
    Map<String, dynamic> query,
  }) async {
    String queryString = '';
    query.forEach((key, value) {
      if (value != null) {
        queryString += '&$key=$value';
      }
    });
    final response = await _httpClient
        .get('$url?cat_id=$catId&page=$page&count=$count&$queryString');
    return Category.fromJson(response);
  }

  Future<Thread> fetchThread({String threadId, int page}) async {
    final response = await _httpClient
        .get('$_baseUrl/thread/$threadId/page/$page?order=reply_time');
    return Thread.fromJson(response);
  }

  Future<Media> fetchMedia({String threadId, bool includeLink}) async {
    final response = await _httpClient.get(
        '$_baseUrl/thread/$threadId/media?include_link=${includeLink ? 1 : 0}');
    return Media.fromJson(response);
  }

  Future<UserProfile> fetchUserProfile({
    String userId,
    int page,
    String query,
  }) async {
    final response = await _httpClient
        .get('$_baseUrl/user/$userId/thread?page=$page&sort=$query');
    return UserProfile.fromJson(response);
  }

  Future<UserProfile> search(
      String query, int page, String sort, String catId) async {
    final response = await _httpClient
        .get('$_baseUrl/thread/search?q=$query&page=$page&count=30&sort=$sort');
    // &cat_id=$catId
    return UserProfile.fromJson(response);
  }

  Future<Login> login(String email, String password) async {
    final Map<String, String> body = {'email': email, 'password': password};
    final response = await _httpClient.post('$_baseUrl/auth/login', body);
    return Login.fromJson(response);
  }

  Future<Profile> fetchProfile(String userId, String token) async {
    final String url = '$_baseUrl/user/$userId/profile';
    final response = await _httpClient.get(url,
        headers: _createHeader('get', url, userId, token));
    return Profile.fromJson(response);
  }
}
