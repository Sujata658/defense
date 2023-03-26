import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:kasarijaane/main.dart';
import './model/route_model.dart' as r;

import './api_service.dart';

import '../components/constants.dart';
// import './components/constants.dart';
import './components/searchbar.dart';
import './components/searchbar2.dart';
import 'routedesc.dart';
import 'routedesc2.dart';
import 'dart:convert';

r.RouteModel? routeModel; //jsonVehicle
List<r.Route> jsonRouteOnly = []; //routeonly
List<r.Vehicle> jsonVehicleOnly = [];
String start = "";
String finish = "";
String commonStop = '';
String startingg = '';
String finall = '';

late String commonPo = '';
int counter = 0;
int counter2 = 1;

int needreverse = 0;

class RouteFinder {
  int needreverse1 = 0;
  int needreverse2 = 0;
  List<Map<String, dynamic>> places = []; //stops -> routes
  List<Map<String, dynamic>> listroutes = []; //routes -> stops
  Map<String, List<String>> groupedRoutes = {}; //common eliminated
  late String commonPo;

  List<Map<String, dynamic>> getPlaces() {
    // var data = jsonDecode(jsonString);
    List<r.Vehicle> vehicledata = routeModel!.vehicles;
    // print('vehicledata: $vehicledata');
    for (var vehicle in vehicledata) {
      var routes = vehicle.routes;
      for (var j = 0; j < routes.length; j++) {
        var route = routes[j];
        for (var stop in route.stops) {
          listroutes.add({'route': route.name, 'stopname': stop.name});

          places.add({
            'name': stop.name,
            'route_name': route.name,
          });
        }
      }
    }
    // print("list routes $listroutes");
    // print("places $places");
    // print("list routes $listroutes");
    // remove duplicates and group by name
    Map<String, List<String>> groupedPlaces = {};

    places.forEach((place) {
      String placename = place['name'];
      String routename = place['route_name'];
      if (groupedPlaces.containsKey(placename)) {
        if (!groupedPlaces[placename]!.contains(routename)) {
          groupedPlaces[placename]!.add(routename);
        }
      } else {
        groupedPlaces[placename] = [routename];
      }
      // print('grouped places is $groupedPlaces');
    });
    listroutes.forEach((listroute) {
      String route = listroute['route'];
      String stopname = listroute['stopname'];
      if (groupedRoutes.containsKey(route)) {
        if (!groupedRoutes[route]!.contains(stopname)) {
          groupedRoutes[route]!.add(stopname);
        }
      } else {
        groupedRoutes[route] = [stopname];
      }
    });
    // print('groupedRoutes: $groupedRoutes');

    // convert to list of maps
    List<Map<String, dynamic>> uniquePlaces = [];
    groupedPlaces.forEach((name, routename) {
      uniquePlaces.add({
        'name': name,
        'routename': routename,
      });
    });
    // print("unique places $uniquePlaces"); //duplircate remocal
    return uniquePlaces;
  }

  List findSpecific(String query) {
    // print('I got called - findSpecific()');
    var allplaces = getPlaces();
    // print('allplaces: $allplaces');
    var foundplace = [];
    for (var place in allplaces) {
      if (place['name'] == query) {
        foundplace.add(place);
      }
    }
    // print('foundplaces: $foundplace');
    return foundplace;
  }

  List<String> findcommon(
      List<String> startPointRout, List<String> endPointRout) {
    Set<String> sPr = {};
    Set<String> ePr = {};
    print('startpointroute: $startPointRout');
    print('endpointroute: $endPointRout');
    for (String key in startPointRout.toList()) {
      sPr.addAll(groupedRoutes[key] as Iterable<String>);
    }
    for (String key in endPointRout.toList()) {
      ePr.addAll(groupedRoutes[key] as Iterable<String>);
    }

    // Find common elements
    Set<String> commonElements = sPr.intersection(ePr);

    print(commonElements);
    commonPo = commonElements.last;

    // Find common point

    print(startingg);

    List commonP = findSpecific(commonElements.last);

    List<String> b = commonP[0]['routename'];
    print('b: $b');
    List<String> result = b
        .where((element) =>
            startPointRout.contains(element) || endPointRout.contains(element))
        .toList();

    print(result);
    List<String> commonPoint = [];
    commonPoint.addAll(result);
    return commonPoint;
  }

