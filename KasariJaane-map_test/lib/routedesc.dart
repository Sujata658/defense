import 'package:flutter/material.dart';
import 'package:kasarijaane/searchresult.dart';
import 'package:kasarijaane/timeline.dart';

import 'components/constants.dart';
import './model/route_model.dart' as r;

class RouteDesc extends StatelessWidget {
  final r.Vehicle route;
  final String start;
  final String end;
  final int needreverse;

  RouteDesc(
      {Key? key, required this.route, required this.start, required this.end,required this.needreverse,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<r.Route> routed = route.routes;
    List<r.Stop> stops = [];
    List<String> stoplist = [];
    for (var addstop in routed[0].stops) {
      stops.add(addstop);
    }
    List getstopnames(List<r.Stop> stops) {
      List names = [];
      for (var stop in stops) {
        names.add(stop.name);
      }

      return needreverse ==0 ? names : names.reversed.toList();
    }

    // for (var one in stops) {
    //   stoplist.add(one.name);
    // }
    // stoplist.reversed.toList();

    print(stoplist);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: kdarkpurple,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(''),
          automaticallyImplyLeading: true,
          elevation: 0.0,
        ),
        backgroundColor: kgrey,
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
                                    end: end,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
