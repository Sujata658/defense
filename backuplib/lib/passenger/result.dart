import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kasarijaane/api_service.dart';
import 'package:kasarijaane/model/route_model.dart';

// import 'RouteDesc.dart';
import '../components/constants.dart';

class ResultPage extends StatefulWidget {
  ResultPage({Key? key, required this.query}) : super(key: key);
  final String query;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  RouteModel? routeModel;

  List<String> _options = [
    'Kathmandu',
    'Pokhara',
    'Chitwan',
    'Lumbini',
    'Bhaktapur'
  ];
  String? _selectedOption;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    routeModel = await (RouteService().getRoutes());
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          print(value);
        }));
  }

  void _filterOptions(String query) {
    setState(() {
      _options = ['Kathmandu', 'Pokhara', 'Chitwan', 'Lumbini', 'Bhaktapur']
          .where((option) {
        return option.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: _options.map((option) {
            return ListTile(
              title: Text(option),
              onTap: () {
                setState(() {
                  _selectedOption = option;
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  // final List<Map<String, dynamic>> routeModel = [
  @override
  Widget build(BuildContext context) {
    return routeModel == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Search Results'),
              backgroundColor: kdarkpurple,
              iconTheme: IconThemeData(color: Colors.white),
              toolbarTextStyle: TextTheme(
                headline6: TextStyle(color: Colors.white, fontSize: 18),
              ).bodyText2,
              titleTextStyle: TextTheme(
                headline6: TextStyle(color: Colors.white, fontSize: 18),
              ).headline6,
              systemOverlayStyle: SystemUiOverlayStyle.light,
            ),
            backgroundColor: kgrey,
            body: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('From: ', style: TextStyle(color: kblack)),
                          DropdownButton<String>(
                            value: 'Kathmandu',
                            onChanged: (String? newValue) {},
                            items: <String>[
                              'Kathmandu',
                              'Pokhara',
                              'Chitwan',
                              'Lumbini',
                              'Bhaktapur'
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                    style: TextStyle(color: kgreen)),
                              );
                            }).toList(),
                            hint: Text('From', style: TextStyle(color: kgreen)),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text('To: ', style: TextStyle(color: kblack)),
                              DropdownButton<String>(
                                value: 'Pokhara',
                                onChanged: (String? newValue) {},
                                items: <String>[
                                  'Kathmandu',
                                  'Pokhara',
                                  'Chitwan',
                                  'Lumbini',
                                  'Bhaktapur'
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value,
                                        style: TextStyle(color: kblack)),
                                  );
                                }).toList(),
                                hint:
                                    Text('To', style: TextStyle(color: kblack)),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: kdarkpurple, // text color
                              ),
                              onPressed: () {},
                              child: Text('Search Route'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: routeModel!.vehicles.length,
                    itemBuilder: (BuildContext context, int index) {
                      String vehicle1 = routeModel!.vehicles[0].name;
                      String fare1 = routeModel!.vehicles[0].fares[0].fare;
                      String routess =
                          routeModel!.vehicles[0].routes[0].stops[0];

                      print(vehicle1);
                      print(fare1);
                      print(routess);
                      return Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(
                              'Vehicle $vehicle1 ',
                              style: TextStyle(
                                color: kblack,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // onTap: () => Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => RouteDesc(vehicle1),
                            //   ),
                            // ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 4.0),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time,
                                      size: 16.0,
                                      color: kblack,
                                    ),
                                    SizedBox(width: 4.0),
                                    Text(
                                      'Fare $fare1 ',
                                      style: TextStyle(
                                        color: kblack,
                                        fontSize: 14.0,
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
                                      'Routes $routess ',
                                      style: TextStyle(
                                        color: kblack,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.0),
                                // Row(
                                //   children: [
                                //     Icon(
                                //       Icons.location_on,
                                //       size: 16.0,
                                //       color: kblack,
                                //     ),
                                //     SizedBox(width: 4.0),
                                //     Expanded(
                                //       child: Text(
                                //         'Stops: ' + route['stops'].join(', '),
                                //         style: TextStyle(
                                //           color: kblack,
                                //           fontSize: 14.0,
                                //         ),
                                //         overflow: TextOverflow.ellipsis,
                                //         maxLines: 1,
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                SizedBox(height: 4.0),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
