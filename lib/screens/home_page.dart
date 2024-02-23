import 'dart:async';

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Completer<GoogleMapController> controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: screenHeight,
                  width: screenWidth,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController googleMapController) {
                      controller.complete(googleMapController);
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FabCircularMenu(
          alignment: Alignment.bottomLeft,
          fabColor: Colors.blue.shade50,
          fabOpenColor: Colors.red.shade100,
          ringDiameter: 250.0,
          ringWidth: 60.0,
          ringColor: Colors.blue.shade50,
          fabSize: 60.0,
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                  });
                },
                icon: const Icon(Icons.search)),
            IconButton(
                onPressed: () {
                  setState(() {
                  });
                },
                icon: const Icon(Icons.navigation))
          ]),
    );
  }
}
