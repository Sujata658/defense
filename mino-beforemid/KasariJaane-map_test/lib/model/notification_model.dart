// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

List<NotificationModel> notificationModelFromJson(String str) =>
    List<NotificationModel>.from(
        json.decode(str).map((x) => NotificationModel.fromJson(x)));

String notificationModelToJson(List<NotificationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationModel {
  NotificationModel({
    required this.title,
    required this.message,
    required this.createdAt,
    required this.read,
  });

  String title;
  String message;
  DateTime createdAt;
  bool read;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        title: json["title"],
        message: json["message"],
        createdAt: DateTime.parse(json["created_at"]),
        read: json["read"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "message": message,
        "created_at": createdAt.toIso8601String(),
        "read": read,
      };
}
