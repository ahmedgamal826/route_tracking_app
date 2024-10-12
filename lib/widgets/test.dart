import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class GoogleMapsRoute extends StatefulWidget {
  @override
  _GoogleMapsRouteState createState() => _GoogleMapsRouteState();
}

class _GoogleMapsRouteState extends State<GoogleMapsRoute> {
  TextEditingController _destinationController = TextEditingController();
  loc.LocationData? _currentPosition;
  loc.Location location = loc.Location();
  GoogleMapController? _mapController;
  Marker? _destinationMarker;
  Marker? _currentMarker;
  Polyline? _routePolyline;
  Set<Marker> _provinceMarkers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool _serviceEnabled;
    loc.PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    setState(() {
      _currentMarker = Marker(
        markerId: MarkerId('currentLocation'),
        position:
            LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!),
        infoWindow: InfoWindow(title: 'Your Location'),
      );
    });

    if (_mapController != null && _currentPosition != null) {
      _mapController!.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!),
        14,
      ));
    }
  }

  Future<void> _addDestination() async {
    if (_destinationController.text.isNotEmpty) {
      String destinationName = _destinationController.text;

      try {
        List<Location> locations = await locationFromAddress(destinationName);
        if (locations.isNotEmpty) {
          double lat = locations.first.latitude;
          double lng = locations.first.longitude;

          setState(() {
            _destinationMarker = Marker(
              markerId: MarkerId('destination'),
              position: LatLng(lat, lng),
              infoWindow: InfoWindow(title: destinationName),
            );

            _routePolyline = Polyline(
              polylineId: PolylineId('route'),
              color: Colors.blue,
              width: 5,
              points: _getRoutePoints(
                LatLng(
                    _currentPosition!.latitude!, _currentPosition!.longitude!),
                LatLng(lat, lng),
              ),
            );

            // إظهار المحافظات بين النقطتين
            _showProvincesBetween(
              LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!),
              LatLng(lat, lng),
            );

            _mapController?.animateCamera(CameraUpdate.newLatLngZoom(
              LatLng(lat, lng),
              14,
            ));
          });
        } else {
          _showErrorDialog('Location not found. Please enter a valid name.');
        }
      } catch (e) {
        print('Error finding location: $e');
        _showErrorDialog(
            'Could not find the location. Please check the name. Details: $e');
      }
    } else {
      _showErrorDialog('Destination field cannot be empty');
    }
  }

  // دالة لإرجاع نقاط المسار بشكل متعرج أو دقيق
  List<LatLng> _getRoutePoints(LatLng start, LatLng end) {
    // هنا يمكنك إضافة النقاط التي تمثل الطريق بين النقطتين
    return [
      start,
      LatLng(start.latitude + 0.005, start.longitude + 0.005), // نقطة وسطية
      LatLng(start.latitude + 0.005, start.longitude - 0.005), // نقطة متعرجة
      LatLng(end.latitude - 0.005, end.longitude - 0.005), // نقطة أخرى
      end,
    ];
  }

  // دالة لإظهار المحافظات بين النقطتين
  void _showProvincesBetween(LatLng start, LatLng end) {
    // هنا يجب عليك إدراج المنطق لتحديد المحافظات بين النقطتين.
    // كمثال، سأقوم بإضافة مجموعة ثابتة من النقاط. يمكنك تعديلها أو استخدامها كما تريد.
    List<LatLng> provinceLocations = [
      LatLng(start.latitude + 0.01, start.longitude + 0.01), // محافظة 1
      LatLng(start.latitude + 0.02, start.longitude - 0.01), // محافظة 2
      LatLng(start.latitude + 0.03, start.longitude + 0.02), // محافظة 3
    ];

    // إضافة مؤشرات للمحافظات
    for (int i = 0; i < provinceLocations.length; i++) {
      _provinceMarkers.add(
        Marker(
          markerId: MarkerId('province_$i'),
          position: provinceLocations[i],
          infoWindow: InfoWindow(title: 'Province ${i + 1}'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      );
    }

    setState(() {});
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps Route'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _destinationController,
              decoration: InputDecoration(
                labelText: 'Enter destination name',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _addDestination,
            child: Text('Add Destination'),
          ),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(0, 0),
                zoom: 2,
              ),
              markers: {
                if (_currentMarker != null) _currentMarker!,
                if (_destinationMarker != null) _destinationMarker!,
                ..._provinceMarkers,
              },
              polylines: {
                if (_routePolyline != null) _routePolyline!,
              },
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
                if (_currentPosition != null) {
                  _mapController!.animateCamera(CameraUpdate.newLatLngZoom(
                    LatLng(_currentPosition!.latitude!,
                        _currentPosition!.longitude!),
                    14,
                  ));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
