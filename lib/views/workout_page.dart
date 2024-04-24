import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:binarybrigade/providers/DatabaseProvider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../distancetracker.dart';
import '../models/workout.dart';
import 'components/log_workout.dart';
import 'components/workout_feed.dart';
import 'components/youtube_player.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final StopWatchTimer _myStopWatch = StopWatchTimer();
  final _isHours = true;
  final DistanceTracker _myTracker = DistanceTracker();
  final Database _database = Database();
  List<_ChartData> chartData = [];

  @override
  void initState() {
    super.initState();
    _fetchWorkouts();
  }

  void _fetchWorkouts() async {
    DateTime now = DateTime.now();
    DateTimeRange lastSevenDays = DateTimeRange(
      start: now.subtract(const Duration(days: 6)),
      end: now,
    );


    try {
      List<Workout> workouts = await Database.getWorkouts(lastSevenDays);

      List<int> dailyMinutes = List.filled(7, 0);

      for (Workout workout in workouts) {
        int dayOfWeek = workout.m_timeStart.weekday;
        // Subtract 1 from dayOfWeek to match the zero-based index of the list
        dailyMinutes[dayOfWeek - 1] += workout.durationInMinutes();
      }

      chartData = List.generate(
        dailyMinutes.length,
        (index) => _ChartData(index, dailyMinutes[index]),
      );

      setState(() {});
    } catch (e) {
      print("Error getting workouts: $e");
    }
  }

  //Floating add button that adds a workout
  // The FAB's foregroundColor, backgroundColor, and shape (not necessary but eh)
  static const List<(Color?, Color? background, ShapeBorder?)> customizations =
      <(Color?, Color?, ShapeBorder?)>[
    (null, null, null), // The FAB uses its default for null parameters.
    (null, Colors.blue, null),
    (Colors.white, Colors.blue, null),
    (Colors.white, Colors.blue, CircleBorder()),
  ];
  int index = 0; // Selects the customization.

  @override
  void dispose() {
    super.dispose();
    _myStopWatch.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Workout Page'),
        actions: [
          IconButton(
          icon: Icon(Icons.music_video_outlined),
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Youtube_Player()),
              );
          }
         ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //CHART stuff
          Container(
            height: 300,
            child: SfCartesianChart(
              //chart stuff
              //minutes exercised over last 7 (week) days column chart
              primaryXAxis: CategoryAxis(),
              title: const ChartTitle(text: 'Minutes Exercised Weekly'),
              legend: const Legend(isVisible: true),

              series: <CartesianSeries>[
                ColumnSeries<_ChartData, int>(
                  dataSource: chartData,
                  xValueMapper: (_ChartData data, _) => data.dayOfWeek,
                  yValueMapper: (_ChartData data, _) => data.minutes,
                  color: Theme.of(context).colorScheme.primary,
                  //will need to be changed
                )
              ],
            ),
          ),
        //this is the button to start distance tracking
        Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(280,80),
                    ),
                    onPressed: () {
                      print('distance tracking button pressed');
                      _myTracker.m_locationToggle = !_myTracker.m_locationToggle;
                      if (_myTracker.m_locationToggle) {
                        _myStopWatch.onExecute.add(StopWatchExecute.reset);
                        _myStopWatch.onExecute.add(StopWatchExecute.start);
                        _myTracker.trackDistanceTraveled();

                      } else {
                        _myStopWatch.onExecute.add(StopWatchExecute.stop);
                      }

                    },
                    child: const Column(
                        children: [
                          Icon(Icons.play_circle_fill),
                          Text('Distance Tracking Workout')
                        ]
                    )
                ),
                //this is the timer that times how long your distance workout was
                StreamBuilder<int>(
                  stream: _myStopWatch.rawTime,
                  initialData: _myStopWatch.rawTime.value,
                  builder: (context, snapshot){
                    final value = snapshot.data;
                    final displayTime = StopWatchTimer.getDisplayTime(value!, hours: _isHours);

                    return Text(displayTime, style: const TextStyle(
                        fontSize: 40, fontWeight: FontWeight.bold));
                  },
                ),
              //this shows your distance in meters
              Text(_myTracker.m_distanceTraveled.toString(), style: const TextStyle(
                  fontSize: 40, fontWeight: FontWeight.bold)),
              ]
            )
          ),
          workoutFeedButton(context),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LogWorkout(),
            ),
          ).then((savedWorkout) {
            if (savedWorkout != null) {
              // Handle saved workout here
              setState(() {
                index = (index + 1) % customizations.length;
              });
            }
          });
        },
        foregroundColor: customizations[index].$1,
        backgroundColor: customizations[index].$2,
        shape: customizations[index].$3,
        child: Icon(Icons.add),
      ),
    );

  }
}


class _ChartData {
  final int dayOfWeek;
  final int minutes;

  _ChartData(this.dayOfWeek, this.minutes);
}
