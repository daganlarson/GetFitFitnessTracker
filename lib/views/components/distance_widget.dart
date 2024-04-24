import 'package:flutter/material.dart';
import 'package:binarybrigade/distancetracker.dart';

class DistancePage extends StatefulWidget {
  DistancePage({super.key});
  
  @override
  _DistancePageState createState() => _DistancePageState();
}

class _DistancePageState extends State<DistancePage> {

  DistanceTracker myTracker = DistanceTracker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //=> Scaffold(
      //body: screens[pageIndex],
        body: Center(
          child: ElevatedButton(
            child: const Text('Track Distance'),
            onPressed: () {
              myTracker.m_locationToggle = !myTracker.m_locationToggle;
              if (myTracker.m_locationToggle) {
                myTracker.trackDistanceTraveled();
              }
            },
          ),
        )
    );
  }
}
