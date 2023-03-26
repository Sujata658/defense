import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart' show Marker;
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:timelines/timelines.dart';

// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './components/constants.dart';
import './components/searchbar.dart';
import './components/searchbar2.dart';
import './searchresult.dart';

import 'VehicleDesc.dart';
import 'menu/aboutus.dart';
import 'menu/news.dart';
import 'menu/notifications.dart';
import 'menu/profile.dart';
// import 'menu/setting.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false, // Set this to false
        home: MyHomePage(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kasari Jaane',
      theme: ThemeData(
        primaryColor: ktheme,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.green),
      ),
      home: MyHomePage(),
    );
  }
}

class VehicleMain {
  final String name;
  final IconData icon;

  VehicleMain({required this.name, required this.icon});
}

List<Map<String, dynamic>> menuItems = [
  {
    'icon': Icons.person_outlined,
    'label': 'Profile',
    'widget': ProfilePage(),
  },
  {
    //todo add your location feature here
    'icon': Icons.map_outlined,
    'label': 'Find Routes',
    'widget': SearchResultPage(
      starting: 'pulchowk',
      destination: 'ratnapark',
    ),
  },
  {
    'icon': Icons.notifications_outlined,
    'label': 'Notifications',
    'widget': NotificationPage(),
  },
  {
    'icon': Icons.info_outline,
    'label': 'About Us',
    'widget': AboutUs(),
  },
];
List<VehicleMain> vehicles = [
  VehicleMain(name: 'Micro', icon: Icons.directions_car),
  VehicleMain(name: 'Sajha Bus', icon: Icons.directions_bus),
  VehicleMain(name: 'Public Bus', icon: Icons.directions_bike),
  VehicleMain(name: 'Tempo', icon: Icons.directions_railway),
];

List<String> places = [
  'Ratnapark-Buspark',
  'Buspark-Lagankhel',
  'Kalanki-Koteshwor',
  'Airport-Bhaktapur',
];

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController startingPointController = TextEditingController();

  TextEditingController destinationController = TextEditingController();
  final MapController mapController = MapController();
  MapOptions _mapOptions =
      MapOptions(center: LatLng(27.712020, 85.312950), zoom: 13.0);
  LatLng userLocation = LatLng(27.712020, 85.312950);
  final List<Marker> markers = [];
  // StreamSubscription<LocationData> _locationSubscription =
  //     StreamSubscription<LocationData>.empty();
  // LocationData _currentLocation =
  //     LocationData.fromMap({"latitude": 0.0, "longitude": 0.0});

  void _addMarker(LatLng point) {
    setState(() {
      markers.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: point,
          builder: (ctx) => Container(
            child: Icon(Icons.location_on, color: ktheme),
          ),
        ),
      );
    });
  }

  Future<LatLng> _getUserLocation() async {
    final position = await Geolocator.getCurrentPosition();
    userLocation = LatLng(position.latitude, position.longitude);
    print('position is $position ');
    return LatLng(position.latitude, position.longitude);
  }

  Future<void> _setupMapOptions() async {
    userLocation = await _getUserLocation();
    print('userLocation is $userLocation');
    setState(() {
      _mapOptions = MapOptions(center: userLocation, zoom: 13.0);
    });
  }
// In the FlutterMap widget

  @override
  void initState() {
    super.initState();
    // _locationSubscription =
    //     Location().onLocationChanged.listen((LocationData locationData) {
    setState(() {
      // _currentLocation = locationData;
    });
    // });
    _setupMapOptions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite,
      appBar: AppBar( 
        backgroundColor: kwhite,
        foregroundColor: ktheme,
        title: RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: 'Kasari ',
                style: TextStyle(color: kdarkblue,fontSize: 30, fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: 'Jaane?',
                style: TextStyle(color: ktheme,fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          height: 20,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: kwhite,
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(Icons.commute_outlined, size: 50, color: kdarkblue,) ,
                    ),
                    Text(
                      'Kasari Jaane',
                      style: TextStyle(
                        color: ktheme,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              for (var item in menuItems)
                ListTile(
                  leading: Icon(
                    item['icon'],
                    color: ktheme,
                  ),
                  title: Text(item['label']),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => item['widget'],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Container(
          color: kdarkblue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(
                   // set the height to your desired value
                  child: FlutterMap(
                    mapController: mapController,
                    options: _mapOptions,
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: userLocation,
                            width: 80,
                            height: 80,
                            builder: (ctx) => Container(
                              child: Icon(
                                Icons.location_on,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // const Padding(
              //   padding: EdgeInsets.all(10.0),
              //   child: Text(
              //     'Find your routes',
              //     style: TextStyle(
              //       fontSize: 18,
              //       fontWeight: FontWeight.normal,
              //     ),
              //     textAlign: TextAlign.left,
              //   ),
              // ),
              SearchBar2(
                label: 'Starting Point',
                controller: startingPointController,
              ),
              SearchBar(
                label: 'Destination',
                controller: destinationController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: ktheme, // text color
                        minimumSize: Size(200, 50),
                      ),
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(0),
                      // ),
                      onPressed: () {
                        String startingPoint = startingPointController.text;
                        String destination = destinationController.text;
                        print('Starting point $startingPoint');
                        print(destination);
                        if (startingPoint.isEmpty || destination.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Error'),
                              content: Text('Please fill in both fields.'),
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
                  ),
                ],
              ),
              // Expanded(
              //   child: Card(
              //     margin: EdgeInsets.all(5),
              //     color: kwhite,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     child: ListView.builder(
              //       itemCount: vehicles.length,
              //       itemBuilder: (BuildContext context, int index) {
              //         return ListTile(
              //           iconColor: kblack,
              //           textColor: kblack,
              //           leading: Icon(vehicles[index].icon),
              //           title: Text(vehicles[index].name),
              //           onTap: (() => Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                   builder: (context) =>
              //                       VehicleDesc(vehicles[index]),
              //                 ),
              //               )),
              //         );
              //       },
              //     ),
              //   ),
              // ),
              // Expanded(
              //   child: Card(
              //     margin: EdgeInsets.all(5),
              //     color: kwhite,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     child: ListView.builder(
              //       itemCount: places.length,
              //       itemBuilder: (BuildContext context, int index) {
              //         final startingAndDestination = places[index].split('-');
              //         final starting = startingAndDestination[0];
              //         final destination = startingAndDestination[1];
        
              //         return ListTile(
              //           onTap: () => Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //               builder: (context) => SearchResultPage(
              //                 starting: starting,
              //                 destination: destination,
              //               ),
              //             ),
              //           ),
              //           iconColor: kblack,
              //           textColor: kblack,
              //           title: Text(places[index]),
              //         );
              //       },
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
