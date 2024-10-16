// // import 'dart:math';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:route_app/models/location_info/lat_lng.dart';
// // import 'package:route_app/models/location_info/location.dart';
// // import 'package:route_app/models/location_info/location_info.dart';
// // import 'package:route_app/models/place_autocomplete_model/place_autocomplete_model.dart';
// // import 'package:route_app/models/place_details_model/place_details_model.dart';
// // import 'package:route_app/models/routes_model/routes_model.dart';
// // import 'package:route_app/utils/google_maps_place_service.dart';
// // import 'package:route_app/utils/location_service.dart';
// // import 'package:route_app/utils/routes_service.dart';

// // class MapServices {
// //   PlacesService placesService = PlacesService();
// //   LocationService locationService = LocationService();
// //   RoutesService routesService = RoutesService();
// //   LatLng? currentLocation;
// //   Future<void> getPredictions(
// //       {required String input,
// //       required String sesstionToken,
// //       required List<PlaceModel> places}) async {
// //     if (input.isNotEmpty) {
// //       var result = await placesService.getPredictions(
// //           sesstionToken: sesstionToken, input: input);

// //       places.clear();
// //       places.addAll(result);
// //     } else {
// //       places.clear();
// //     }
// //   }

// //   Future<List<LatLng>> getRouteData({required LatLng currentLocation, required LatLng desintation}) async {
// //     LocationInfoModel origin = LocationInfoModel(
// //       location: LocationModel(
// //           latLng: LatLngModel(
// //         latitude: currentLocation!.latitude,
// //         longitude: currentLocation!.longitude,
// //       )),
// //     );
// //     LocationInfoModel destination = LocationInfoModel(
// //       location: LocationModel(
// //           latLng: LatLngModel(
// //         latitude: desintation.latitude,
// //         longitude: desintation.longitude,
// //       )),
// //     );
// //     RoutesModel routes = await routesService.fetchRoutes(
// //         origin: origin, destination: destination);
// //     PolylinePoints polylinePoints = PolylinePoints();
// //     List<LatLng> points = getDecodedRoute(polylinePoints, routes);
// //     return points;
// //   }

// //   List<LatLng> getDecodedRoute(
// //       PolylinePoints polylinePoints, RoutesModel routes) {
// //     List<PointLatLng> result = polylinePoints.decodePolyline(
// //       routes.routes!.first.polyline!.encodedPolyline!,
// //     );

// //     List<LatLng> points =
// //         result.map((e) => LatLng(e.latitude, e.longitude)).toList();
// //     return points;
// //   }

// //   void displayRoute(List<LatLng> points,
// //       {required Set<Polyline> polyLines,
// //       required GoogleMapController googleMapController, required Set<Polyline> polylines}) {
// //     Polyline route = Polyline(
// //       color: Colors.blue,
// //       width: 5,
// //       polylineId: const PolylineId('route'),
// //       points: points,
// //     );

// //     polyLines.add(route);

// //     LatLngBounds bounds = getLatLngBounds(points);
// //     googleMapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 32));
// //   }

// //   LatLngBounds getLatLngBounds(List<LatLng> points) {
// //     var southWestLatitude = points.first.latitude;
// //     var southWestLongitude = points.first.longitude;
// //     var northEastLatitude = points.first.latitude;
// //     var northEastLongitude = points.first.longitude;

// //     for (var point in points) {
// //       southWestLatitude = min(southWestLatitude, point.latitude);
// //       southWestLongitude = min(southWestLongitude, point.longitude);
// //       northEastLatitude = max(northEastLatitude, point.latitude);
// //       northEastLongitude = max(northEastLongitude, point.longitude);
// //     }

// //     return LatLngBounds(
// //         southwest: LatLng(southWestLatitude, southWestLongitude),
// //         northeast: LatLng(northEastLatitude, northEastLongitude));
// //   }

// //   void updateCurrentLocation(
// //       {required GoogleMapController googleMapController,
// //       required Set<Marker> markers,
// //       required Function onUpdatecurrentLocation,
// //       }) {
// //     locationService.getRealTimeLocationData((locationData) {
// //       currentLocation = LatLng(locationData.latitude!, locationData.longitude!);

// //       Marker currentLocationMarker = Marker(
// //         markerId: const MarkerId('my location'),
// //         position: currentLocation!,
// //       );
// //       CameraPosition myCurrentCameraPoistion = CameraPosition(
// //         target: currentLocation!,
// //         zoom: 17,
// //       );
// //       googleMapController.animateCamera(
// //           CameraUpdate.newCameraPosition(myCurrentCameraPoistion));
// //       markers.add(currentLocationMarker);
// //       onUpdatecurrentLocation();
// //     });
// //   }

