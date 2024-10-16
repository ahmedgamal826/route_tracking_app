import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:route_tracking_app/models/place_autocomplete_model/place_autocomplete_model.dart';
import 'package:route_tracking_app/services/location_service.dart';
import 'package:route_tracking_app/services/map_services.dart';
import 'package:route_tracking_app/widgets/custom_list_view.dart';
import 'package:route_tracking_app/widgets/custom_text_field.dart';
import 'package:uuid/uuid.dart';

class GoogleMapView extends StatefulWidget {
  const GoogleMapView({super.key});

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  late CameraPosition initialCameraPosition;
  late MapServices mapServices;
  late GoogleMapController googleMapController;
  late TextEditingController textEditingController;
  late Uuid uuid;
  Set<Polyline> polyLines = {};
  late Timer timer;
  Set<Marker> markers = {};

  List<PlaceModel> places = [];

  @override
  void initState() {
    uuid = Uuid();
    mapServices = MapServices();
    textEditingController = TextEditingController();
    initialCameraPosition = const CameraPosition(
      target: LatLng(0, 0),
    );

    fetchPredictions();

    super.initState();
  }

  late LatLng currentLocation;
  late LatLng destinationLocation;

  var sessionToken; // create a random key

  void fetchPredictions() {
    textEditingController.addListener(
      () {
        if (timer.isActive ?? false) {
          timer.cancel();
        }
        timer = Timer(const Duration(milliseconds: 100), () async {
          sessionToken ??= uuid.v4(); // create session token

          //if sessionToken != null
          await mapServices.getPredictions(
            input: textEditingController.text,
            places: places,
            sessionToken: sessionToken,
          );
          setState(() {});
          print(sessionToken);
        });
      },
    );
  }

  @override
  void dispose() {
    textEditingController.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          polylines: polyLines,
          markers: markers,
          onMapCreated: (controller) {
            googleMapController = controller; // googleMapController Initialized
            updateCurrentLocation();
          },
          zoomControlsEnabled: true,
          initialCameraPosition: initialCameraPosition,
        ),
        Positioned(
          top: 12,
          right: 12,
          left: 12,
          child: Column(
            children: [
              CustomTextField(
                textEditingController: textEditingController,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomListView(
                onSelectedPlace: (PlaceDetailsModel) async {
                  textEditingController.clear();
                  places.clear();
                  sessionToken = null;
                  setState(() {});

                  destinationLocation = LatLng(
                    PlaceDetailsModel.geometry!.location!.lat!,
                    PlaceDetailsModel.geometry!.location!.lng!,
                  );

                  var points = await mapServices.getRouteData(
                      destinationLocation: destinationLocation);
                  mapServices.displayRoute(
                    points: points,
                    googleMapController: googleMapController,
                    polyLines: polyLines,
                  );

                  setState(() {});
                },
                places: places,
                mapServices: mapServices,
              )
            ],
          ),
        ),
      ],
    );
  }

  void updateCurrentLocation() async {
    try {
      mapServices.updateCurrentLocation(
        googleMapController: googleMapController,
        markers: markers,
      );
      setState(() {});
    } on LoationServiceException catch (e) {
      // to do
    } on LoationPermissionException catch (e) {
      // to do
    } catch (e) {}
  }
}

// create text field
// listen to text field
// search places
// display results
