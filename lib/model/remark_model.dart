class Remark {
  int lastReplyCount;
  String coverImage;

  Remark({
    this.lastReplyCount,
    this.coverImage,
  });

  factory Remark.fromJson(Map<String, dynamic> json) => new Remark(
      lastReplyCount: json["last_reply_count"],
      coverImage: json["cover_img"] == null ? null : json["cover_img"]);

  Map<String, dynamic> toJson() => {
        "last_reply_count": lastReplyCount,
        "cover_img": coverImage,
      };
}
