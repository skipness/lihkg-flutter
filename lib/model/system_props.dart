import 'dart:convert';
import 'package:lihkg_flutter/model/model.dart';
import 'package:lihkg_flutter/util/enum_values.dart';

SysProps sysPropsFromJson(String str) {
  final jsonData = json.decode(str);
  return SysProps.fromJson(jsonData);
}

String sysPropsToJson(SysProps data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class SysProps {
  int success;
  int serverTime;
  SysPropsResponse sysPropsResponse;

  SysProps({
    this.success,
    this.serverTime,
    this.sysPropsResponse,
  });

  factory SysProps.fromJson(Map<String, dynamic> json) => SysProps(
        success: json["success"],
        serverTime: json["server_time"],
        sysPropsResponse: SysPropsResponse.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "server_time": serverTime,
        "SysPropsResponse": sysPropsResponse.toJson(),
      };
}

class SysPropsResponse {
  bool lihkg;
  List<CatList> categoryList;
  List<FixedCategoryList> fixedCategoryList;

  SysPropsResponse({
    this.lihkg,
    this.categoryList,
    this.fixedCategoryList,
  });

  factory SysPropsResponse.fromJson(Map<String, dynamic> json) =>
      SysPropsResponse(
        lihkg: json["lihkg"],
        categoryList: List<CatList>.from(
            json["category_list"].map((x) => CatList.fromJson(x))),
        fixedCategoryList: List<FixedCategoryList>.from(
            json["fixed_category_list"]
                .map((x) => FixedCategoryList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "lihkg": lihkg,
        "category_list":
            List<dynamic>.from(categoryList.map((x) => x.toJson())),
        "fixed_category_list":
            List<dynamic>.from(fixedCategoryList.map((x) => x.toJson())),
      };
}

class CatList {
  String catId;
  String name;
  bool postable;
  Type type;
  String url;
  CategoryListQuery query;
  List<SubCategory> subCategory;

  CatList({
    this.catId,
    this.name,
    this.postable,
    this.type,
    this.url,
    this.query,
    this.subCategory,
  });

  factory CatList.fromJson(Map<String, dynamic> json) => CatList(
        catId: json["cat_id"],
        name: json["name"],
        postable: json["postable"],
        type: sysPropsTypeValues.map[json["type"]],
        url: json["url"],
        query: CategoryListQuery.fromJson(json["query"]),
        subCategory: List<SubCategory>.from(
            json["sub_category"].map((x) => SubCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cat_id": catId,
        "name": name,
        "postable": postable,
        "type": sysPropsTypeValues.reverse[type],
        "url": url,
        "query": query.toJson(),
        "sub_category": List<dynamic>.from(subCategory.map((x) => x.toJson())),
      };
}

class CategoryListQuery {
  String catId;

  CategoryListQuery({this.catId});

  factory CategoryListQuery.fromJson(Map<String, dynamic> json) =>
      CategoryListQuery(
        catId: json["cat_id"] == null ? null : json["cat_id"],
      );

  Map<String, dynamic> toJson() => {
        "cat_id": catId == null ? null : catId,
      };
}

enum Type { HKG }

final sysPropsTypeValues = EnumValues({"hkg": Type.HKG});

class FixedCategoryList {
  String name;
  List<CatList> catList;

  FixedCategoryList({
    this.name,
    this.catList,
  });

  factory FixedCategoryList.fromJson(Map<String, dynamic> json) =>
      FixedCategoryList(
        name: json["name"],
        catList: List<CatList>.from(
            json["cat_list"].map((x) => CatList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "cat_list": List<dynamic>.from(catList.map((x) => x.toJson())),
      };
}
