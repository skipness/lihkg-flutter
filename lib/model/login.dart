import 'dart:convert';
import 'package:lihkg_flutter/model/model.dart';

Login loginFromJson(String str) {
  final jsonData = json.decode(str);
  return Login.fromJson(jsonData);
}

String loginToJson(Login data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Login {
  int success;
  int serverTime;
  int errorCode;
  String errorMessage;
  LoginResponse response;

  Login({
    this.success,
    this.serverTime,
    this.errorCode,
    this.errorMessage,
    this.response,
  });

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        success: json["success"],
        serverTime: json["server_time"],
        errorCode: json["error_code"] == null ? null : json["error_code"],
        errorMessage:
            json["error_message"] == null ? null : json["error_message"],
        response: json["response"] == null
            ? null
            : LoginResponse.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "server_time": serverTime,
        "error_code": errorCode,
        "error_message": errorMessage,
        "response": response.toJson(),
      };
}

class LoginResponse {
  String token;
  List<dynamic> keywordFilterList;
  List<String> categoryOrder;
  Me user;
  List<FixedCategoryList> fixedCategoryList;
  Me me;

  LoginResponse({
    this.token,
    this.keywordFilterList,
    this.categoryOrder,
    this.user,
    this.fixedCategoryList,
    this.me,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        token: json["token"],
        keywordFilterList:
            List<dynamic>.from(json["keyword_filter_list"].map((x) => x)),
        categoryOrder: List<String>.from(json["category_order"].map((x) => x)),
        user: Me.fromJson(json["user"]),
        fixedCategoryList: List<FixedCategoryList>.from(
            json["fixed_category_list"]
                .map((x) => FixedCategoryList.fromJson(x))),
        me: Me.fromJson(json["me"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "keyword_filter_list":
            List<dynamic>.from(keywordFilterList.map((x) => x)),
        "category_order": List<dynamic>.from(categoryOrder.map((x) => x)),
        "user": user.toJson(),
        "fixed_category_list":
            List<dynamic>.from(fixedCategoryList.map((x) => x.toJson())),
        "me": me.toJson(),
      };
}
