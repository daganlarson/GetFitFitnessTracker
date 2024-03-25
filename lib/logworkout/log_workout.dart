import 'package:flutter/material.dart';
import 'package:binarybrigade/workout.dart';
import 'package:flutter/services.dart';

void main() {
  //this is just for testing the file right now:
  Workout workout = Workout('2024-03-18', DateTime.now(), DateTime.now());
  Exercise exercise = Exercise('Running', 10, 100);

  // Run the app with LogWorkout widget
  runApp(MaterialApp(home: LogWorkout(workout: workout, exercise: exercise)));
}

class LogWorkout extends StatelessWidget {
  const LogWorkout({
    Key? key,
    required this.workout,
    required this.exercise,
  }) : super(key: key);

  final Workout workout;
  final Exercise exercise;

  //logs the workout
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Log Workout')), // Centering the title
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Log Workout'),
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //input fields!
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Date',
                                icon: Icon(Icons.calendar_month)),
                            initialValue: workout.m_date,
                            keyboardType: TextInputType.datetime,
                            onChanged: (value) {
                              workout.m_date = value;
                            },
                          ),
                          _buildTimePicker(
                            context,
                            workout.m_timeStart,
                            'Time Started',
                                (time) {
                                workout.m_timeStart = time!;
                                },
                          ),
                          _buildTimePicker(
                            context,
                            workout.m_timeEnd,
                            'Time Ended',
                              (time) {
                              workout.m_timeEnd = time!;
                              },
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Exercise Type',
                                icon: Icon(Icons.directions_run)),
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
                            decoration: const InputDecoration(
                                labelText: 'Reps', icon: Icon(Icons.numbers)),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              workout.m_listOfExercises.forEach((exercise) {
                                exercise.m_numberOfReps = int.parse(value);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          // Save workout
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
                    ],
                  );
                },
              );
            },
            child: Text('Log Workout'),
          ),
        ));
  }

  void saveWorkout(Workout workout) {
    //save to database here
    print('Workout logged: $workout');
  }

  Widget _buildTimePicker(BuildContext context, DateTime initialTime, String label, Function(DateTime?) onChanged) {
    return GestureDetector(
      onTap: () async {
        final pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(initialTime),
        );
        if (pickedTime != null) {
          onChanged(DateTime(
            0,
            0,
            0,
            pickedTime.hour,
            pickedTime.minute,
          ));
        }
      },
      child: AbsorbPointer(
        child: TextFormField(
          decoration: InputDecoration(
            labelText: label,
            icon: Icon(Icons.watch_later),
          ),
          controller: TextEditingController(
            text: initialTime != null
                ? TimeOfDay.fromDateTime(initialTime).format(context)
                : '',
          ),
          keyboardType: TextInputType.datetime,
        ),
      ),
    );
  }
}
