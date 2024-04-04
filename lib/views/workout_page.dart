
import 'package:binarybrigade/views/workout_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/workout.dart';
import 'log_workout.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Workout Page'),
    ),
    body: Center(child: Text('Settings Page')),
  );

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        WorkoutWidget(Workout("Today", DateTime.now(), DateTime.now(), null)),
              LogWorkout(
                workout: Workout("Now", DateTime.now(), DateTime.now(), null),
                exercise: Exercise('Running', 10, 100)),
    ]),
    
    );

  }

}