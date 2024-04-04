
import 'package:binarybrigade/views/workout_history_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:binarybrigade/models/firestore.dart';

import '../models/workout.dart';
import 'log_workout.dart';

//this will now be the history page with a floating log workout button!

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Workout Page'),
    ),
    body: Center(child: Text('Settings Page')),
  );

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {

  //Floating add button that adds a workout
  // The FAB's foregroundColor, backgroundColor, and shape
  static const List<(Color?, Color? background, ShapeBorder?)> customizations =
  <(Color?, Color?, ShapeBorder?)>[
  (null, null, null), // The FAB uses its default for null parameters.
  (null, Colors.blue, null),
  (Colors.white, Colors.blue, null),
  (Colors.white, Colors.blue, CircleBorder()),
  ];
  int index = 0; // Selects the customization.


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //buttons used to be here
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LogWorkout(
              workout: Workout("Now", DateTime.now(), DateTime.now(), null),
              exercise: Exercise('Running', 10, 100),
            )),
          );
          setState(() {
            index = (index + 1) % customizations.length;
          });
        },
        foregroundColor: customizations[index].$1,
          backgroundColor: customizations[index].$2,
        shape: customizations[index].$3,
        child: const Icon(Icons.add),
      ),
    );
  }

}

