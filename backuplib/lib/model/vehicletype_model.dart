// To parse this JSON data, do
//
//     final vehicleTypesModel = vehicleTypesModelFromJson(jsonString);

import 'dart:convert';

List<VehicleTypesModel> vehicleTypesModelFromJson(String str) =>
    List<VehicleTypesModel>.from(
        json.decode(str).map((x) => VehicleTypesModel.fromJson(x)));

String vehicleTypesModelToJson(List<VehicleTypesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VehicleTypesModel {
  VehicleTypesModel({
    required this.name,
    required this.picture,
    required this.description,
  });

  String name;
  String picture;
  String description;

  factory VehicleTypesModel.fromJson(Map<String, dynamic> json) =>
      VehicleTypesModel(
        name: json["name"],
        picture: json["picture"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "picture": picture,
        "description": description,
      };
}
