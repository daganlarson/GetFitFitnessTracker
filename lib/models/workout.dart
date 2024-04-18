import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Workout {

  late String m_date;
  late DateTime m_timeStart;
  late DateTime m_timeEnd;
  late var m_listOfExercises = <Exercise>{};

  Workout(String date, DateTime timeStart, DateTime timeEnd, Set<Exercise>? exercises) {
    m_date = date;
    m_timeStart = timeStart;
    m_timeEnd = timeEnd;
    if (exercises != null) {
      m_listOfExercises = exercises;
    }
  }
  void addExercise(Exercise myExercise) {
    m_listOfExercises.add(myExercise);
  }

  factory Workout.fromFireStore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options,) {
    final data = snapshot.data();
    return Workout(
        data?['date'],
        data?['startTime'].toDate(),
        data?['endTime'].toDate(),
        data?['exercises'] is Iterable ? Set.from(data?['exercises']) : null);
  }

  Map<String, dynamic> toFirestore() {
    return {
      'date': m_date,
      'startTime': m_timeStart,
      'endTime': m_timeEnd,
      if (m_listOfExercises != null) 'exercises': m_listOfExercises,
    };
  }

  @override
  String toString() {
    return '{"date": "$m_date", "startTime": $m_timeStart, "endTime": $m_timeEnd, "exercises": $m_listOfExercises}';
  }
}

class Exercise {

  late String m_exerciseType;
  late int m_numberOfReps;
  late int m_weightUsed;
  late String m_exerciseDescription;

  Exercise(String exerciseType, int numOfReps, int weight, String exerciseDesc) {
    m_exerciseType = exerciseType;
    m_numberOfReps = numOfReps;
    m_weightUsed = weight;
    m_exerciseDescription = exerciseDesc;
  }
}
