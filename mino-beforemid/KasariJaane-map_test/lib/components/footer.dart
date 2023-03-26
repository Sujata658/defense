import 'package:flutter/material.dart';
import 'constants.dart';

class FooterNavBar extends StatefulWidget {
  @override
  FooterNavBarState createState() => FooterNavBarState();
}

class FooterNavBarState extends State<FooterNavBar> {
  int _selectedIndex = 0;

  final _iconList = [
    const Icon(Icons.home_outlined),
    const Icon(Icons.explore_outlined),
    const Icon(Icons.feed_outlined),
    const Icon(Icons.notifications_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: kdarkpurple,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: _iconList[0],
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: _iconList[1],
          label: 'Explore'
        ),
        BottomNavigationBarItem(
          icon: _iconList[2],
          label: 'Feed'
        ),
        BottomNavigationBarItem(
          icon: _iconList[3],
          label: 'Notification'
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: kbrightgreen,
      unselectedItemColor: kgreen,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }
}
