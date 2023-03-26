import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:kasarijaane/constants.dart';
import 'package:kasarijaane/model/notification_model.dart';
import 'package:kasarijaane/model/vehicletype_model.dart';
import 'package:kasarijaane/model/exploreplaces_model.dart';
import 'package:kasarijaane/model/route_model.dart';

class RouteService {
  Future<RouteModel?> getRoutes() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.routesEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        RouteModel _model = routeModelFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}

class NotificationService {
  Future<List<NotificationModel>?> getNotifications() async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.notificationsEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<NotificationModel> _model =
            notificationModelFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}

class VehicleTypeService {
  Future<List<VehicleTypesModel>?> getVehicleTypes() async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.vehiclestypeEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<VehicleTypesModel> _model =
            vehicleTypesModelFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}

class ExplorePlacesService {
  Future<List<ExplorePlacesModel>?> getExplorePlaces() async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.exploreplacesEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<ExplorePlacesModel> _model =
            explorePlacesModelFromJson(response.body);
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
