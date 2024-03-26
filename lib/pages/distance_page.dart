import 'package:flutter/material.dart';
import 'package:binarybrigade/distancetracker.dart';

class DistancePage extends StatefulWidget {
  DistancePage({super.key});

  DistanceTracker myTracker = DistanceTracker();
  bool distanceTrackerToggle = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Distance Tracker'
        )
      ),
      body:
        ElevatedButton(

          child: const Text('Track Distance'),
          onPressed: () {
            distanceTrackerToggle = !distanceTrackerToggle;
            if (distanceTrackerToggle) {
              myTracker.trackDistanceTraveled();
            }
          },
        ),
      bottomSheet:
        Text('The distance of your workout was: ${myTracker.getDistance()}. The time it took to complete your workout was: ${myTracker.m_difference}' ),

    );
  }
  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

}
