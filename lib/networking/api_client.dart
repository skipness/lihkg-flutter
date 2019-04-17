import 'dart:async';
import 'dart:convert';
import 'package:lihkg_flutter/networking/web_client.dart';
import 'package:lihkg_flutter/model/model.dart';

class ApiClient {
  final String _baseUrl = 'https://lihkg.com/api_v2';
  WebClient _webClient;

  ApiClient({String userId, String token}) {
    _webClient = WebClient(userId: userId, token: token);
  }

  Future<SysProps> fetchSysProps() async {
    final response = await _webClient.get('$_baseUrl/system/property');
    return SysProps.fromJson(json.decode(response.body));
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
    final response =
        await _webClient.get('$url?page=$page&count=$count$queryString');
    return Category.fromJson(json.decode(response.body));
  }

  Future<Thread> fetchThread({String threadId, int page}) async {
    final response = await _webClient
        .get('$_baseUrl/thread/$threadId/page/$page?order=reply_time');
    return Thread.fromJson(json.decode(response.body));
  }

  Future<Media> fetchMedia({String threadId, bool includeLink}) async {
    final response = await _webClient.get(
        '$_baseUrl/thread/$threadId/media?include_link=${includeLink ? 1 : 0}');
    return Media.fromJson(json.decode(response.body));
  }

  Future<UserProfile> fetchUserProfile({
    String userId,
    int page,
    String sortBy,
  }) async {
    final response = await _webClient
        .get('$_baseUrl/user/$userId/thread?page=$page&sort=$sortBy');
    return UserProfile.fromJson(json.decode(response.body));
  }

  Future<UserProfile> search(
      String query, int page, String sort, String catId) async {
    final response = await _webClient
        .get('$_baseUrl/thread/search?q=$query&page=$page&count=30&sort=$sort');
    // &cat_id=$catId
    return UserProfile.fromJson(json.decode(response.body));
  }

  Future<Login> login(String email, String password) async {
    final Map<String, String> body = {'email': email, 'password': password};
    final response = await _webClient.post('$_baseUrl/auth/login', body: body);
    return Login.fromJson(json.decode(response.body));
  }

  Future<Profile> fetchProfile(String userId) async {
    final response = await _webClient.get('$_baseUrl/user/$userId/profile');
    return Profile.fromJson(json.decode(response.body));
  }
}
