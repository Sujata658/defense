import 'package:flutter/material.dart';
import './components/constants.dart';
import './components/searchbar.dart';
import './searchresult.dart';

import 'VehicleDesc.dart';
import 'menu/aboutus.dart';
import 'menu/news.dart';
import 'menu/notifications.dart';
import 'menu/profile.dart';
// import 'menu/setting.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kasari Jaane',
      theme: ThemeData(
        primaryColor: kdarkpurple,
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
    'icon': Icons.person,
    'label': 'Profile',
    'widget': ProfilePage(),
  },
  {
    //todo add your location feature here
    'icon': Icons.map,
    'label': 'Find Routes',
    'widget': SearchResultPage(
      starting: 'pulchowk',
      destination: 'ratnapark',
    ),
  },
  {
    'icon': Icons.library_books,
    'label': 'News',
    'widget': NewsPage(),
  },
  {
    'icon': Icons.notifications,
    'label': 'Notifications',
    'widget': NotificationPage(),
  },
  {
    'icon': Icons.info,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kgrey,
      appBar: AppBar(
        title: Text('Kasari Jaane'),
        backgroundColor: kdarkpurple,
      ),
      drawer: Drawer(
        child: Container(
          height: 20,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: kdarkpurple,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              for (var item in menuItems)
                ListTile(
                  leading: Icon(item['icon']),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Where do you want to go?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('New York, USA'),
              subtitle: Text("Empire State Building"),
              // onTap: () => _setDemoLocation(context, demoAddressNewYork),
              trailing: Icon(Icons.chevron_right),
            ),
            SearchBar(
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: kdarkpurple, // text color
                  ),
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
              ],
            ),
            Expanded(
              child: Card(
                margin: EdgeInsets.all(5),
                color: kwhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                  itemCount: vehicles.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      iconColor: kblack,
                      textColor: kblack,
                      leading: Icon(vehicles[index].icon),
                      title: Text(vehicles[index].name),
                      onTap: (() => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  VehicleDesc(vehicles[index]),
                            ),
                          )),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Card(
                margin: EdgeInsets.all(5),
                color: kwhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                  itemCount: places.length,
                  itemBuilder: (BuildContext context, int index) {
                    final startingAndDestination = places[index].split('-');
                    final starting = startingAndDestination[0];
                    final destination = startingAndDestination[1];

                    return ListTile(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchResultPage(
                            starting: starting,
                            destination: destination,
                          ),
                        ),
                      ),
                      iconColor: kblack,
                      textColor: kblack,
                      title: Text(places[index]),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