  List<r.Fare> search(startt, endd) {
    List<r.Vehicle> vehicledata = jsonVehicleOnly;

    List<r.Fare> results = []; //add fares to it
    int count = 0;
    for (var vehicle in vehicledata) {
      for (var route in vehicle.routes) {
        if(route.name == startt){
        for (var fare in route.fares) {
            if (fare.startLocation.toLowerCase() == startt.toLowerCase() &&
                fare.endLocation.toLowerCase() == endd.toLowerCase()) {
              results.add(fare); //only fare model
              start = startt;
              finish = endd;
              count += 1;
              break;
            }
            if (fare.endLocation.toLowerCase() == endd.toLowerCase() &&
                fare.startLocation.toLowerCase() == startt.toLowerCase()) {
              results.add(fare); //only fare model
              start = startt;
              finish = endd;
              count += 1;
              needreverse = 1;

              break;
            }
        }
        
        }
      }
    }
    startingg = start;
    finall = finish;
    print('direct route count $count');
    return results; //returns the route ids
  }

  List<String> findMatchingIds(
      List<dynamic> startPointRoutes, List<dynamic> endPointRoutes) {
    List<String> matchingIds = [];

    List<String> common = findcommon(
        startPointRoutes[0]['routename'], endPointRoutes[0]['routename']);

    List<r.Fare> first = search(startingg, common);
    List<r.Fare> second = search(common, finall);
    matchingIds.addAll(common);
    print('matchind ID : $matchingIds');
    return matchingIds;
  }
}

class MyLogic {
  String startingPoint;
  String destination;

  MyLogic({required this.startingPoint, required this.destination});

  List<r.Fare> search() {
    List<r.Vehicle> vehicledata = jsonVehicleOnly;

    List<r.Fare> results = []; //add fares to it
    int count = 0;
    for (var vehicle in vehicledata) {
      for (var route in vehicle.routes) {
        for (var fare in route.fares) {
          if (fare.startLocation.toLowerCase() == startingPoint.toLowerCase() &&
              fare.endLocation.toLowerCase() == destination.toLowerCase()) {
            results.add(fare); //only fare model
            start = startingPoint;
            finish = destination;
            count += 1;
            break;
          }
          if (fare.endLocation.toLowerCase() == startingPoint.toLowerCase() &&
              fare.startLocation.toLowerCase() == destination.toLowerCase()) {
            results.add(fare); //only fare model
            start = startingPoint;
            finish = destination;
            count += 1;
            needreverse = 1;

            break;
          }
        }
      }
    }
    startingg = start;
    finall = finish;
    print('direct route count $count');
    return results; //returns the route ids
  }
}

class SearchResultPage extends StatefulWidget {
  SearchResultPage(
      {Key? key, required this.starting, required this.destination})
      : super(key: key);

  final String starting;
  final String destination;

