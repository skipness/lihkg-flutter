import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:lihkg_flutter/model/model.dart';

Category categoryFromJson(String str) {
  final jsonData = json.decode(str);
  return Category.fromJson(jsonData);
}

String categoryToJson(Category data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Category {
  int success;
  int serverTime;
  int errorCode;
  String errorMessage;
  CategoryResponse response;

  Category({
    this.success,
    this.serverTime,
    this.errorCode,
    this.errorMessage,
    this.response,
  });

  factory Category.fromJson(Map<String, dynamic> json) => new Category(
        success: json["success"],
        serverTime: json["server_time"],
        errorCode: json["error_code"] == null ? null : json["error_code"],
        errorMessage:
            json["error_message"] == null ? null : json["error_message"],
        response: json["response"] == null
            ? null
            : CategoryResponse.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "server_time": serverTime,
        "error_code": errorCode,
        "error_message": errorMessage,
        "response": response.toJson(),
      };
}

class CategoryResponse {
  CategoryProps category;
  bool isPagination;
  List<Item> items;
  Me me;

  CategoryResponse({
    this.category,
    this.isPagination,
    this.items,
    this.me,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      new CategoryResponse(
        category: CategoryProps.fromJson(json["category"]),
        isPagination: json["is_pagination"],
        items: new List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        me: json["me"] == null ? null : Me.fromJson(json["me"]),
      );

  Map<String, dynamic> toJson() => {
        "category": category.toJson(),
        "is_pagination": isPagination,
        "items": new List<dynamic>.from(items.map((x) => x.toJson())),
        "me": me.toJson(),
      };
}

class Item extends Equatable {
  String threadId;
  String catId;
  String subCatId;
  String title;
  String userId;
  String userNickname;
  Gender userGender;
  String noOfReply;
  String noOfUniUserReply;
  String likeCount;
  String dislikeCount;
  String replyLikeCount;
  String replyDislikeCount;
  String maxReplyLikeCount;
  String maxReplyDislikeCount;
  int createTime;
  int lastReplyTime;
  String status;
  bool isAdu;
  Remark remark;
  String lastReplyUserId;
  String maxReply;
  int totalPage;
  bool isHot;
  CategoryProps category;
  bool isBookmarked;
  bool isReplied;
  User user;
  SubCategory subCategory;

  Item({
    this.threadId,
    this.catId,
    this.subCatId,
    this.title,
    this.userId,
    this.userNickname,
    this.userGender,
    this.noOfReply,
    this.noOfUniUserReply,
    this.likeCount,
    this.dislikeCount,
    this.replyLikeCount,
    this.replyDislikeCount,
    this.maxReplyLikeCount,
    this.maxReplyDislikeCount,
    this.createTime,
    this.lastReplyTime,
    this.status,
    this.isAdu,
    this.remark,
    this.lastReplyUserId,
    this.maxReply,
    this.totalPage,
    this.isHot,
    this.category,
    this.isBookmarked,
    this.isReplied,
    this.user,
    this.subCategory,
  }) : super([threadId]);

  factory Item.fromJson(Map<String, dynamic> json) => new Item(
        threadId: json["thread_id"],
        catId: json["cat_id"],
        subCatId: json["sub_cat_id"],
        title: json["title"],
        userId: json["user_id"],
        userNickname: json["user_nickname"],
        userGender: genderValues.map[json["user_gender"]],
        noOfReply: json["no_of_reply"],
        noOfUniUserReply: json["no_of_uni_user_reply"],
        likeCount: json["like_count"],
        dislikeCount: json["dislike_count"],
        replyLikeCount: json["reply_like_count"],
        replyDislikeCount: json["reply_dislike_count"],
        maxReplyLikeCount: json["max_reply_like_count"],
        maxReplyDislikeCount: json["max_reply_dislike_count"],
        createTime: json["create_time"],
        lastReplyTime: json["last_reply_time"],
        status: json["status"],
        isAdu: json["is_adu"],
        remark: Remark.fromJson(json["remark"]),
        lastReplyUserId: json["last_reply_user_id"],
        maxReply: json["max_reply"],
        totalPage: json["total_page"],
        isHot: json["is_hot"],
        category: CategoryProps.fromJson(json["category"]),
        isBookmarked: json["is_bookmarked"],
        isReplied: json["is_replied"],
        user: User.fromJson(json["user"]),
        subCategory: json["sub_category"] == null
            ? null
            : SubCategory.fromJson(json["sub_category"]),
      );

  Map<String, dynamic> toJson() => {
        "thread_id": threadId,
        "cat_id": catId,
        "sub_cat_id": subCatId,
        "title": title,
        "user_id": userId,
        "user_nickname": userNickname,
        "user_gender": genderValues.reverse[userGender],
        "no_of_reply": noOfReply,
        "no_of_uni_user_reply": noOfUniUserReply,
        "like_count": likeCount,
        "dislike_count": dislikeCount,
        "reply_like_count": replyLikeCount,
        "reply_dislike_count": replyDislikeCount,
        "max_reply_like_count": maxReplyLikeCount,
        "max_reply_dislike_count": maxReplyDislikeCount,
        "create_time": createTime,
        "last_reply_time": lastReplyTime,
        "status": status,
        "is_adu": isAdu,
        "remark": remark.toJson(),
        "last_reply_user_id": lastReplyUserId,
        "max_reply": maxReply,
        "total_page": totalPage,
        "is_hot": isHot,
        "category": category.toJson(),
        "is_bookmarked": isBookmarked,
        "is_replied": isReplied,
        "user": user.toJson(),
        "sub_category": subCategory == null ? null : subCategory.toJson(),
      };
}
