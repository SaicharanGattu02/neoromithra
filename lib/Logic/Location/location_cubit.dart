import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as loc;
import '../../services/Preferances.dart';
import 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());


  Future<void> checkLocationPermission() async {
    emit(LocationLoading());
    try {
      String locationName = await PreferenceService().getString('LocName') ?? "Gachibowli, Hyderabad";
      bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
      LocationPermission permission = await Geolocator.checkPermission();

      if (!isServiceEnabled || permission == LocationPermission.denied) {
        emit(LocationPermissionDenied()); // Emit denied state instead of error
      } else if (permission == LocationPermission.deniedForever) {
        emit(LocationError("Permission permanently denied. Enable it in settings."));
      } else {
        await getLatLong();
      }
    } catch (e) {
      emit(LocationError("Failed to check location permissions"));
    }
  }

  /// Request location permission from user
  Future<void> requestLocationPermission() async {
    emit(LocationLoading());

    try {
      bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
      LocationPermission permission = await Geolocator.checkPermission();

      if (!isServiceEnabled) {
        // Do not return here, instead call GPS permission request
        await requestGpsPermission();
        return;
      }

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(LocationPermissionDenied());
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        emit(LocationError("Permission permanently denied. Enable it in settings."));
        return;
      }

      // If permission is granted, directly request GPS to be turned on
      await requestGpsPermission();
    } catch (e) {
      emit(LocationError("Failed to request location permission"));
    }
  }


  /// Request GPS to be turned on
  Future<void> requestGpsPermission() async {
    final location = loc.Location();
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        emit(LocationPermissionDenied()); // Emit denied state if GPS is not enabled
        return;
      }
    }
    await getLatLong();
  }

  /// Fetch user's current latitude & longitude
  Future<void> getLatLong() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      String locationName = placemarks.isNotEmpty
          ? "${placemarks[0].street}, ${placemarks[0].subLocality}"
          : "Address not found";

      String latlngs= "${position.latitude},${position.longitude}";

      PreferenceService().saveString('LocName', locationName);
      PreferenceService().saveString('latlngs', latlngs);

      emit(LocationLoaded(locationName: locationName,latlng: latlngs));
    } catch (e) {
      emit(LocationError("Failed to fetch location"));
    }
  }
}