import 'package:flutter/material.dart';
import 'package:binarybrigade/models/workout.dart';
import 'package:flutter/services.dart';
import 'package:googleapis/apigeeregistry/v1.dart';
import '../models/firestore.dart';


class LogWorkout extends StatefulWidget {
  const LogWorkout({
    Key? key,
    required this.workout,
    required this.exercise,
  }) : super(key: key);

  final Workout workout;
  final Exercise exercise;

  @override
  _LogWorkoutState createState() => _LogWorkoutState();
}

class _LogWorkoutState extends State<LogWorkout> {
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  late int _duration = 0;

  @override
  void initState() {
    super.initState();
    _startTime = TimeOfDay.now();
    _endTime = TimeOfDay.now();
  }

  //use datetimerange for the date stuff and add calendar picker
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log Workout'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //input fields!

            //Date Picker
            ElevatedButton(

              onPressed: () => _selectDate(context),
              child: Text('Select Date'),
            ),
            SizedBox(height: 16),
            Text(
              'Selected Date: ${widget.workout.m_date}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),

            //Time Picker
            _buildTimePicker(
              'Start Time',
              _startTime,
              (time) {
                setState(() {
                  _startTime = time!;
                });
              },
            ),
            _buildTimePicker(
              'End Time',
              _endTime,
              (time) {
                setState(() {
                  _endTime = time!;
                  _calculateDuration();
                });
              },
            ),
            SizedBox(height: 16),

            //workout duration
            Text('Workout Duration: $_duration minutes',
                  style: TextStyle(fontSize: 16),),

            SizedBox(height: 16),

            //other text form fields
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Exercise Type', icon: Icon(Icons.directions_run)),
              keyboardType: TextInputType.text,
              onChanged: (value) {
                widget.workout.m_listOfExercises.forEach((exercise) {
                  exercise.m_exerciseType = value;
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Exercise Description',
                  icon: Icon(Icons.description)),
              keyboardType: TextInputType.text,
              onChanged: (value) {
                widget.workout.m_listOfExercises.forEach((exercise) {
                  // exercise.m_exerciseDescription = value;
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Reps', icon: Icon(Icons.numbers)),
              onChanged: (value) {
                widget.workout.m_listOfExercises.forEach((exercise) {
                  exercise.m_numberOfReps = int.parse(value);
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Weight used', icon: Icon(Icons.monitor_weight)),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                widget.workout.m_listOfExercises.forEach((exercise) {
                  exercise.m_weightUsed = int.parse(value);
                });
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    //converts
                    DateTime startTime = DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      _startTime.hour,
                      _startTime.minute,
                    );
                    DateTime endTime = DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      _endTime.hour,
                      _endTime.minute,
                    );


                    //save workout
                    widget.workout.m_timeStart = startTime;
                    widget.workout.m_timeEnd = endTime;
                    saveWorkout(widget.workout);

                    //close page
                    Navigator.of(context).pop();
                  },
                  child: const Text('Save'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void saveWorkout(Workout workout) {
    Database.saveWorkout(workout);
    print('Workout logged: $workout');
  }

  Widget _buildTimePicker(
      String label, TimeOfDay initialTime, Function(TimeOfDay?) onChanged) {
    return GestureDetector(
      onTap: () async {
        final pickedTime = await showTimePicker(
          context: context,
          initialTime: initialTime,
        );
        if (pickedTime != null) {
          onChanged(pickedTime);
        }
      },
      child: AbsorbPointer(
        child: TextFormField(
          decoration: InputDecoration(
            labelText: label,
            icon: Icon(Icons.watch_later_outlined),
          ),
          controller: TextEditingController(
            text: initialTime.format(context),
          ),
          keyboardType: TextInputType.datetime,
        ),
      ),
    );
  }

  //calendar picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        widget.workout.m_date = pickedDate.toString();
      });
    }
  }

  //calculates the duration of workout
  void _calculateDuration() {
    final int startMinutes = _startTime.hour * 60 + _startTime.minute;
    final int endMinutes = _endTime.hour * 60 + _endTime.minute;
    setState(() {
      _duration = (endMinutes - startMinutes).abs();
    });
  }
}
