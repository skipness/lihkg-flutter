import 'dart:convert';
import 'package:lihkg_flutter/model/model.dart';

UserProfile userProfileFromJson(String str) {
  final jsonData = json.decode(str);
  return UserProfile.fromJson(jsonData);
}

String userProfileToJson(UserProfile data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class UserProfile {
  int success;
  int serverTime;
  int errorCode;
  String errorMessage;
  UserProfileResponse response;

  UserProfile({
    this.success,
    this.serverTime,
    this.errorCode,
    this.errorMessage,
    this.response,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => new UserProfile(
        success: json["success"],
        serverTime: json["server_time"],
        errorCode: json["error_code"] == null ? null : json["error_code"],
        errorMessage:
            json["error_message"] == null ? null : json["error_message"],
        response: json["response"] == null
            ? null
            : UserProfileResponse.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "server_time": serverTime,
        "error_code": errorCode,
        "error_message": errorMessage,
        "response": response.toJson(),
      };
}

class UserProfileResponse {
  bool isPagination;
  List<Item> items;

  UserProfileResponse({
    this.isPagination,
    this.items,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      new UserProfileResponse(
        isPagination: json["is_pagination"],
        items: new List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "is_pagination": isPagination,
        "items": new List<dynamic>.from(items.map((x) => x.toJson())),
      };
}
