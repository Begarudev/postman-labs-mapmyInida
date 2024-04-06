import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';
import 'package:mappls_flutter_sdk/pages/utils/riverpod.dart';
import 'package:mappls_gl/mappls_gl.dart';

class MapMyIndia extends ConsumerStatefulWidget {
  const MapMyIndia({super.key});

  @override
  ConsumerState<MapMyIndia> createState() => _MapMyIndiaState();
}

class _MapMyIndiaState extends ConsumerState<MapMyIndia> {
  final location = Location();
  // static const CameraPosition _kInitialPosition = CameraPosition(
  //   target: LatLng(25.321684, 82.987289),
  //   zoom: 14.0,
  // );

  late MapplsMapController mapController;

  @override
  Widget build(BuildContext context) {
    var currentLocation = ref.watch(currentLocationProvider);

    return currentLocation.when(
      data: (data) {
        log(data.longitude.toString());
        CameraPosition kInitialPosition = CameraPosition(
          target: LatLng(data.latitude, data.longitude),
          zoom: 14.0,
        );
        return MapplsMap(
          myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
          initialCameraPosition: kInitialPosition,
          onUserLocationUpdated: (location) {},
          onMapCreated: (mapController) async {
            log("lng: ${data.longitude}, lat: ${data.latitude}");
            this.mapController = mapController;
            await addImageFromAsset("icon", "assets/symbols/custom-icon.png");
            // mapController.symbol;
            mapController.addSymbol(SymbolOptions(
                geometry: LatLng(data.latitude, data.longitude),
                iconImage: "icon"));
          },
          onStyleLoadedCallback: () {
            addMarker();
          },
        );
      },
      error: (error, stackTrace) => Center(
        child: Text("$error"),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  /// Adds an asset image to the currently displayed style
  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController.addImage(name, list);
  }

  void addMarker() async {
    await addImageFromAsset("icon", "assets/symbols/custom-icon.png");
    mapController.addSymbol(const SymbolOptions(
        geometry: LatLng(25.321684, 82.987289), iconImage: "icon"));
  }
}
