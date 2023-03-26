import 'package:flutter/material.dart';
import 'package:kasarijaane/components/searchbar.dart';
import 'package:kasarijaane/driver/homepage.dart';
import 'components/constants.dart';
import './passenger/explore.dart';
import './passenger/notification.dart';
import './passenger/Profile.dart';
import './mainhome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    MainHome(),
    Explore(),
    NotificationPage(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: SizedBox(
        height: 70.0,
        child: BottomNavigationBar(
          backgroundColor: kdarkpurple,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications_outlined),
                label: 'Notification'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: 'Profile'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: kbrightgreen,
          unselectedItemColor: kgreen,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
