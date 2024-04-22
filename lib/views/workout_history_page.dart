
import 'package:binarybrigade/models/workout.dart';
import 'package:binarybrigade/models/firestore.dart';
import 'package:binarybrigade/views/components/log_workout.dart';
import 'dart:core';

import 'package:flutter/material.dart';

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
          itemCount: 0, // Set itemCount to 0 for an empty list
          itemBuilder: (context, index) {
            // Return an empty container since there are no items to display
            return Container();
          },
        ),
      );
    }
}