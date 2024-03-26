import 'package:binarybrigade/distancetracker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  DistanceTracker myTracker = DistanceTracker();

  test('adds message apropriate message with todays date', () {
    //adds message with today's date
    myTracker.changeTrackLocation();
    myTracker.trackDistanceTraveled();
    myTracker.changeTrackLocation();

  });

}