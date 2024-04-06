import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

final currentLocationProvider = StreamProvider<Position>((ref) {
  Stream<Position> location = Geolocator.getPositionStream(
      locationSettings: AndroidSettings(
    accuracy: LocationAccuracy.best,
    distanceFilter: 1,
  ));
  return location;
});
