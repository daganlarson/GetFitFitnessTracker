import 'package:binarybrigade/models/workout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkoutWidget extends StatefulWidget {
  final Workout workout;
  const WorkoutWidget(this.workout, {super.key});

  @override
  State<StatefulWidget> createState() => _WorkoutWidgetState();

}

class _WorkoutWidgetState extends State<WorkoutWidget> {
  late Workout workout;

  @override
  void initState() {
    super.initState();
    workout = widget.workout;
  }

  @override
  Widget build(BuildContext context) {
    Duration duration = workout.m_timeEnd.difference(workout.m_timeStart);
    String hours = duration.inHours.toString();
    String date  = '${workout.m_timeStart.month.toString()}/${workout.m_timeStart.day.toString()} at ${workout.m_timeStart.toUtc()}';
    List<String> exerciseTypes = workout.m_listOfExercises.map((e) => e.m_exerciseType.toString()).toList();

    return GestureDetector(
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Material(
                  elevation: 14.0,
                  child: Center(
                      child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(children: <Widget>[
                            SizedBox(height: 10),
                            Text(
                              'Date: $date',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Exercise Types: ${exerciseTypes.join(', ')}',
                              style: TextStyle(fontSize: 10.0),
                            ),
                          ])))))),
    );
  }

}