import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'workout.dart';


class Database {
  static Future<List<Workout>> getWorkouts(DateTimeRange range) async {
      if (FirebaseAuth.instance.currentUser == null) throw Exception();
      String userId = FirebaseAuth.instance.currentUser!.uid;

      Query<Workout> query = FirebaseFirestore.instance.collection("users")
          .doc(userId).collection('workouts')
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

  static Future<Workout> getWorkout() async {
    if (FirebaseAuth.instance.currentUser == null) throw Exception();
    String userId = FirebaseAuth.instance.currentUser!.uid;

    final ref = await FirebaseFirestore.instance.collection("users")
          .doc(userId)
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

  @override
  static Future<bool> saveWorkout(Workout workout) async {
    if (FirebaseAuth.instance.currentUser == null) throw Exception();
    String userId = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance
        .collection("users")
        .doc(userId).collection("workouts")
        .withConverter(
        fromFirestore: Workout.fromFireStore,
        toFirestore: (Workout workout, options) => workout.toFirestore())
        .add(workout);
    return true;
  }
}