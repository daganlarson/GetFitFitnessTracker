import 'package:flutter/material.dart';


class LogWorkout {
  late final String workoutId;
  late final String workoutTitle;
  late final String workoutDescription;
  late final String sets;


  LogWorkout({
    required this.workoutId,
    required this.workoutTitle,
    this.workoutDescription = '',


});
}

