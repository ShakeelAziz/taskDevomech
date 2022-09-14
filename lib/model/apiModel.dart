// To parse this JSON data, do
//
//     final apiModel = apiModelFromJson(jsonString);

import 'dart:convert';

ApiModel apiModelFromJson(String str) => ApiModel.fromJson(json.decode(str));

String apiModelToJson(ApiModel data) => json.encode(data.toJson());

class ApiModel {
  ApiModel({
    this.items,
  });

  List<Item> items;

  factory ApiModel.fromJson(Map<String, dynamic> json) => ApiModel(
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  Item({
    this.project,
    this.article,
    this.granularity,
    this.timestamp,
    this.access,
    this.agent,
    this.views,
  });

  String project;
  String article;
  String granularity;
  String timestamp;
  String access;
  String agent;
  int views;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    project: json["project"],
    article: json["article"],
    granularity: json["granularity"],
    timestamp: json["timestamp"],
    access: json["access"],
    agent: json["agent"],
    views: json["views"],
  );

  Map<String, dynamic> toJson() => {
    "project": projectValues.reverse[project],
    "article": articleValues.reverse[article],
    "granularity": granularityValues.reverse[granularity],
    "timestamp": timestamp,
    "access": accessValues.reverse[access],
    "agent": agentValues.reverse[agent],
    "views": views,
  };
}

enum Access { ALL_ACCESS }

final accessValues = EnumValues({
  "all-access": Access.ALL_ACCESS
});

enum Agent { ALL_AGENTS }

final agentValues = EnumValues({
  "all-agents": Agent.ALL_AGENTS
});

enum Article { TIGER_KING }

final articleValues = EnumValues({
  "Tiger_King": Article.TIGER_KING
});

enum Granularity { DAILY }

final granularityValues = EnumValues({
  "daily": Granularity.DAILY
});

enum Project { EN_WIKIPEDIA }

final projectValues = EnumValues({
  "en.wikipedia": Project.EN_WIKIPEDIA
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
