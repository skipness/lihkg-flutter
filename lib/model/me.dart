import 'package:lihkg_flutter/model/model.dart';

class Me {
  String userId;
  String nickname;
  String email;
  String level;
  Gender gender;
  String status;
  int plusExpiryTime;
  int createTime;
  int lastLoginTime;
  LevelName levelName;
  bool isDisappear;
  bool isPlusUser;
  MetaData metaData;

  Me({
    this.userId,
    this.nickname,
    this.email,
    this.level,
    this.gender,
    this.status,
    this.plusExpiryTime,
    this.createTime,
    this.lastLoginTime,
    this.levelName,
    this.isDisappear,
    this.isPlusUser,
    this.metaData,
  });

  factory Me.fromJson(Map<String, dynamic> json) => Me(
        userId: json["user_id"],
        nickname: json["nickname"],
        email: json["email"],
        level: json["level"],
        gender: genderValues.map[json["gender"]],
        status: json["status"],
        plusExpiryTime: json["plus_expiry_time"],
        createTime: json["create_time"],
        lastLoginTime: json["last_login_time"],
        levelName: levelNameValues.map[json["level_name"]],
        isDisappear: json["is_disappear"],
        isPlusUser: json["is_plus_user"],
        metaData: MetaData.fromJson(json["meta_data"]),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "nickname": nickname,
        "email": email,
        "level": level,
        "gender": genderValues.reverse[gender],
        "status": status,
        "plus_expiry_time": plusExpiryTime,
        "create_time": createTime,
        "last_login_time": lastLoginTime,
        "level_name": levelNameValues.reverse[levelName],
        "is_disappear": isDisappear,
        "is_plus_user": isPlusUser,
        "meta_data": metaData.toJson(),
      };
}

class MetaData {
  List<dynamic> customCat;
  String keywordFilter;
  int loginCount;
  int lastReadNotifyTime;
  int notifyCount;
  PushSetting pushSetting;

  MetaData({
    this.customCat,
    this.keywordFilter,
    this.loginCount,
    this.lastReadNotifyTime,
    this.notifyCount,
    this.pushSetting,
  });

  factory MetaData.fromJson(Map<String, dynamic> json) => MetaData(
        customCat: List<dynamic>.from(json["custom_cat"].map((x) => x)),
        keywordFilter: json["keyword_filter"],
        loginCount: json["login_count"],
        lastReadNotifyTime: json["last_read_notify_time"],
        notifyCount: json["notify_count"],
        pushSetting: PushSetting.fromJson(json["push_setting"]),
      );

  Map<String, dynamic> toJson() => {
        "custom_cat": List<dynamic>.from(customCat.map((x) => x)),
        "keyword_filter": keywordFilter,
        "login_count": loginCount,
        "last_read_notify_time": lastReadNotifyTime,
        "notify_count": notifyCount,
        "push_setting": pushSetting.toJson(),
      };
}

class PushSetting {
  bool all;
  bool showPreview;
  bool newReply;
  bool quote;
  bool followingNewThread;

  PushSetting({
    this.all,
    this.showPreview,
    this.newReply,
    this.quote,
    this.followingNewThread,
  });

  factory PushSetting.fromJson(Map<String, dynamic> json) => PushSetting(
        all: json["all"],
        showPreview: json["show_preview"],
        newReply: json["new_reply"],
        quote: json["quote"],
        followingNewThread: json["following_new_thread"],
      );

  Map<String, dynamic> toJson() => {
        "all": all,
        "show_preview": showPreview,
        "new_reply": newReply,
        "quote": quote,
        "following_new_thread": followingNewThread,
      };
}
