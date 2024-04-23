
import 'package:binarybrigade/views/components/workout_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../models/workout.dart';

class WorkoutFeed extends StatefulWidget {
  @override
  State<WorkoutFeed> createState() => _WorkoutFeedState();
}

class _WorkoutFeedState extends State<WorkoutFeed> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> _workouts = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadWorkouts();
  }

  Future<void> _loadWorkouts() async {
    if (FirebaseAuth.instance.currentUser == null) throw Exception();
    String userId = FirebaseAuth.instance.currentUser!.uid;

    if (!_loading) {
      setState(() {
        _loading = true;
      });
    }

    QuerySnapshot querySnapshot;
    if (_workouts.isEmpty) {
      querySnapshot = await _firestore.collection("users")
          .doc(userId)
          .collection('workouts')
          .orderBy('startTime', descending: true)
          .limit(10)
          .withConverter(
            fromFirestore: Workout.fromFireStore,
            toFirestore: (Workout workout, options) => workout.toFirestore()
          ).get();
    } else {
      querySnapshot = await _firestore.collection("users")
        .doc(userId)
        .collection('workouts')
        .orderBy('startTime', descending: true)
        .startAfterDocument(_workouts.last)
        .limit(10)
        .withConverter(
          fromFirestore: Workout.fromFireStore,
          toFirestore: (Workout workout, options) => workout.toFirestore()
        ).get();
    }

    setState(() {
      _workouts.addAll(querySnapshot.docs);
      _loading = false;
    });
  }

  bool _onEndOfPage(ScrollNotification notification) {
    if (notification is ScrollEndNotification && notification.metrics.extentAfter == 0) {
      _loadWorkouts();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _onEndOfPage,
      child: ListView.builder(
        itemCount: _workouts.length,
        itemBuilder: (context, index) {
          if (!_workouts[index].exists) {throw Exception();}

          Workout? workout = _workouts[index].data() as Workout?;
          return WorkoutWidget(workout!);
        },
      ),
    );
  }
}