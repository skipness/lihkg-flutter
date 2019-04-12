import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:lihkg_flutter/model/model.dart';

Thread threadFromJson(String str) {
  final jsonData = json.decode(str);
  return Thread.fromJson(jsonData);
}

String threadToJson(Thread data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Thread {
  int success;
  int serverTime;
  int errorCode;
  String errorMessage;
  ThreadResponse response;

  Thread({
    this.success,
    this.serverTime,
    this.errorCode,
    this.errorMessage,
    this.response,
  });

  factory Thread.fromJson(Map<String, dynamic> json) => new Thread(
        success: json["success"],
        serverTime: json["server_time"],
        errorCode: json["error_code"] == null ? null : json["error_code"],
        errorMessage:
            json["error_message"] == null ? null : json["error_message"],
        response: json["response"] == null
            ? null
            : ThreadResponse.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "server_time": serverTime,
        "error_code": errorCode,
        "error_message": errorMessage,
        "response": response.toJson(),
      };
}

class ThreadResponse {
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
  String page;
  List<ThreadItem> itemData;

  ThreadResponse({
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
    this.page,
    this.itemData,
  });

  factory ThreadResponse.fromJson(Map<String, dynamic> json) =>
      new ThreadResponse(
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
        page: json["page"],
        itemData: new List<ThreadItem>.from(
            json["item_data"].map((x) => ThreadItem.fromJson(x))),
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
        "page": page,
        "item_data": new List<dynamic>.from(itemData.map((x) => x.toJson())),
      };
}

class ThreadItem extends Equatable {
  String postId;
  String quotePostId;
  String threadId;
  String userNickname;
  Gender userGender;
  String likeCount;
  String dislikeCount;
  String voteScore;
  String noOfQuote;
  String status;
  int replyTime;
  String msgNum;
  String msg;
  User user;
  int page;
  ThreadItem quote;

  ThreadItem({
    this.postId,
    this.quotePostId,
    this.threadId,
    this.userNickname,
    this.userGender,
    this.likeCount,
    this.dislikeCount,
    this.voteScore,
    this.noOfQuote,
    this.status,
    this.replyTime,
    this.msgNum,
    this.msg,
    this.user,
    this.page,
    this.quote,
  });

  factory ThreadItem.fromJson(Map<String, dynamic> json) => new ThreadItem(
        postId: json["post_id"],
        quotePostId: json["quote_post_id"],
        threadId: json["thread_id"],
        userNickname: json["user_nickname"],
        userGender: genderValues.map[json["user_gender"]],
        likeCount: json["like_count"],
        dislikeCount: json["dislike_count"],
        voteScore: json["vote_score"],
        noOfQuote: json["no_of_quote"],
        status: json["status"].toString(),
        replyTime: json["reply_time"],
        msgNum: json["msg_num"],
        msg: json["msg"],
        user: User.fromJson(json["user"]),
        page: json["page"],
        quote:
            json["quote"] == null ? null : ThreadItem.fromJson(json["quote"]),
      );

  Map<String, dynamic> toJson() => {
        "post_id": postId,
        "quote_post_id": quotePostId,
        "thread_id": threadId,
        "user_nickname": userNickname,
        "user_gender": genderValues.reverse[userGender],
        "like_count": likeCount,
        "dislike_count": dislikeCount,
        "vote_score": voteScore,
        "no_of_quote": noOfQuote,
        "status": status,
        "reply_time": replyTime,
        "msg_num": msgNum,
        "msg": msg,
        "user": user.toJson(),
        "page": page,
        "quote": quote == null ? null : quote.toJson(),
      };
}
