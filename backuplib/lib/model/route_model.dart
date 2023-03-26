// To parse this JSON data, do
//
//     final routeModel = routeModelFromJson(jsonString);

import 'dart:convert';

RouteModel routeModelFromJson(String str) =>
    RouteModel.fromJson(json.decode(str));

String routeModelToJson(RouteModel data) => json.encode(data.toJson());

class RouteModel {
  RouteModel({
    required this.vehicles,
  });

  List<Vehicle> vehicles;

  factory RouteModel.fromJson(Map<String, dynamic> json) => RouteModel(
        vehicles: List<Vehicle>.from(
            json["vehicles"].map((x) => Vehicle.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "vehicles": List<dynamic>.from(vehicles.map((x) => x.toJson())),
      };
}

class Vehicle {
  Vehicle({
    required this.id,
    required this.name,
    required this.type,
    required this.routes,
    required this.fares,
  });

  int id;
  String name;
  String type;
  List<Route> routes;
  List<Fare> fares;

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        routes: List<Route>.from(json["routes"].map((x) => Route.fromJson(x))),
        fares: List<Fare>.from(json["fares"].map((x) => Fare.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "routes": List<dynamic>.from(routes.map((x) => x.toJson())),
        "fares": List<dynamic>.from(fares.map((x) => x.toJson())),
      };
}

class Fare {
  Fare({
    required this.id,
    required this.startLocation,
    required this.endLocation,
    required this.fare,
    required this.route,
  });

  int id;
  String startLocation;
  String endLocation;
  String fare;
  int route;

  factory Fare.fromJson(Map<String, dynamic> json) => Fare(
        id: json["id"],
        startLocation: json["start_location"],
        endLocation: json["end_location"],
        fare: json["fare"],
        route: json["route"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "start_location": startLocation,
        "end_location": endLocation,
        "fare": fare,
        "route": route,
      };
}

class Route {
  Route({
    required this.id,
    required this.name,
    required this.startingPoint,
    required this.finalPoint,
    required this.stops,
    required this.vehicle,
  });

  int id;
  String name;
  String startingPoint;
  String finalPoint;
  List<String> stops;
  int vehicle;

  factory Route.fromJson(Map<String, dynamic> json) => Route(
        id: json["id"],
        name: json["name"],
        startingPoint: json["starting_point"],
        finalPoint: json["final_point"],
        stops: List<String>.from(json["stops"].map((x) => x)),
        vehicle: json["vehicle"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "starting_point": startingPoint,
        "final_point": finalPoint,
        "stops": List<dynamic>.from(stops.map((x) => x)),
        "vehicle": vehicle,
      };
}
