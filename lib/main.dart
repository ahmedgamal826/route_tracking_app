import 'package:flutter/material.dart';
import 'package:route_tracking_app/views/google_map_view.dart';
import 'package:route_tracking_app/widgets/route_tracking_without_apiKey.dart';

void main() {
  runApp(const RouteTrackerApp());
}

class RouteTrackerApp extends StatelessWidget {
  const RouteTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: GoogleMapView(),
        ),
      ),
    );
  }
}
