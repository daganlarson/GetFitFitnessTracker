import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


import '../models/event.dart';
import 'components/eventwidget.dart';



class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<StatefulWidget> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  bool isLoading = true;
  String location = "";
  List<Event> eventList = <Event>[];



  Future<List> _searchEvents(String location) async{
    var query = "Exercise Events near $location";
    var url = Uri.parse('https://serpapi.com/search?q=$query&google_domain=google.com&api_key=671b87e3fd80af91edf54cad1a630ad8d80d593b1afe754a507a44650e91e1bf');
    // Your query
    var response = await http.get(url);
    var theResults = jsonDecode(response.body);
    return theResults["events_results"];
  }

  @override
  void initState() {
    super.initState();
    _fetchEvents().then((result) {
      setState(() {
        eventList = result;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? Scaffold() : _eventsScreen();
  }

  Widget _eventsScreen() {
    return Center(child:
    ListView(
      children: List.generate(3, (index) => EventWidget(eventList[index])),
    )
    );
  }

  _fetchEvents() async {
    var status = await Permission.locationWhenInUse.status;
    if (status.isDenied || status.isRestricted) {
      Permission.locationWhenInUse.request();
    }

    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best).timeout(const Duration(seconds: 5));
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude
      );
      String curCity = placemarks[0].locality.toString();
      String curState = placemarks[0].administrativeArea.toString();
      location = "$curCity, $curState";
    } catch (err) {}

    List<Event> result = [];
    List<dynamic> eventSearch = await _searchEvents(location);

    for (int x = 0; x < eventSearch.length; x++) {
      Event tempEvent = Event(eventSearch[x]);
      result.add(tempEvent);
    }
    return result;
  }

}