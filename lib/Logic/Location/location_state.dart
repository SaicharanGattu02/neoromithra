
abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final String locationName;
  final String latlng;
  LocationLoaded({
    required this.locationName,
    required this.latlng
  });
}

class LocationPermissionDenied extends LocationState {} // New state for denied permission

class LocationError extends LocationState {
  final String message;
  LocationError(this.message);
}


