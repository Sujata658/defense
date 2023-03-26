// To parse this JSON data, do
//
//     final explorePlacesModel = explorePlacesModelFromJson(jsonString);

import 'dart:convert';

List<ExplorePlacesModel> explorePlacesModelFromJson(String str) =>
    List<ExplorePlacesModel>.from(
        json.decode(str).map((x) => ExplorePlacesModel.fromJson(x)));

String explorePlacesModelToJson(List<ExplorePlacesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExplorePlacesModel {
  ExplorePlacesModel({
    required this.name,
    required this.location,
    required this.picture,
    required this.description,
  });

  String name;
  String location;
  String picture;
  String description;

  factory ExplorePlacesModel.fromJson(Map<String, dynamic> json) =>
      ExplorePlacesModel(
        name: json["name"],
        location: json["location"],
        picture: json["picture"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "location": location,
        "picture": picture,
        "description": description,
      };
}
