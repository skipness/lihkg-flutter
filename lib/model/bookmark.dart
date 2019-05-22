import 'dart:convert';
import 'package:lihkg_flutter/model/model.dart';

Bookmark bookmarkFromJson(String str) {
  final jsonData = json.decode(str);
  return Bookmark.fromJson(jsonData);
}

String bookmarkToJson(Bookmark data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Bookmark {
  int success;
  int serverTime;
  int errorCode;
  String errorMessage;
  BookmarkResponse response;

  Bookmark({
    this.success,
    this.serverTime,
    this.errorCode,
    this.errorMessage,
    this.response,
  });

  factory Bookmark.fromJson(Map<String, dynamic> json) => Bookmark(
        success: json["success"],
        serverTime: json["server_time"],
        errorCode: json["error_code"] == null ? null : json["error_code"],
        errorMessage:
            json["error_message"] == null ? null : json["error_message"],
        response: json["response"] == null
            ? null
            : BookmarkResponse.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "server_time": serverTime,
        "error_code": errorCode,
        "error_message": errorMessage,
        "response": response.toJson(),
      };
}

class BookmarkResponse {
  Map<String, BookmarkThreadList> bookmarkThreadList;
  Me me;

  BookmarkResponse({this.bookmarkThreadList, this.me});

  factory BookmarkResponse.fromJson(Map<String, dynamic> json) =>
      BookmarkResponse(
        bookmarkThreadList: Map.from(json["bookmark_thread_list"]).map((k, v) =>
            MapEntry<String, BookmarkThreadList>(
                k, BookmarkThreadList.fromJson(v))),
        me: Me.fromJson(json["me"]),
      );

  Map<String, dynamic> toJson() => {
        "bookmark_thread_list": Map.from(bookmarkThreadList)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "me": me.toJson(),
      };
}

class BookmarkThreadList {
  String page;
  dynamic postId;
  String noOfReply;

  BookmarkThreadList({
    this.page,
    this.postId,
    this.noOfReply,
  });

  factory BookmarkThreadList.fromJson(Map<String, dynamic> json) =>
      BookmarkThreadList(
        page: json["page"],
        postId: json["post_id"],
        noOfReply: json["no_of_reply"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "post_id": postId,
        "no_of_reply": noOfReply,
      };
}
