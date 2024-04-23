import 'package:binarybrigade/models/workout.dart';
import 'package:binarybrigade/views/components/workout_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../distancetracker.dart';
import '../models/appTheme.dart';
import 'benefits_page.dart';
import 'components/workout_feed.dart';
import 'distance_page.dart';
import 'components/eventwidget.dart';
import '../main.dart';
import 'event_page.dart';
import 'settings_page.dart';
import 'workout_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DistanceTracker myTracker = DistanceTracker();
  bool distanceTrackerToggle = false;
  int pageIndex = 0;

  final screens = [
    const WorkoutPage(),
    Column(children: [
      WorkoutWidget(
        Workout(null,
          DateTime.now().subtract(const Duration(hours: 2)),
          DateTime.now(),
          {Exercise("Walk", 0,0, "I walked")}
        )
        ),]),
    WorkoutFeed(),
    const SettingsPage()
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
          selectedIndex: pageIndex,
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.home),
                label: 'Workout'
            ),
            NavigationDestination(
                icon: Icon(Icons.calendar_month),
                label: 'Events'
            ),
            NavigationDestination(
                icon: Icon(Icons.explore),
                label: 'Benefits'
            ),
            NavigationDestination(
                icon: Icon(Icons.settings),
                label: 'Settings'
            ),
          ],
        )
    );
  }
}