// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:route_tracking_app/models/place_autocomplete_model/place_autocomplete_model.dart';
// import 'package:route_tracking_app/models/place_details_model/place_details_model.dart';

// class PlacesService {
//   final String baseUrl = 'https://maps.googleapis.com/maps/api/place';
//   final String apiKey = 'AIzaSyAoG5tLOTFbpV0Fp9xDpW1i0Nf-ifkxBZw';
//   Future<List<PlaceModel>> getPredictions(
//       {required String input, required String sesstionToken}) async {
//     var response = await http.get(Uri.parse(
//         '$baseUrl/autocomplete/json?key=$apiKey&input=$input&sessiontoken=$sesstionToken'));

//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body)['predictions'];
//       List<PlaceModel> places = [];
//       for (var item in data) {
//         places.add(PlaceModel.fromJson(item));
//       }
//       return places;
//     } else {
//       throw Exception();
//     }
//   }

//   Future<PlaceDetailsModel> getPlaceDetails({required String placeId}) async {
//     var response = await http
//         .get(Uri.parse('$baseUrl/details/json?key=$apiKey&place_id=$placeId'));

//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body)['result'];
//       return PlaceDetailsModel.fromJson(data);
//     } else {
//       throw Exception();
//     }
//   }
// }

import 'dart:convert';

import 'package:route_tracking_app/models/place_autocomplete_model/place_autocomplete_model.dart';
import 'package:http/http.dart' as http;

class GoogleMapsPlaceService {
  final String baseUrl = 'https://maps.googleapis.com/maps/api/place';
  final String apiKey = 'AIzaSyAoG5tLOTFbpV0Fp9xDpW1i0Nf-ifkxBZw';

  Future<List<PlaceModel>> getPredictions({required String input}) async {
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
}
