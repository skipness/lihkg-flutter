import 'dart:convert';
import 'package:lihkg_flutter/model/model.dart';

Profile profileFromJson(String str) {
  final jsonData = json.decode(str);
  return Profile.fromJson(jsonData);
}

String profileToJson(Profile data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Profile {
  int success;
  int serverTime;
  int errorCode;
  String errorMessage;
  ProfileResponse response;

  Profile({
    this.success,
    this.serverTime,
    this.errorCode,
    this.errorMessage,
    this.response,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        success: json["success"],
        serverTime: json["server_time"],
        errorCode: json["error_code"] == null ? null : json["error_code"],
        errorMessage:
            json["error_message"] == null ? null : json["error_message"],
        response: ProfileResponse.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "server_time": serverTime,
        "error_code": errorCode,
        "error_message": errorMessage,
        "response": response.toJson(),
      };
}

class ProfileResponse {
  User user;
  Me me;

  ProfileResponse({
    this.user,
    this.me,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      ProfileResponse(
        user: User.fromJson(json["user"]),
        me: Me.fromJson(json["me"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "me": me.toJson(),
      };
}