// //   Future<PlaceDetailsModel> getPlaceDetails({required String placeId}) async {
// //     return await placesService.getPlaceDetails(placeId: placeId);
// //   }
// // }

// // import 'dart:math';

// // import 'package:flutter/material.dart';
// // import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:route_app/utils/routes_service.dart';
// // import '../models/location_info/lat_lng.dart';
// // import '../models/location_info/location.dart';
// // import '../models/location_info/location_info.dart';
// // import '../models/place_details_model/place_details_model.dart';
// // import '../models/routes_model/routes_model.dart';

// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:route_tracking_app/models/location_info/lat_lng.dart';
// import 'package:route_tracking_app/models/location_info/location.dart';
// import 'package:route_tracking_app/models/location_info/location_info.dart';
// import 'package:route_tracking_app/models/place_autocomplete_model/place_autocomplete_model.dart';
// import 'package:route_tracking_app/models/place_details_model/place_details_model.dart';
// import 'package:route_tracking_app/models/routes_model/routes_model.dart';
// import 'package:route_tracking_app/utils/google_maps_place_service.dart';
// import 'package:route_tracking_app/utils/routes_service.dart';

// import 'location_service.dart';

// class MapServices {
//   PlacesService placesService = PlacesService();
//   LocationService locationService = LocationService();
//   RoutesService routesService = RoutesService();

//   Future<void> getPredictions(
//       {required String input,
//       required String sessionToken,
//       required List<PlaceModel> places}) async {
//     if (input.isNotEmpty) {
//       var result = await placesService.getPredictions(
//         sesstionToken: sessionToken,
//         input: input,
//       );

//       places.clear();
//       places.addAll(result);
//     } else {
//       places.clear();
//     }
//   }

//   Future<List<LatLng>> getRouteData(
//       {required LatLng currentLocation, required LatLng desintation}) async {
//     LocationInfoModel origin = LocationInfoModel(
//         location: LocationModel(
//             latLng: LatLngModel(
//                 latitude: currentLocation.latitude,
//                 longitude: currentLocation.longitude)));

//     LocationInfoModel destination = LocationInfoModel(
//         location: LocationModel(
//             latLng: LatLngModel(
//                 latitude: desintation.latitude,
//                 longitude: desintation.longitude)));
//     var routes = await routesService.fetchRoutes(
//         origin: origin, destination: destination);
//     PolylinePoints polylinePoints = PolylinePoints();
//     List<LatLng> points = getDecodedRoute(polylinePoints, routes);

//     return points;
//   }

//   List<LatLng> getDecodedRoute(
//       PolylinePoints polylinePoints, RoutesModel routes) {
//     List<PointLatLng> result = polylinePoints
//         .decodePolyline(routes.routes!.first.polyline!.encodedPolyline!);

//     List<LatLng> points =
//         result.map((e) => LatLng(e.latitude, e.longitude)).toList();

//     return points;
//   }

//   void displayRoute(List<LatLng> points,
//       {required Set<Polyline> polylines,
//       required GoogleMapController googleMapController}) {
//     Polyline route = Polyline(
//         color: Colors.blue,
//         width: 5,
//         polylineId: const PolylineId('route'),
//         points: points);
//     polylines.add(route);

//     LatLngBounds bounds = getLatLngBounds(points);
//     googleMapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 32));
//   }

//   LatLngBounds getLatLngBounds(List<LatLng> points) {
//     var southWestLatitude = points.first.latitude;
//     var southWestLongitude = points.first.longitude;
//     var northEastlatitude = points.first.latitude;
//     var northEastlongitude = points.first.longitude;

//     for (var point in points) {
//       southWestLatitude = min(southWestLatitude, point.latitude);
//       southWestLongitude = min(southWestLongitude, point.longitude);

//       northEastlatitude = max(northEastlatitude, point.latitude);
//       northEastlongitude = max(northEastlongitude, point.longitude);
//     }
//     return LatLngBounds(
//         southwest: LatLng(southWestLatitude, southWestLongitude),
//         northeast: LatLng(northEastlatitude, northEastlongitude));
//   }

//   Future<LatLng> updateCurrentLocation(
//       {required GoogleMapController googleMapController,
//       required Set<Marker> markers}) async {
//     var locationData = await locationService.getLocation();

//     var currentLocation =
//         LatLng(locationData.latitude!, locationData.longitude!);
//     Marker currentLocationMarker = Marker(
//       markerId: const MarkerId('my location'),
//       position: currentLocation,
//     );

//     CameraPosition myCurrentCameraPosition =
//         CameraPosition(target: currentLocation, zoom: 16);

//     googleMapController
//         .animateCamera(CameraUpdate.newCameraPosition(myCurrentCameraPosition));
//     markers.add(currentLocationMarker);
//     return currentLocation;
//   }

