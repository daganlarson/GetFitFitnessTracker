import 'package:flutter/material.dart';
import 'package:binarybrigade/workout.dart';
import 'package:flutter/services.dart';


class LogWorkout extends StatelessWidget {

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
                decoration: InputDecoration(labelText: 'Date'),
                keyboardType: TextInputType.datetime, //i think?
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Exercise Description'),
                keyboardType: TextInputType.text,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Exercise Type'),
                keyboardType: TextInputType.text,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Reps'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Weight'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
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


