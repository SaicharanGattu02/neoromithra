import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoder;
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import '../services/Preferances.dart';
import '../utils/Color_Constants.dart';

class SelectLocation extends StatefulWidget {
  final String type;
  final String id;
  SelectLocation({super.key, required this.type, required this.id});
  @override
  _SelectLocationState createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  double lat = 0.0;
  double lng = 0.0;
  var latlngs = "";
  bool valid_address = true;
  bool _loading = true;

  late String _locationName = "";
  final nonEditableAddressController = TextEditingController();

  Set<Marker> markers = {};
  Set<Circle> circles = {};

  late LatLng initialPosition = LatLng(17.4065, 78.4772);
  GoogleMapController? _controller;
  var address_loading = true;

  DateTime? _lastPressedAt;
  final Duration _exitTime = Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
    requestLocationPermission();
  }

  Future<void> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      bool proceed = await _showPermissionInfoDialog();
      if (!proceed) return;

      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showLocationError(
            "Location permission denied. Please allow it from settings.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showLocationError(
          "Location permission permanently denied. Please enable it from settings.");
      return;
    }

    _getCurrentLocation();
  }

  Future<bool> _showPermissionInfoDialog() async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Permission Required"),
            content: Text(
                "We use your location to help you pick addresses accurately."),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text("Continue")),
            ],
          ),
        ) ??
        false;
  }

  void _showLocationError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Location Access Needed"),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(), child: Text("OK")),
          TextButton(
            onPressed: () {
              Geolocator.openAppSettings();
              Navigator.of(context).pop();
            },
            child: Text("Open Settings"),
          ),
        ],
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    setState(() {
      initialPosition = LatLng(position.latitude, position.longitude);
      latlngs = "${position.latitude}, ${position.longitude}";
      circles.add(Circle(
        circleId: CircleId("user_location_circle"),
        center: initialPosition,
        radius: 100,
        fillColor: Colors.blue.withOpacity(0.2),
        strokeColor: Colors.blue,
        strokeWidth: 1,
      ));
      _controller?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: initialPosition, zoom: 16)));
      _getAddress(position.latitude, position.longitude);
      _loading = false;
    });
  }

  Future<void> _getAddress(double? lat1, double? lng1) async {
    if (lat1 == null || lng1 == null) return;
    List<geocoder.Placemark> placemarks =
        await geocoder.placemarkFromCoordinates(lat1, lng1);

    geocoder.Placemark? validPlacemark;
    for (var placemark in placemarks) {
      if (placemark.country == 'India' &&
          placemark.isoCountryCode == 'IN' &&
          placemark.postalCode != null &&
          placemark.postalCode!.isNotEmpty) {
        validPlacemark = placemark;
        break;
      }
    }

    if (validPlacemark != null) {
      setState(() {
        lat = lat1;
        lng = lng1;
        latlngs = "$lat, $lng";
        _locationName =
            "${validPlacemark?.name}, ${validPlacemark?.subLocality}, ${validPlacemark?.locality}, ${validPlacemark?.subAdministrativeArea}, "
            "${validPlacemark?.administrativeArea}, ${validPlacemark?.postalCode}";
        print("_locationName:${_locationName}");
        PreferenceService().saveString('latlongs', latlngs);
        PreferenceService().saveString('location_name', _locationName);
        PreferenceService().saveString('pincode', validPlacemark?.postalCode ?? '');
        PreferenceService().saveString('city', '${validPlacemark?.subLocality},${validPlacemark?.locality}');
        PreferenceService().saveString('area', '${validPlacemark?.subAdministrativeArea},${validPlacemark?.administrativeArea}');
        nonEditableAddressController.text = _locationName;
        valid_address = true;
        address_loading = false;
      });
    } else {
      setState(() {
        _locationName =
            "Whoa there, explorer! You've reached a place we haven't. Try another location!";
        address_loading = false;
        valid_address = false;
      });
    }
  }

  void _onCameraMove(CameraPosition position) {
    setState(() {
      lat = position.target.latitude;
      lng = position.target.longitude;
      latlngs = "$lat, $lng";
      address_loading = true;
    });
  }

  void _onCameraIdle() {
    _getAddress(lat, lng);
  }

  void _onUseCurrentLocation() {
    _controller?.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: initialPosition, zoom: 17),
    ));
  }

  Future<bool> _onWillPop() async {
    final DateTime now = DateTime.now();
    if (_lastPressedAt == null || now.difference(_lastPressedAt!) > _exitTime) {
      _lastPressedAt = now;
      return Future.value(false);
    }
    return Future.value(true);
  }

  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Select Location',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: "general_sans",
              color: primarycolor,
              fontSize: 20,
            ),
          ),
          leading: IconButton.filled(
            icon: const Icon(Icons.arrow_back, color: primarycolor),
            onPressed: () {
              context.push("/main_dashBoard?initialIndex=0");
            },
            style: IconButton.styleFrom(
              backgroundColor: const Color(0xFFECFAFA),
            ),
          ),
        ),
        body: _loading
            ? Center(
                child: CircularProgressIndicator(
                  color: primarycolor,
                ),
              )
            : Stack(
                children: [
                  GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: initialPosition,
                      zoom: 17.0,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      _controller = controller;
                    },
                    onCameraMove: _onCameraMove,
                    onCameraIdle:
                        _onCameraIdle, // Trigger update when the camera stops moving
                    circles: circles,
                    myLocationEnabled: true,
                    zoomControlsEnabled: true,
                    myLocationButtonEnabled: false,
                    compassEnabled: false,
                    zoomGesturesEnabled: true,
                    scrollGesturesEnabled: true,
                    rotateGesturesEnabled: true,
                    tiltGesturesEnabled: true,
                  ),
                  Center(
                    child: Image.asset(
                      "assets/location-removebg-preview.png",
                      height: 75,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: width,
                      height: height * 0.23,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, -1),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 24, left: 16, right: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Location",
                              style: TextStyle(
                                color: Color(0xFF465761),
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 6),
                            Row(
                              children: [
                                Image.asset(
                                  "assets/location-removebg-preview.png",
                                  height: 40,
                                ),
                                SizedBox(
                                  width: width * 0.8,
                                  child: Text(
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    "$_locationName",
                                    style: TextStyle(
                                      color: Color(0xFF465761),
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: SizedBox(
                                width: width * 0.85,
                                height: 48,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primarycolor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    context.pushReplacement(
                                        '/add_address?type=${widget.type}&id=${widget.id}');
                                  },
                                  child: Text(
                                    "Add Address",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      height: 21.06 / 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: height * 0.24, // Adjust the position as needed
                    left: 0,
                    right: 0,
                    child: Center(
                      child: InkResponse(
                        onTap: () {
                          _onUseCurrentLocation();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.my_location, color: primarycolor),
                              SizedBox(width: 10),
                              Text(
                                "Current location",
                                style: TextStyle(
                                  color: Color(0xFF465761),
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
