import 'package:lihkg_flutter/util/enum_values.dart';

class SubCategory {
  String catId;
  dynamic subCatId;
  String name;
  bool postable;
  bool filterable;
  bool orderable;
  bool isFilter;
  String url;
  SubCategoryQuery query;

  SubCategory({
    this.catId,
    this.subCatId,
    this.name,
    this.postable,
    this.filterable,
    this.orderable,
    this.isFilter,
    this.url,
    this.query,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => new SubCategory(
        catId: json["cat_id"],
        subCatId: json["sub_cat_id"],
        name: json["name"],
        postable: json["postable"],
        filterable: json["filterable"],
        orderable: json["orderable"],
        isFilter: json["is_filter"],
        url: json["url"],
        query: SubCategoryQuery.fromJson(json["query"]),
      );

  Map<String, dynamic> toJson() => {
        "cat_id": catId,
        "sub_cat_id": subCatId,
        "name": name,
        "postable": postable,
        "filterable": filterable,
        "orderable": orderable,
        "is_filter": isFilter,
        "url": url,
        "query": query.toJson(),
      };
}

class SubCategoryQuery {
  Order order;
  String type;
  String catId;
  String subCatId;

  SubCategoryQuery({
    this.order,
    this.type,
    this.catId,
    this.subCatId,
  });

  factory SubCategoryQuery.fromJson(Map<String, dynamic> json) =>
      new SubCategoryQuery(
        order: json["order"] == null ? null : orderValues.map[json["order"]],
        type: json["type"] == null ? null : json["type"],
        catId: json["cat_id"] == null ? null : json["cat_id"],
        subCatId: json["sub_cat_id"] == null ? null : json["sub_cat_id"],
      );

  Map<String, dynamic> toJson() => {
        "order": order == null ? null : orderValues.reverse[order],
        "type": type == null ? null : type,
        "cat_id": catId == null ? null : catId,
        "sub_cat_id": subCatId == null ? null : subCatId,
      };
}

enum Order { HOT }

final orderValues = new EnumValues({"hot": Order.HOT});
