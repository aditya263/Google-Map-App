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

  //Debounce to throttle async calls during search
  Timer? debounce;

  //Toggling UI as need
  bool searchToggle = false;
  bool radiusSlider = false;
  bool cardTapped = false;
  bool pressedNear = false;
  bool getDirection = false;

  //Set Markers
  Set<Marker> markers = Set<Marker>();

  //Text Editing Controller
  TextEditingController searchController = TextEditingController();

  //Initial Map position on load
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;

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
                    markers: markers,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController googleMapController) {
                      controller.complete(googleMapController);
                    },
                  ),
                ),
                searchToggle
                    ? Padding(
                  padding: const EdgeInsets.fromLTRB(
                    15.0,
                    40.0,
                    15.0,
                    5.0,
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white),
                        child: TextFormField(
                          controller: searchController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 15.0),
                            border: InputBorder.none,
                            hintText: 'Search',
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  searchToggle = false;
                                  searchController.text = '';
                                });
                              },
                              icon: const Icon(Icons.close),
                            ),
                          ),
                          onChanged: (value) {
                            if (debounce?.isActive ?? false) {
                              debounce?.cancel();
                              debounce = Timer(const Duration(
                                  milliseconds: 700), () async {
                                if(value.length>2){

                                }
                              });
                            }
                          },
                        ),
                      )
                    ],
                  ),
                )
                    : Container(),
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
                    searchToggle = true;
                    radiusSlider = false;
                    pressedNear = false;
                    cardTapped = false;
                    getDirection = false;
                  });
                },
                icon: const Icon(Icons.search)),
            IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: const Icon(Icons.navigation))
          ]),
    );
  }
}
