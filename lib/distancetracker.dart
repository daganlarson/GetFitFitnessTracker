
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

Future<bool> determinePermissions() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    print('Location services are disabled.');
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
      print('Location permissions are denied.');
      return false;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    print(
        'Location permissions are permanently denied, we cannot request permissions.');
    return false;
  }

  return true;
}

class DistanceTracker {

  double m_distanceTraveled = 0;
  Future<bool> m_permissionsEnabled = determinePermissions();
  bool m_trackLocation = false;
  late Position m_currentPosition;
  late Position m_lastPosition;

  Future<void> trackDistanceTraveled() async{

    m_currentPosition = await Geolocator.getCurrentPosition();

    while (await m_permissionsEnabled != true) {

      print('Permissions do not allow location tracking');
      m_permissionsEnabled = determinePermissions();
    }
    m_lastPosition = m_currentPosition;
    m_currentPosition = await Geolocator.getCurrentPosition();

    while (m_trackLocation) {

      m_distanceTraveled += Geolocator.distanceBetween(m_lastPosition.latitude.toDouble(), m_lastPosition.longitude.toDouble(), m_currentPosition.latitude.toDouble(), m_currentPosition.longitude.toDouble());
      print('Current distance traveled: $m_distanceTraveled');
    }

  }

}

class DistanceTrackerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

}