  @override
  State<SearchResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<SearchResultPage> {
  TextEditingController startingPointController = TextEditingController();

  TextEditingController destinationController = TextEditingController();

  String? _selectedOption;

  @override
  void initState() {
    super.initState();

    _getData();
  }

  void _getData() async {
    routeModel = await (RouteService().getRoutes());
    Future.delayed(const Duration(seconds: 1)).then((value) {
      // print(' route model $routeModel');
      setState(() {
        // jsonVehicleOnly = value!.vehicles;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // for (var vehicle in routeModel) {
    //   jsonRouteOnly.addAll(vehicle.vehicles);
    // }
    jsonVehicleOnly = routeModel!.vehicles;

//adding all the routes in jsonRouteOnly (unfilitred)
    for (var vehicle in jsonVehicleOnly) {
      jsonRouteOnly.addAll(vehicle.routes);
    }

    MyLogic logic = MyLogic(
        startingPoint: widget.starting, destination: widget.destination);

    List<r.Fare> searchedObject = logic.search();
    print("if direct ${searchedObject.length}");
    // print(needreverse);

    print(searchedObject.isEmpty);
    if (searchedObject.isNotEmpty) {
      print("inside 266");
      counter = 0;
      counter2 = searchedObject.length;
      print(counter2);
    } else {
      print("inside 271");
      counter += 1;
      counter2 = 1;
      print(counter2);
      print(counter);

      RouteFinder R = RouteFinder();
      var startPointRoutes = R.findSpecific(widget.starting);
      var endPointRoutes = R.findSpecific(widget.destination);
      if (startPointRoutes.isEmpty || endPointRoutes.isEmpty) {
        counter2 = 1;
        counter = 100;
        print("inside 285");
      } else {
        print("inside 287");
        counter += 1;
        List<String> matching =
            R.findMatchingIds(startPointRoutes, endPointRoutes);
        // print('uniquie routes $unique')
        print('matching $matching');
        if (matching.isEmpty) {
          print("no indirect routes available");
          counter2 = 1;
          counter = 100;
        } else {
          counter += 1;
          List<r.Fare> findmatchingfaremodel(query) {
            List<r.Vehicle> vehicledata = routeModel!.vehicles;
            print(query);
            List<r.Fare> results = []; //add fares to it
            for (var vehicle in vehicledata) {
              for (var route in vehicle.routes) {
                for (var fare in route.fares) {
                  if (route.name.toLowerCase() == query.toLowerCase()) {
                    results.add(fare);
                    // print('added one'); //only fare mode
                    break;
                  }
                }
              }
            }
            // print('results: $results');
            return results;
          }

          matching = matching.reversed.toList();

          for (var one in matching) {
            if (findmatchingfaremodel(one).isEmpty) {
              print('Here is some error.');
              counter = 100;
              break;
            }
            searchedObject.addAll(findmatchingfaremodel(one));
          }
        }

        // print('matching : $matching');
        // commonStop = R.commonPo;
        // print('startPointroutes $startPointRoutes');
        // print('endPointRoutes $endPointRoutes');
        // print('R.commonPO ${R.commonPo}');
      }
    }

    return routeModel == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Available Routes'),
              backgroundColor: ktheme,
              iconTheme: IconThemeData(color: Colors.white),
              toolbarTextStyle: TextTheme(
                headline6: TextStyle(color: Colors.white, fontSize: 18),
              ).bodyText2,
              titleTextStyle: TextTheme(
                headline6: TextStyle(color: Colors.white, fontSize: 18),
              ).headline6,
              systemOverlayStyle: SystemUiOverlayStyle.light,
            ),
            backgroundColor: kwhite,
            body: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SearchBar2(
                        label: start,
                        controller: startingPointController,
                      ),
                      SearchBar(
                        label: finish,
                        controller: destinationController,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: ktheme, // text color
                              minimumSize: Size(200, 50),
                            ),
                            // shape: RoundedRectangleBorder(
                            //   borderRadius: BorderRadius.circular(0),
                            // ),
                            onPressed: () {
                              String startingPoint =
                                  startingPointController.text;
                              String destination = destinationController.text;
                              print('Starting point $startingPoint');
                              print(destination);
                              if (startingPoint.isEmpty ||
                                  destination.isEmpty) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Error'),
                                    content:
                                        Text('Please fill in both fields.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SearchResultPage(
                                        starting: startingPoint,
                                        destination: destination),
                                  ),
                                );
                              }
                            },
                            child: Text('Search Route'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: counter2,
                    itemBuilder: (BuildContext context, int index) {
                      // print('searched objects $searchedObject');
                      // print('searached object length ${searchedObject.length}');
                      //finding list of route ids with matching searches
                      List<String> fareList = [];
                      for (var eachfare in searchedObject) {
                        fareList.add(eachfare.fare);
                      }
                      // fareList.add(searchedObject[index].fare);

                      List<int> searchedRouteId = [];
                      List<r.Route> searchedRoutes = [];
                      for (var obj in searchedObject) {
                        searchedRouteId.add(obj.route);
                        // print(searchedRouteId);rr
                      }
                      // searchedRouteId.add(searchedObject[index].route);
                      // print(searchedRouteId); //ok till here
                      //filtered list of routes
                      for (var route in jsonRouteOnly) {
                        if (searchedRouteId.contains(route.id)) {
                          searchedRoutes.add(jsonRouteOnly[index]);
                          // print(route.id);
                        }
                      }

                      // print(jsonRouteOnly.length);
                      List<int> searchedVehicleId = [];
                      List<r.Vehicle> searchedVehicles = [];
                      for (var obj in searchedRoutes) {
                        searchedVehicleId.add(obj.vehicle);
                      }
                      // print(searchedVehicleId);
                      //filtered list of vehicles
                      for (var vehic in jsonVehicleOnly) {
                        if (searchedRouteId.contains(vehic.id)) {
                          searchedVehicles.add(vehic);
                        }
                      }
                      // print(counter);
                      //all stops
                      if (counter == 0) {
                        print(searchedVehicles[index]);
                        print(searchedRoutes[index].name);
                        return GestureDetector(
                            onTap: () {
                              print(searchedVehicles[index]);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RouteDesc(
                                      route: searchedVehicles[index],
                                      start: startingg,
                                      end: finall,
                                      needreverse: needreverse,
                                    ),
                                  ));
                            },
                            child: Card(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 16),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  title: Text(
                                    '${searchedVehicles[index].name}',
                                    style: TextStyle(
                                      color: ktheme,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 4.0),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.route_sharp,
                                            size: 16.0,
                                            color: kblack,
                                          ),
                                          SizedBox(width: 4.0),
                                          Expanded(
                                            child: Text(
                                              '$startingg  -> $finall '
                                              // ${searchedRoutes[index].stops} '
                                              ,
                                              style: TextStyle(
                                                color: kblack,
                                                fontSize: 14.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 4.0),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.attach_money,
                                            size: 16.0,
                                            color: kblack,
                                          ),
                                          SizedBox(width: 4.0),
                                          Text(
                                            'Rs. ${fareList[index]}',
                                            style: TextStyle(
                                              color: kblack,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 4.0),
                                      SizedBox(height: 4.0),
                                    ],
                                  ),
                                ),
                              ),
                            ));
                      } else if (counter == 100) {
                        print("no direct routes and indirect routes $counter");
                        return Card(
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(
                                'No Routes Available ',
                                style: TextStyle(
                                  color: ktheme,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 4.0),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.sentiment_dissatisfied_outlined,
                                        size: 16.0,
                                        color: ktheme,
                                      ),
                                      SizedBox(width: 4.0),
                                      Expanded(
                                        child: Text(
                                          'We will add missing routes ASAP',
                                          // ${searchedRoutes[index].stops} '

                                          style: TextStyle(
                                            color: ktheme,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4.0),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.hourglass_bottom,
                                        size: 16.0,
                                        color: ktheme,
                                      ),
                                      SizedBox(width: 4.0),
                                      Text(
                                        'Keep Patience',
                                        style: TextStyle(
                                          color: kblack,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4.0),
                                  SizedBox(height: 4.0),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        searchedVehicles.reversed.toList();
                        print('inside else');
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RouteDescTwo(
                                    route: searchedVehicles[1],
                                    route1: searchedVehicles[0],
                                    start: startingg,
                                    end: finall,
                                    matching: commonStop,
                                    needreverse: needreverse,
                                  ),
                                ));
                          },
                          child: Card(
                            child: Column(children: [
                              Card(
                                margin: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 16),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    title: Text(
                                      '${searchedVehicles[1].name}',
                                      style: TextStyle(
                                        color: ktheme,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 4.0),
                                        //stop row
                                        Row(
                                          children: [
                                            SizedBox(height: 4.0),
                                            Icon(
                                              Icons.route_sharp,
                                              size: 16.0,
                                              color: kblack,
                                            ),
                                            SizedBox(width: 4.0),
                                            Expanded(
                                              child: Text(
                                                '$startingg -> $commonStop '
                                                // ${searchedRoutes[index].stops} '
                                                ,
                                                style: TextStyle(
                                                  color: kblack,
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 4.0),
                                        //fare row
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.attach_money,
                                              size: 16.0,
                                              color: kblack,
                                            ),
                                            SizedBox(width: 4.0),
                                            Text(
                                              'Rs. ${fareList[0]}',
                                              style: TextStyle(
                                                color: kblack,
                                                fontSize: 14.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 4.0),
                                        SizedBox(height: 4.0),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.arrow_downward,
                                size: 30.0,
                                color: ktheme,
                              ),
                              Card(
                                margin: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 16),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    title: Text(
                                      '${searchedVehicles[0].name}',
                                      style: TextStyle(
                                        color: ktheme,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 4.0),
                                        //stop row
                                        Row(
                                          children: [
                                            SizedBox(height: 4.0),
                                            Icon(
                                              Icons.route_sharp,
                                              size: 16.0,
                                              color: kblack,
                                            ),
                                            SizedBox(width: 4.0),
                                            Expanded(
                                              child: Text(
                                                '$commonStop -> $finall ',
                                                // ${searchedRoutes[index].stops} '

                                                style: TextStyle(
                                                  color: kblack,
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 4.0),
                                        //fare row
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.attach_money,
                                              size: 16.0,
                                              color: kblack,
                                            ),
                                            SizedBox(width: 4.0),
                                            Text(
                                              'Rs. ${fareList[1]}',
                                              style: TextStyle(
                                                color: kblack,
                                                fontSize: 14.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 4.0),
                                        SizedBox(height: 4.0),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ]),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
