import 'package:flutter/material.dart';

import 'components/constants.dart';
import './model/route_model.dart' as r;

import 'timeline.dart';

class RouteDescTwo extends StatelessWidget {
  final r.Vehicle route;
  final r.Vehicle? route1;
  final String start;
  final String end;
  final String matching;
  final int needreverse;
  RouteDescTwo({
    Key? key,
    required this.route,
    required this.route1,
    required this.start,
    required this.end,
    required this.matching,
    required this.needreverse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<r.Route> routed = route.routes;
    List<r.Route>? routed1 = route1 != null ? route1!.routes : null;
    // print(routed[0].stops);
    List<r.Stop> stops = [];
    List<r.Stop> stops1 = [];
    for (var addstop in routed[0].stops) {
      stops.add(addstop);
    }
    for (var addstop in routed1![0].stops) {
      stops1.add(addstop);
    }
    List getstopnames(List<r.Stop> stops) {
      List names = [];
      for (var stop in stops) {
        names.add(stop.name);
      }
      return needreverse == 0 ? names : names.reversed.toList();
    }

    print('matching: $matching');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ktheme,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(''),
          automaticallyImplyLeading: true,
          elevation: 0.0,
        ),
        backgroundColor: kwhite,
        body: Container(
          color: kgrey,
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '$start ---> $end',
                                style: TextStyle(
                                  color: kblack,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 15.0),
                              Text(
                                'Please change your vehicle at ',
                                style: TextStyle(fontSize: 15.0),
                              ),
                              Text(
                                '$matching.',
                                style:
                                    TextStyle(fontSize: 16.0, color: kdarkblue),
                              ),
                              SizedBox(height: 8.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: Container(
                  color: kwhite,
                  child: Column(
                    children: [
                      Expanded(
                          child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  route.name,
                                  style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Timeline(
                                  processCard: getstopnames(stops),
                                  start: start,
                                  end: matching,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  route1!.name,
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Timeline(
                                  processCard: getstopnames(stops1),
                                  start: matching,
                                  end: end,
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
