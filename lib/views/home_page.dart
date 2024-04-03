import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../distancetracker.dart';
import 'distance_page.dart';
import 'eventwidget.dart';
import '../main.dart';
import 'settings_page.dart';
import 'workout_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Center(child: Text('Home Page')),
      );


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DistanceTracker myTracker = DistanceTracker();
  bool distanceTrackerToggle = false;
  int pageIndex = 0;

  final screens = [
    Center(child:
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        EventWidget(eventList[2]),
        SizedBox(height:15),
        EventWidget(eventList[1]),
        SizedBox(height:15),
        EventWidget(eventList[0]),
      ],
    )),
    const SettingsPage(),
    const WorkoutPage(),
    const Center(child: Text('calendar')),
    DistancePage(),
  ];

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.pop(context);
    }

    return Scaffold(
        body: screens[pageIndex],
        bottomNavigationBar:
        NavigationBar(
          onDestinationSelected: (pageIndex) =>
              setState(() => this.pageIndex = pageIndex),
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.home),
                label: 'Home'
            ),
            NavigationDestination(
                icon: Icon(Icons.settings),
                label: 'Settings'
            ),
            NavigationDestination(
                icon: Icon(Icons.person),
                label: 'Person'
            ),
            NavigationDestination(
                icon: Icon(Icons.calendar_month),
                label: 'Calendar'
            ),
            NavigationDestination(
                icon: Icon(Icons.explore),
                label: 'Distance'
            )
          ],
        )
    );
  }
}