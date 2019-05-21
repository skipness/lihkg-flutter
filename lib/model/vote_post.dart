import 'dart:convert';
import 'package:lihkg_flutter/model/model.dart';

VotePost votePostFromJson(String str) {
  final jsonData = json.decode(str);
  return VotePost.fromJson(jsonData);
}

String votePostToJson(VotePost data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class VotePost {
  int success;
  int serverTime;
  int errorCode;
  String errorMessage;
  VotePostResponse response;

  VotePost({
    this.success,
    this.serverTime,
    this.errorCode,
    this.errorMessage,
    this.response,
  });

  factory VotePost.fromJson(Map<String, dynamic> json) => VotePost(
        success: json["success"],
        serverTime: json["server_time"],
        errorCode: json["error_code"] == null ? null : json["error_code"],
        errorMessage:
            json["error_message"] == null ? null : json["error_message"],
        response: json["response"] == null
            ? null
            : VotePostResponse.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "server_time": serverTime,
        "error_code": errorCode,
        "error_message": errorMessage,
        "response": response.toJson(),
      };
}

class VotePostResponse {
  bool isLike;
  Me me;
  Item thread;

  VotePostResponse({
    this.isLike,
    this.me,
    this.thread,
  });

  factory VotePostResponse.fromJson(Map<String, dynamic> json) =>
      VotePostResponse(
          isLike: json["is_like"],
          me: Me.fromJson(json["me"]),
          thread: Item.fromJson(
            json["thread"],
          ));

  Map<String, dynamic> toJson() => {
        "is_like": isLike,
        "me": me.toJson(),
        "thread": thread.toJson(),
      };
}
