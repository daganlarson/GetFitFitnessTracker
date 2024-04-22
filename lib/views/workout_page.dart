import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:binarybrigade/providers/DatabaseProvider.dart';
import 'package:flutter/widgets.dart';
import 'package:googleapis/apigeeregistry/v1.dart';
import 'package:googleapis/firestore/v1.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../distancetracker.dart';
import '../models/appTheme.dart';
import '../models/workout.dart';
import 'components/log_workout.dart';

//this will now be the history page with a floating log workout button!

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StopWatchTimer _myStopWatch = StopWatchTimer();
  final _isHours = true;
  DistanceTracker _myTracker = DistanceTracker();



  //Floating add button that adds a workout
  // The FAB's foregroundColor, backgroundColor, and shape
  static const List<(Color?, Color? background, ShapeBorder?)> customizations =
      <(Color?, Color?, ShapeBorder?)>[
    (null, null, null), // The FAB uses its default for null parameters.
    (null, Colors.blue, null),
    (Colors.white, Colors.blue, null),
    (Colors.white, Colors.blue, CircleBorder()),
  ];
  int index = 0; // Selects the customization.

  @override
  void dispose() {
    super.dispose();
    _myStopWatch.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text('Workout Page'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //CHART stuff
            Container(
              height: 300,
              width: 300,
              child: const SfCartesianChart(
                //chart stuff
                //minutes exercised over last 7 (week) days column chart
                primaryXAxis: CategoryAxis(),
                title: ChartTitle(text: 'Minutes Exercised Weekly'),
                legend: Legend(isVisible: true),

                series: [
                ],
              ),
          ),
          // StreamBuilder for displaying workout data
          StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('workouts').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final workoutData =
                            snapshot.data!.docs[index].data(); //getting errors
                        //final workout = workoutData['workout'];
                        return Stack(children: <Widget>[
                          Container(
                              width: MediaQuery.of(context).size.width,
                              height: 350.0,
                              child: const Padding(
                                  padding:
                                      EdgeInsets.only(top: 8.0, bottom: 8.0),
                                  child: Material(
                                      elevation: 14.0,
                                      child: Center(
                                          child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Column(
                                                  children: <Widget>[]))))))
                        ]);
                      });
                }
              }),
          //const SizedBox(
            //height: 20,
          //),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(280,80),
                    ),
                    onPressed: () {
                      print('distance tracking button pressed');
                      _myTracker.m_locationToggle = !_myTracker.m_locationToggle;
                      if (_myTracker.m_locationToggle) {
                        //_myStopWatch.onExecute.add(StopWatchExecute.reset);
                        _myStopWatch.onExecute.add(StopWatchExecute.start);
                        _myTracker.trackDistanceTraveled();

                      } else {
                        _myStopWatch.onExecute.add(StopWatchExecute.stop);
                      }

                    },
                    child: const Column(
                        children: [
                          Icon(Icons.play_circle_fill),
                          Text('Distance Tracking Workout')
                        ]
                    )
                ),
                StreamBuilder<int>(
                  stream: _myStopWatch.rawTime,
                  initialData: _myStopWatch.rawTime.value,
                  builder: (context, snapshot){
                    final value = snapshot.data;
                    final displayTime = StopWatchTimer.getDisplayTime(value!, hours: _isHours);

                    return Text(displayTime, style: const TextStyle(
                        fontSize: 40, fontWeight: FontWeight.bold));
                  },
                ),
              Text(_myTracker.m_distanceTraveled.toString(), style: const TextStyle(
                  fontSize: 40, fontWeight: FontWeight.bold)),
              ]
            )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LogWorkout(
                workout: Workout("Now", DateTime.now(), DateTime.now(), null),
                exercise: Exercise('Running', 10, 100, "I ran"),
              ),
            ),
          ).then((_) {
            setState(() {
              index = (index + 1) % customizations.length;
            });
          });
        },
        foregroundColor: customizations[index].$1,
        backgroundColor: customizations[index].$2,
        shape: customizations[index].$3,
        child: Icon(Icons.add),
      ),
    );

  }
}
