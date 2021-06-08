// To parse this JSON data, do
//
//     final modelData = modelDataFromJson(jsonString);

import 'dart:convert';

List<ModelData> modelDataFromJson(String str) =>
    List<ModelData>.from(json.decode(str).map((x) => ModelData.fromJson(x)));

String modelDataToJson(List<ModelData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelData {
  ModelData({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  int userId;
  int id;
  String title;
  String body;

  factory ModelData.fromJson(Map<String, dynamic> json) => ModelData(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}
