import 'package:geolocator/geolocator.dart';

class LocationService {
  static const double defaultLat = 41.2995;
  static const double defaultLon = 69.2401;
  static const String defaultLocationName = 'Toshkent';

  Future<({double lat, double lon, String name})> getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return (lat: defaultLat, lon: defaultLon, name: defaultLocationName);
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return (lat: defaultLat, lon: defaultLon, name: defaultLocationName);
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return (lat: defaultLat, lon: defaultLon, name: defaultLocationName);
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
          timeLimit: Duration(seconds: 10),
        ),
      );

      return (
        lat: position.latitude,
        lon: position.longitude,
        name: 'Joriy joylashuv',
      );
    } catch (_) {
      return (lat: defaultLat, lon: defaultLon, name: defaultLocationName);
    }
  }
}
