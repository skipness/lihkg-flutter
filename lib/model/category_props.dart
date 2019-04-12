class CategoryProps {
  String catId;
  String name;
  bool postable;

  CategoryProps({
    this.catId,
    this.name,
    this.postable,
  });

  factory CategoryProps.fromJson(Map<String, dynamic> json) =>
      new CategoryProps(
        catId: json["cat_id"],
        name: json["name"],
        postable: json["postable"],
      );

  Map<String, dynamic> toJson() => {
        "cat_id": catId,
        "name": name,
        "postable": postable,
      };
}
