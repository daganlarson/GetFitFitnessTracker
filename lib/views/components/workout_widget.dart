import 'package:binarybrigade/models/workout.dart';
import 'package:flutter/cupertino.dart';

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
    String time = '${workout.m_timeStart.month.toString()}/${workout.m_timeStart.day.toString()} at ${workout.m_timeStart.toUtc()}';

    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          const SizedBox(height: 8,),
            Text(time),

          ]
        )
    ),
    );
  }

}