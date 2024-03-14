import 'package:flutter/material.dart';

class Workout {

  late String m_date;
  late DateTime m_timeStart;
  late DateTime m_timeEnd;
  late var m_listOfExercises = <Exercise>{};

  Workout(String date, DateTime timeStart, DateTime timeEnd) {

    m_date = date;
    m_timeStart = timeStart;
    m_timeEnd = timeEnd;
  }
  void addExercise(Exercise myExercise) {
    m_listOfExercises.add(myExercise);
  }
}

class Exercise {

  late String m_exerciseType;
  late int m_numberOfReps;
  late int m_weightUsed;

  Exercise(String exerciseType, int numOfReps, int weight) {
    m_exerciseType = exerciseType;
    m_numberOfReps = numOfReps;
    m_weightUsed = weight;
  }
}
