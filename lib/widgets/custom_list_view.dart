import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:route_tracking_app/models/place_autocomplete_model/place_autocomplete_model.dart';
import 'package:route_tracking_app/models/place_details_model/place_details_model.dart';
import 'package:route_tracking_app/services/map_services.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({
    super.key,
    required this.places,
    required this.mapServices,
    required this.onSelectedPlace,
  });

  final List<PlaceModel> places;
  final MapServices mapServices;
  final Function(PlaceDetailsModel) onSelectedPlace;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(
              FontAwesomeIcons.mapPin,
            ),
            title: const Text('data'
                // places[index].description!,
                ),
            trailing: IconButton(
              onPressed: () async {
                var placeDetails = await mapServices.getPlaceDetails(
                  place_id: places[index].placeId.toString(),
                );

                onSelectedPlace(placeDetails);
              },
              icon: const Icon(
                Icons.arrow_circle_right_outlined,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            height: 0,
          );
        },
        // itemCount: places.length,
        itemCount: 5,
      ),
    );
  }
}
