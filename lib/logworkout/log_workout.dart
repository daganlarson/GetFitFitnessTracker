
import 'package:flutter/material.dart';
import 'package:binarybrigade/workout.dart';
import 'package:flutter/services.dart';


class LogWorkout extends StatelessWidget {
  const LogWorkout(
  {super.key, required this.workout, required this.exercise});

  final Workout workout;
  final Exercise exercise;

  //logs the workout
  @override
  Widget build(BuildContext context) {
    //logging workout UI
    //why is dart so weird
    showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Log Workout'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //input fields!
              TextFormField(
                decoration: const InputDecoration(labelText: 'Date'),
                initialValue: workout.m_date,
                keyboardType: TextInputType.datetime,
                onChanged: (value) {
                  workout.m_date = value;
                }
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Exercise Type'),
                initialValue: exercise.m_exerciseType,
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  workout.m_listOfExercises.forEach((exercise) {
                    exercise.m_exerciseType = value;
                  });
                },
              ),
              // TextFormField(
              //   decoration: InputDecoration(labelText: 'Exercise Description'),
              //   keyboardType: TextInputType.text,
              //   onChanged: (value) {
              //     workout.m_listOfExercises.forEach((exercise) {
              //       exercise.m_exerciseDescription = value;
              //     });
              //   },
              // ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Reps'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  workout.m_listOfExercises.forEach((exercise) {
                    exercise.m_numberOfReps = int.parse(value);
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Weight'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  workout.m_listOfExercises.forEach((exercise) {
                    exercise.m_weightUsed = int.parse(value);
                  });
                },
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              //Save workout
              saveWorkout(workout);
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          )
          ]
      );
    },
    );
    throw UnimplementedError();
  }

  void saveWorkout(Workout workout) {
    //save to database here

    print('Workout logged: $workout');
  }
}


