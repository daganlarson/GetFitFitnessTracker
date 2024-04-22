import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:googleapis/androidenterprise/v1.dart';
import 'package:intl/intl.dart';


Future<bool> determinePermissions() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    log('Location services are disabled.');
    return false;
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      log('Location permissions are denied.');
      return false;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    log(
        'Location permissions are permanently denied, we cannot request permissions.');
    return false;
  }

  return true;
}

class DistanceTracker {

  double m_distanceTraveled = 0;
  Future<bool> m_permissionsEnabled = determinePermissions();
  bool m_locationToggle = false;
  late Position m_currentPosition;
  late Position m_lastPosition;


  Future<void> trackDistanceTraveled() async {
    while (await m_permissionsEnabled != true) {
      log('Permissions do not allow location tracking');
      m_permissionsEnabled = determinePermissions();
    }


    while (m_locationToggle) {

      /*
      final LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 1,
      );
      StreamSubscription<Position> positionStream = Geolocator.getPositionStream(
          locationSettings: locationSettings).listen((Position? position) {

        m_distanceTraveled +=1; }); */
      if (m_distanceTraveled == 0) {
        m_currentPosition =  await Geolocator.getCurrentPosition();
      }
      m_lastPosition = m_currentPosition;
      m_currentPosition = await Geolocator.getCurrentPosition();
      m_distanceTraveled += Geolocator.distanceBetween(m_lastPosition.latitude.toDouble(), m_lastPosition.longitude.toDouble(), m_currentPosition.latitude.toDouble(), m_currentPosition.longitude.toDouble());
    }
    log('The total distance you traveled was: $m_distanceTraveled');

  }
}

