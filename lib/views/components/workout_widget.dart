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
    final defaultTextStyle = TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimary);
    Duration duration = workout.m_timeEnd.difference(workout.m_timeStart);
    String hours = duration.inHours.toString();
    String date  = '${workout.m_timeStart.month.toString()}/${workout.m_timeStart.day.toString()}';
    List<String> exerciseTypes = workout.m_listOfExercises.map((e) => e.m_exerciseType.toString()).toList();

    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.secondary),
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Date: ${date}',
              style: defaultTextStyle,
            ),
            SizedBox(height: 8.0),
            Text(
              'Duration: ${hours} hours',
              style: defaultTextStyle,
            ),
            SizedBox(height: 8.0),
            Text(
              'Exercise Types: ${exerciseTypes.join(', ')}',
              style:defaultTextStyle,
            ),
          ],
        ),
      )
    ),
    );
  }

}