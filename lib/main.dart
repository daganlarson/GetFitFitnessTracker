import 'package:binarybrigade/models/appTheme.dart';
import 'package:binarybrigade/views/components/eventwidget.dart';
import 'package:binarybrigade/views/root_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'models/appColors.dart';
import 'views/home_page.dart';
import 'views/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:binarybrigade/models/event.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';
import 'firebase_options.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:binarybrigade/views/components/notifications.dart';

var results;
String curCity ="";
String curState="";
List<Event> eventList = <Event>[];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var status = await Permission.locationWhenInUse.status;
  if (status.isDenied || status.isRestricted) {
    Permission.locationWhenInUse.request();
  }

    var position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best).timeout(Duration(seconds: 5));
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude
    );
    curCity = placemarks[0].locality.toString();
    curState = placemarks[0].administrativeArea.toString();
  } catch (err) {}

  results = await searchEvents();
  results is List;
  for (int x = 0; x < results.length; x++) {
    Event tempEvent = Event(results[x]);
    eventList.add(tempEvent);
  }

  runApp(MyApp());
}

Future<List> searchEvents() async{
  var query = "Exercise Events near $curCity, $curState";
  var url = Uri.parse('https://serpapi.com/search?q=$query&google_domain=google.com&api_key=671b87e3fd80af91edf54cad1a630ad8d80d593b1afe754a507a44650e91e1bf');
  // Your query
  var response = await http.get(url);
  var theResults = jsonDecode(response.body);
  return theResults["events_results"];
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Initialise  localnotification
    Notifications.initialize();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("couldn't connect");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              title: 'Binary Brigade',
              theme: appTheme, //see appTheme.dart
              home: RootPage(),
            );
          } else {
            Widget loading = const MaterialApp();
            return loading;
          }
        });
  }
}