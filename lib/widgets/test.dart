// import 'package:flutter/material.dart';

// class GoogleMapsRoute extends StatefulWidget {
//   @override
//   _GoogleMapsRouteState createState() => _GoogleMapsRouteState();
// }

// class _GoogleMapsRouteState extends State<GoogleMapsRoute> {
//   TextEditingController _destinationController = TextEditingController();
//   String _googleMapsUrl = '';
//   Position? _currentPosition;

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }

//   // تحديد الموقع الحالي
//   Future<void> _getCurrentLocation() async {
//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );
//     setState(() {
//       _currentPosition = position;
//     });
//   }

//   // عرض المسار في خرائط Google
//   void _showRoute() {
//     if (_currentPosition != null && _destinationController.text.isNotEmpty) {
//       String origin =
//           '${_currentPosition!.latitude},${_currentPosition!.longitude}';
//       String destination = _destinationController.text;

//       // بناء رابط خرائط Google
//       setState(() {
//         _googleMapsUrl =
//             'https://www.google.com/maps/dir/?api=1&origin=$origin&destination=$destination&travelmode=driving';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Google Maps Route'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: _destinationController,
//               decoration: InputDecoration(
//                 labelText: 'Enter destination',
//               ),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: _showRoute,
//             child: Text('Show Route'),
//           ),
//           Expanded(
//             child: _googleMapsUrl.isNotEmpty
//                 ? WebView(
//                     initialUrl: _googleMapsUrl,
//                     javascriptMode: JavascriptMode.unrestricted,
//                   )
//                 : Center(child: Text('Enter destination to show route')),
//           ),
//         ],
//       ),
//     );
//   }
// }
