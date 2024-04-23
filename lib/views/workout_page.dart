import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:binarybrigade/models/firestore.dart';
import 'package:googleapis/apigeeregistry/v1.dart';
import 'package:googleapis/firestore/v1.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
      start: now.subtract(Duration(days: 6)),
      end: now,
    );

    try {
      List<Workout> workouts = await _database.getWorkouts(lastSevenDays);

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [


          //CHART stuff
          Container(
            height: 300,
            child: SfCartesianChart(
              //chart stuff
              //minutes exercised over last 7 (week) days column chart
              primaryXAxis: CategoryAxis(
                  // labels: ChartAxisLabel(
                  //   isVisible: true,
                  //   categories: ['Sun', 'Mon', 'Tues', 'Wed', 'Thu', 'Fri', 'Sat'],
                  // )
                  ),
              title: const ChartTitle(text: 'Minutes Exercised Weekly'),
              legend: const Legend(isVisible: true),

              series: <CartesianSeries>[
                ColumnSeries<_ChartData, int>(
                  dataSource: chartData,
                  xValueMapper: (_ChartData data, _) => data.dayOfWeek,
                  yValueMapper: (_ChartData data, _) => data.minutes,
                  //will need to be changed
                  color: Colors.green,
                )
              ],
            ),
          ),


          // StreamBuilder for displaying workout data
          StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('workouts').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text("No workouts saved"),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot historyfeed =
                        snapshot.data?.docs[index] as DocumentSnapshot<Object?>;

                    var date = historyfeed['date'];
                    var exercises = historyfeed['exercises'];

                    List<String> exerciseTypes = exercises.map((exercise) => exercise['exerciseType']).toList();

                    return Stack(children: <Widget>[
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          child: Padding(
                              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Material(
                                  color: Colors.white,
                                  elevation: 14.0,
                                  child: Center(
                                      child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Column(children: <Widget>[
                                            SizedBox(height: 10),
                                            Text(
                                              'Date: $date',
                                              style: TextStyle(fontSize: 20.0),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              'Exercise Types: ${exerciseTypes.join(', ')}',
                                              style: TextStyle(fontSize: 10.0),
                                            ),
                                          ]))))))
                    ]);
                  },
                );
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
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
