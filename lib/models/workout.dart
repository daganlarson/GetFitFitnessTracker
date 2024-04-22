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

  void addExercises(Set<Exercise> exercises) {
    m_listOfExercises.addAll(exercises);
  }

  factory Workout.fromFireStore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options,) {
    final data = snapshot.data();
    print(data);
    final exerciseDocuments = data?['exercises'];
    print(exerciseDocuments);
    
    final exercises = exerciseDocuments.map((exerciseDocument) => Exercise.fromFirestore(exerciseDocument, options)).toSet();
    print(exercises);
    return Workout(
        data?['date'],
        data?['startTime'].toDate(),
        data?['endTime'].toDate(),
        null);
  }

  Map<String, dynamic> toFirestore() {
    return {
      'date': m_date,
      'startTime': m_timeStart,
      'endTime': m_timeEnd,
      'exercises': m_listOfExercises.map((exercise) => exercise.toFirestore()).toList(),
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

  Map<String, dynamic> toFirestore() {
    return {
      'exerciseType': m_exerciseType,
      'reps': m_numberOfReps,
      'weight': m_weightUsed,
      'description': m_exerciseDescription,
    };
  }

  factory Exercise.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options,) {
    final data = snapshot.data();
    return Exercise(data?['exerciseType'], data?['reps'], data?['weight'], data?['description']);
  }
}
