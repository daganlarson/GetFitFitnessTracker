import 'package:binarybrigade/models/workout.dart';
import 'package:flutter/material.dart';

import '../providers/DatabaseProvider.dart';

void saveWorkout() {
  final workout = Workout("now", DateTime.now(), DateTime.now().add(const Duration(hours: 2)), null);
  workout.addExercise(Exercise("Run", 200, 1000, "description"));
  Database.saveWorkout(workout);
}

void getWorkouts() async {
  print("get workouts called");
  DateTime now = DateTime.now();
  final List<Workout> workouts = await Database.getWorkouts(
      DateTimeRange(start: now.subtract(const Duration(days: 300)), end: now));
  print("workouts recieved");
  print(workouts);
  Workout workout;
  for (workout in workouts) {
    print(workout.toString());
  }
}

Widget testFirebase() {
  return const Column( children: [
    ElevatedButton(onPressed: getWorkouts, child: Text("Get Workouts")),
    ElevatedButton(onPressed: saveWorkout, child: Text("Save Workout")),
  ],);
}