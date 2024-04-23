import 'package:binarybrigade/models/workout.dart';
import 'package:flutter/cupertino.dart';

class WorkoutWidget extends StatefulWidget {

  const WorkoutWidget(Workout workout, {super.key});

  @override
  State<StatefulWidget> createState() => _WorkoutWidgetState();

}

class _WorkoutWidgetState extends State<WorkoutWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(color: Color.fromRGBO(20, 20, 255, 0.5),),
        child: const Column(
          children: [
          Text("Workout"),
          ]
        )
    ),
    );
  }

}