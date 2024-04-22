import 'package:binarybrigade/models/workout.dart';
import 'package:flutter/material.dart';

import '../providers/DatabaseProvider.dart';

void saveWorkout() {
  final workout = Workout("now", DateTime.now(), DateTime.now().add(const Duration(hours: 2)), null);
  workout.addExercise(Exercise("Run", 200, 1000, "description"));
  Database.saveWorkout(workout);
}

void getWorkouts() async {
  DateTime now = DateTime.now();
  final List<Workout> workouts = await Database.getWorkouts(
      DateTimeRange(start: now.subtract(const Duration(days: 300)), end: now));
  Workout workout;
  for (workout in workouts) {
    print(workout.toString());
  }
}

Widget testFirebase() {
  return const ElevatedButton(onPressed: getWorkouts,
      child: Text("Test Firebase"));
}