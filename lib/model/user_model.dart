import 'package:lihkg_flutter/util/enum_values.dart';

class User {
  String userId;
  String nickname;
  String level;
  Gender gender;
  String status;
  int createTime;
  LevelName levelName;
  bool isFollowing;
  bool isBlocked;
  bool isDisappear;

  User({
    this.userId,
    this.nickname,
    this.level,
    this.gender,
    this.status,
    this.createTime,
    this.levelName,
    this.isFollowing,
    this.isBlocked,
    this.isDisappear,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        nickname: json["nickname"],
        level: json["level"],
        gender: genderValues.map[json["gender"]],
        status: json["status"],
        createTime: json["create_time"],
        levelName: levelNameValues.map[json["level_name"]],
        isFollowing: json["is_following"],
        isBlocked: json["is_blocked"],
        isDisappear: json["is_disappear"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "nickname": nickname,
        "level": level,
        "gender": genderValues.reverse[gender],
        "status": status,
        "create_time": createTime,
        "level_name": levelNameValues.reverse[levelName],
        "is_following": isFollowing,
        "is_blocked": isBlocked,
        "is_disappear": isDisappear,
      };
}

enum Gender { M, F }

final genderValues = EnumValues({"F": Gender.F, "M": Gender.M});

enum LevelName { EMPTY, LEVEL_NAME }

final levelNameValues =
    EnumValues({"普通會員": LevelName.EMPTY, "站長": LevelName.LEVEL_NAME});
