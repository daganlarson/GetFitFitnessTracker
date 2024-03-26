//import 'dart:html';

import 'package:binarybrigade/pages/calendar_page.dart';
import 'package:binarybrigade/pages/distance_page.dart';
import 'package:binarybrigade/pages/person_page.dart';
import 'package:binarybrigade/pages/settings_page.dart';
import 'package:flutter/material.dart';

import 'distancetracker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Home'),
    ),
    body: Center(child: Text('Home Page')),
  );

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //=> Scaffold(
      //body: screens[pageIndex],
        body: Center(
          child: ElevatedButton(
            child: const Text('Track Distance'),
            onPressed: () {
              distanceTrackerToggle = !distanceTrackerToggle;
              if (distanceTrackerToggle) {
                myTracker.trackDistanceTraveled();
              }
            },
          ),
        )
    );
  }
 /*

        bottomNavigationBar: NavigationBar(
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
        ),
  ); */
  
}
