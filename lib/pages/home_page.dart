import 'package:binarybrigade/pages/settings_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../distancetracker.dart';
import '../eventwidget.dart';
import '../main.dart';
import '../workout.dart';
import 'log_workout.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;
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
  User? user = FirebaseAuth.instance.currentUser;
  DistanceTracker myTracker = DistanceTracker();
  bool distanceTrackerToggle = false;
  int pageIndex = 0;
  //these screens are the different pages that will be connected to the tabs
  /*final screens = [
    MyHomePage(),
    SettingsPage(),
    PersonPage(),
    CalendarPage(),
    DistancePage(),
  ]; */
  final screens2 = [
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
    Center(child: LogWorkout(workout: Workout("Now", DateTime.now(), DateTime.now(), null), exercise: Exercise('Running', 10, 100))),
    const Center(child: Text('calendar')),
    const Center(child: Text('explore')),
  ];

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.pop(context);
    }

    return Scaffold(
        body: screens2[pageIndex],
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
                label: 'Explore'
            )
          ],
        )
    );
  }
}