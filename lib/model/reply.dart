import 'dart:convert';
import 'package:lihkg_flutter/model/model.dart';

Reply replyFromJson(String str) {
  final jsonData = json.decode(str);
  return Reply.fromJson(jsonData);
}

String replyToJson(VotePost data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Reply {
  int success;
  int serverTime;
  int errorCode;
  String errorMessage;
  ReplyResponse response;

  Reply({
    this.success,
    this.serverTime,
    this.errorCode,
    this.errorMessage,
    this.response,
  });

  factory Reply.fromJson(Map<String, dynamic> json) => Reply(
        success: json["success"],
        serverTime: json["server_time"],
        errorCode: json["error_code"] == null ? null : json["error_code"],
        errorMessage:
            json["error_message"] == null ? null : json["error_message"],
        response: json["response"] == null
            ? null
            : ReplyResponse.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "server_time": serverTime,
        "error_code": errorCode,
        "error_message": errorMessage,
        "response": response.toJson(),
      };
}

class ReplyResponse {
  int noOfReply;
  String threadId;
  int totalPage;
  Me me;

  ReplyResponse({
    this.noOfReply,
    this.threadId,
    this.totalPage,
    this.me,
  });

  factory ReplyResponse.fromJson(Map<String, dynamic> json) => ReplyResponse(
        noOfReply: json["no_of_reply"],
        threadId: json["thread_id"],
        totalPage: json["total_page"],
        me: Me.fromJson(json["me"]),
      );

  Map<String, dynamic> toJson() => {
        "no_of_reply": noOfReply,
        "thread_id": threadId,
        "totalPage": totalPage,
        "me": me.toJson(),
      };
}
