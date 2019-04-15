import 'dart:convert';
import 'package:lihkg_flutter/util/enum_values.dart';

Media mediaFromJson(String str) {
  final jsonData = json.decode(str);
  return Media.fromJson(jsonData);
}

String mediaToJson(Media data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Media {
  int success;
  int serverTime;
  MediaResponse response;

  Media({
    this.success,
    this.serverTime,
    this.response,
  });

  factory Media.fromJson(Map<String, dynamic> json) => new Media(
        success: json["success"],
        serverTime: json["server_time"],
        response: MediaResponse.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "server_time": serverTime,
        "response": response.toJson(),
      };
}

class MediaResponse {
  String threadId;
  String title;
  List<MediaContent> mediaContents;

  MediaResponse({
    this.threadId,
    this.title,
    this.mediaContents,
  });

  factory MediaResponse.fromJson(Map<String, dynamic> json) => new MediaResponse(
        threadId: json["thread_id"],
        title: json["title"],
        mediaContents: new List<MediaContent>.from(
            json["images"].map((x) => MediaContent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "thread_id": threadId,
        "title": title,
        "images": new List<dynamic>.from(mediaContents.map((x) => x.toJson())),
      };
}

class MediaContent {
  int page;
  String msgNum;
  String postId;
  MediaType type;
  String url;
  bool isNoCache;
  String youtubeId;

  MediaContent({
    this.page,
    this.msgNum,
    this.postId,
    this.type,
    this.url,
    this.isNoCache,
    this.youtubeId,
  });

  factory MediaContent.fromJson(Map<String, dynamic> json) => new MediaContent(
        page: json["page"],
        msgNum: json["msg_num"],
        postId: json["post_id"],
        type: mediaTypeValues.map[json["type"]],
        url: json["url"],
        isNoCache: json["is_no_cache"] == null ? null : json["is_no_cache"],
        youtubeId: json["youtube_id"] == null ? null : json["youtube_id"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "msg_num": msgNum,
        "post_id": postId,
        "type": mediaTypeValues.reverse[type],
        "url": url,
        "is_no_cache": isNoCache == null ? null : isNoCache,
        "youtube_id": youtubeId == null ? null : youtubeId,
      };
}

enum MediaType { IMAGE, YOUTUBE }

final mediaTypeValues =
    new EnumValues({"image": MediaType.IMAGE, "youtube": MediaType.YOUTUBE});
