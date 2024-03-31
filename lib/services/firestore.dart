
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../workout.dart';
import 'auth.dart';

abstract class BaseDatabase {
  Future<List<Workout>> getWorkouts(DateTimeRange range);
  Future<Workout> getWorkout();
  Future<Workout?> saveWorkout(Workout workout);
}

class Database implements BaseDatabase {
  final Auth _auth = Auth();
  String? _userId = "Vv3z8wmZVfgsby0yaj7agaQarL72";

  Future<bool> _authComplete() async {
    _userId = await _auth.getUserId();
    if (_userId == null) {
      throw Exception();
    }
    return _auth.authenticated();
  }


  @override
  Future<List<Workout>> getWorkouts(DateTimeRange range) async {
    if (await _authComplete()) {
      if (_userId == null) throw Exception();
      Query<Workout> query = FirebaseFirestore.instance.collection("users")
          .doc(_userId).collection('workouts')
          .withConverter(
          fromFirestore: Workout.fromFireStore,
          toFirestore: (Workout workout, options) => workout.toFirestore())
          .where('startTime', isGreaterThanOrEqualTo: range.start)
          .where('startTime', isLessThanOrEqualTo: range.end);
      var snapshot = await query.get();
      var snapshots = snapshot.docs;
      List<Workout> data = [];
      for (var x in snapshots) {
        data.add(x.data());
      }
      return data;
    }
    throw Exception();
  }

  @override
  Future<Workout> getWorkout() async {
    if (await _authComplete()) {
      final ref = await FirebaseFirestore.instance.collection("users")
          .doc(_userId)
          .collection("workouts")
          .withConverter(
          fromFirestore: Workout.fromFireStore,
          toFirestore: (Workout workout, options) => workout.toFirestore())
          .orderBy('startTime').limit(1).get();
      final stuff = ref.docs;
      QueryDocumentSnapshot<Workout> documentSnapshot = stuff[0];
      Workout workout = documentSnapshot.data();
      return workout;
    }
    throw Exception("unable to get workout");
  }

  @override
  Future<Workout?> saveWorkout(Workout workout) async {
    if (await _authComplete()) {
      var result = await FirebaseFirestore.instance
          .collection("users")
          .doc(_userId)
          .collection("workouts")
          .withConverter(fromFirestore: Workout.fromFireStore,
          toFirestore: (Workout workout, options) => workout.toFirestore())
          .add(workout);
      return workout;
    }
    return null;
  }
}