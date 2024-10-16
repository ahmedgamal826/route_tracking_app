import 'dart:convert';

import 'package:route_tracking_app/models/place_autocomplete_model/place_autocomplete_model.dart';
import 'package:http/http.dart' as http;
import 'package:route_tracking_app/models/place_details_model/place_details_model.dart';

class PlaceService {
  final String baseUrl = 'https://maps.googleapis.com/maps/api/place';
  final String apiKey = 'AIzaSyAoG5tLOTFbpV0Fp9xDpW1i0Nf-ifkxBZw';

  Future<List<PlaceModel>> getPredictions(
      {required String input, required String sessionToken}) async {
    var respose = await http.get(
      Uri.parse(
        '$baseUrl/autocomplete/json?key=$apiKey&input=$input',
      ),
    );

    if (respose.statusCode == 200) {
      var data = jsonDecode(respose.body); // all data
      var predicions = data['predictions'];

      List<PlaceModel> places = [];

      for (var item in predicions) {
        places.add(PlaceModel.fromJson(item));
      }

      return places;
    } else {
      throw Exception();
    }
  }

  // get place details function

  Future<PlaceDetailsModel> getPlaceDetails({required String place_id}) async {
    var respose = await http.get(
      Uri.parse(
        '$baseUrl/details/json?key=$apiKey&place_id=$place_id',
      ),
    );

    if (respose.statusCode == 200) {
      var data = jsonDecode(respose.body); // all data
      var result = data['result'];
      return PlaceDetailsModel.fromJson(result);
    } else {
      throw Exception();
    }
  }
}
