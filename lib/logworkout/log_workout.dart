import 'package:flutter/material.dart';
import 'package:binarybrigade/workout.dart';


class LogWorkout {

  //logs the workout
  void logWorkout(BuildContext context){
  //logging workout UI
    //why is dart so weird
    showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Log Workout'),
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
        actions: <Widget>[
          //erm(
            onPressed: () {
              // create a workout object with data
              Workout workout = Workout(
                //data
              );
              // Save the workout or perform any other actions
              saveWorkout(workout);
              Navigator.of(context).pop();
            },
            child: Text('Log'),
          ),
        ],
      );
    },
    );
  }

  void saveWorkout(Workout workout) {
    //save to database here

    print('Workout logged: $workout');
  }


  //

}

