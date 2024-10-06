import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:route_tracking_app/models/place_autocomplete_model/place_autocomplete_model.dart';
import 'package:route_tracking_app/utils/location_service.dart';
import 'package:route_tracking_app/utils/map_services.dart';
import 'package:uuid/uuid.dart';

import '../widgets/custom_list_view.dart';
import '../widgets/custom_text_field.dart';

class GoogleMapView extends StatefulWidget {
  const GoogleMapView({super.key});

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  late CameraPosition initalCameraPosition;

  String? sessionToken;
  late Uuid uuid;
  // late RoutesService routesService;
  // late PlaceService placesService;
  // late LocationService locationService;
  Timer? debounce;
  late MapServices mapServices;

  late GoogleMapController googleMapController;
  late TextEditingController textEditingController;

  Set<Polyline> polylines = {};
  Set<Marker> markers = {};

  List<PlaceModel> places = [];

  late LatLng currentLocation;
  late LatLng desintation;

  @override
  void initState() {
    uuid = const Uuid();
    // routesService =RoutesService();
    // placesService =PlaceService();
    mapServices = MapServices();
    textEditingController = TextEditingController();
    initalCameraPosition = const CameraPosition(target: LatLng(0, 0));
    // locationService=LocationService();
    fetchPredictions();

    super.initState();
  }

  void fetchPredictions() {
    textEditingController.addListener(() {
      if (debounce?.isActive ?? false) {
        debounce?.cancel();
      }
      debounce = Timer(const Duration(milliseconds: 100), () async {
        sessionToken ??= uuid.v4();
        await mapServices.getPredictions(
            input: textEditingController.text,
            places: places,
            sessionToken: sessionToken!);
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //print(uuid.v4());
    return Stack(
      children: [
        GoogleMap(
            polylines: polylines,
            markers: markers,
            onMapCreated: (controller) {
              googleMapController = controller;
              updateCurrentLocation();
            },
            zoomControlsEnabled: false,
            initialCameraPosition: initalCameraPosition),
        Positioned(
          top: 16,
          left: 16,
          right: 16,
          child: Column(
            children: [
              CustomTextField(
                textEditingController: textEditingController,
              ),
              const SizedBox(
                height: 16,
              ),
              CustomListView(
                onPlaceSelect: (placeDetailsModel) async {
                  textEditingController.clear();
                  places.clear();

                  sessionToken = null;
                  setState(() {});
                  desintation = LatLng(
                      placeDetailsModel.geometry!.location!.lat!,
                      placeDetailsModel.geometry!.location!.lng!);

                  var points = await mapServices.getRouteData(
                      currentLocation: currentLocation,
                      desintation: desintation);
                  mapServices.displayRoute(points,
                      polylines: polylines,
                      googleMapController: googleMapController);
                  setState(() {});
                  //print(placeDetailsModel.geometry!.location!.lat);
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

  Future<void> updateCurrentLocation() async {
    try {
      currentLocation = await mapServices.updateCurrentLocation(
          googleMapController: googleMapController, markers: markers);
      setState(() {});
    } on LocationServiceException catch (e) {
      // TODO
    } on LocationPermissionException catch (e) {
      //todo
    } catch (e) {
      //todo
    }
  }
}