//   Future<PlaceDetailsModel> getPlaceDetails({required String placeId}) async {
//     return await placesService.getPlaceDetails(placeId: placeId);
//   }
// }

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:route_tracking_app/models/location_info/lat_lng.dart';
import 'package:route_tracking_app/models/location_info/location.dart';
import 'package:route_tracking_app/models/location_info/location_info.dart';
import 'package:route_tracking_app/models/place_autocomplete_model/place_autocomplete_model.dart';
import 'package:route_tracking_app/models/place_details_model/place_details_model.dart';
import 'package:route_tracking_app/models/routes_model/routes_model.dart';
import 'package:route_tracking_app/services/google_maps_place_service.dart';
import 'package:route_tracking_app/services/location_service.dart';
import 'package:route_tracking_app/services/routes_service.dart';

class MapServices {
  LocationService locationService = LocationService();
  PlaceService placeService = PlaceService();
  RoutesService routesService = RoutesService();

  LatLng? currentLocation;

  getPredictions({
    required String input,
    required String sessionToken,
    required List<PlaceModel> places,
  }) async {
    if (input.isNotEmpty) {
      var results = await placeService.getPredictions(
        input: input,
        sessionToken: sessionToken,
      );

      places.clear(); // delete old data
      places.addAll(results);
    } else {
      places.clear();
    }
  }

  void updateCurrentLocation(
      {required GoogleMapController googleMapController,
      required Set<Marker> markers,
      re}) async {
    locationService.getRealTimeLocationData(
      // stream location data
      (locationData) {
        currentLocation = LatLng(
          locationData.latitude!,
          locationData.longitude!,
        );
      },
    );

    Marker myLocationMarker = Marker(
      markerId: const MarkerId(
        'my_location',
      ),
      position: currentLocation!,
    );

    CameraPosition cameraPosition = CameraPosition(
      target: currentLocation!,
      zoom: 12,
    );

    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );

    markers.add(myLocationMarker);
  }

  void displayRoute({
    required List<LatLng> points,
    required Set<Polyline> polyLines,
    required GoogleMapController googleMapController,
  }) {
    Polyline route = Polyline(
      polylineId: PolylineId('route'),
      points: points,
      color: Colors.red,
      width: 5,
    );

    polyLines.add(route);

    LatLngBounds bounds = getLatLngBounds(points);
    googleMapController.animateCamera(
      CameraUpdate.newLatLngBounds(
        bounds,
        16,
      ),
    );
  }

  LatLngBounds getLatLngBounds(List<LatLng> points) {
    // min southweat latitude
    // min southweat longtuide
    var southWestLatitude = points.first.latitude;
    var southWestLongtude = points.first.longitude;

    // max northeast latitude
    // max northeast longtuide

    var northEastLatitude = points.first.latitude;
    var northEastLongtude = points.first.longitude;

    for (var point in points) {
      southWestLatitude = min(southWestLatitude, point.latitude);
      southWestLongtude = min(southWestLongtude, point.longitude);

      northEastLatitude = max(northEastLatitude, point.latitude);
      northEastLongtude = max(northEastLongtude, point.longitude);
    }

    return LatLngBounds(
      southwest: LatLng(southWestLatitude, southWestLongtude),
      northeast: LatLng(northEastLatitude, northEastLongtude),
    );
  }

  List<LatLng> getDecodedRoute(
      PolylinePoints polylinePoints, RoutesModel routes) {
    List<PointLatLng> result = polylinePoints.decodePolyline(
      routes.routes!.first.polyline!.encodedPolyline!,
    );

    List<LatLng> points =
        result.map((e) => LatLng(e.latitude, e.longitude)).toList();
    return points;
  }

  Future<List<LatLng>> getRouteData({
    required LatLng destinationLocation,
  }) async {
    // origin ==> current location
    LocationInfoModel origin = LocationInfoModel(
      location: LocationModel(
        latLng: LatLngModel(
          latitude: currentLocation!.latitude,
          longitude: currentLocation!.longitude,
        ),
      ),
    );

    // destination ==> destination location
    LocationInfoModel destination = LocationInfoModel(
      location: LocationModel(
        latLng: LatLngModel(
          latitude: destinationLocation.latitude,
          longitude: destinationLocation.longitude,
        ),
      ),
    );

    RoutesModel routes = await routesService.fetchRoutes(
        origin: origin, destination: destination);
    PolylinePoints polylinePoints = PolylinePoints();

    List<LatLng> points = getDecodedRoute(polylinePoints, routes);

    return points;
  }

  Future<PlaceDetailsModel> getPlaceDetails({required String place_id}) async {
    return await placeService.getPlaceDetails(
      place_id: place_id,
    );
  }
}
