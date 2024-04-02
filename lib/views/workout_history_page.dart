
import 'package:binarybrigade/models/workout.dart';
import 'dart:core';

import 'package:flutter/material.dart';
//import 'package:english_words/english_words.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_database/firebase_database.dart';

class WorkoutHistory extends StatefulWidget {
  const WorkoutHistory({super.key});

  @override
  _WorkoutHistoryState createState() => _WorkoutHistoryState();
}

class _WorkoutHistoryState extends State<WorkoutHistory> {
  // DatabaseReference dbRef = FirebaseDatabase.instance.ref('workouts');
  // final _biggerFont = const TextStyle(fontSize: 18.0);
  // final _saved = <WordPair>{};
  // List<Map<dynamic, dynamic>> dataList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout History'),
      ),
      body: ListView.builder(
        itemCount: previousWorkouts.length,
        itemBuilder: (context, index) {
          Workout workout = previousWorkouts[index];
          return ListTile(
            title: Text('Date: ${workout.m_date}'),
            subtitle: Text('Time Started: ${workout.m_timeStart.toString()}, Time Ended: ${workout.m_timeEnd.toString()}'),
            // Add more details as needed
          );
        },
      ),
    );
  }
}