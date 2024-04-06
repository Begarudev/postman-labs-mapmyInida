import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:location/location.dart';
import 'package:mappls_flutter_sdk/pages/add_events_page.dart';
import 'package:mappls_flutter_sdk/pages/map_screen.dart';
import 'package:mappls_flutter_sdk/pages/utils/riverpod.dart';
import 'package:mappls_gl/mappls_gl.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    _determinePosition();
    MapplsAccountManager.setMapSDKKey("84fc6f7a-046c-4129-ac18-6e83f416ca9a");
    MapplsAccountManager.setRestAPIKey("4f0ac0b2cb1d659fade4a8984916017c");
    MapplsAccountManager.setAtlasClientId(
        "96dHZVzsAuugQtbU10E8ydaQlvV0gYFdiDmWxef9XrO2ICXVYB9F9rczVKfgkZ_OiCvyoLbJaTf7_EEhU66QhlqceZwTztMY");
    MapplsAccountManager.setAtlasClientSecret(
        "lrFxI-iSEg_mDiMFtygVxgYdu1gCyz_0sLXgt6cJ4Bt3YU_lRheD0D3j4UXiYsg9nHcWkL0pHNn6P4XrR-VbPTvRDf73ii-BqcW_Wc6e_k4=");
    setPermission();
  }

  void setPermission() async {
    if (!kIsWeb) {
      final location = Location();
      final hasPermissions = await location.hasPermission();
      if (hasPermissions != PermissionStatus.granted) {
        await location.requestPermission();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(currentLocationProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: 'Mappls Flutter Demo',
      routerConfig: _router,
      // home: const MapScreen(),
      // routes: <String, WidgetBuilder>{
      //   '/MapClick': (BuildContext context) => const MapClickEvent(),
      //   '/MapLongClick': (BuildContext context) => const MapLongClickEvent(),
      //   '/MapStyle': (BuildContext context) => const MapStyleEvent(),
      //   '/CameraFeature': (BuildContext context) => const CameraFeature(),
      //   '/LocationCameraOptions': (BuildContext context) =>
      //       const LocationCameraOption(),
      //   '/AddMarker': (BuildContext context) => const AddMarker(),
      //   '/MarkerDragging': (BuildContext context) => const MarkerDragging(),
      //   '/CurrentLocation': (BuildContext context) => const CurrentLocation(),
      //   '/AutoSuggest': (BuildContext context) => const AutosuggestWidget(),
      //   '/Geocode': (BuildContext context) => const GeocodeWidget(),
      //   '/ReverseGeocode': (BuildContext context) =>
      //       const ReverseGeocodeWidget(),
      //   '/Nearby': (BuildContext context) => const NearbyWidget(),
      //   '/Direction': (BuildContext context) => const DirectionWidget(),
      //   '/POIAlongRoute': (BuildContext context) => const PoiAlongRouteWidget(),
      //   '/PlaceDetail': (BuildContext context) => const PlaceDetailWidget(),
      //   '/PlaceSearchUI': (BuildContext context) => const PlaceSearchWidget(),
      //   '/PlacePickerUI': (BuildContext vcontext) => const PlacePickerWidget(),
      //   '/DirectionUI': (BuildContext context) => const DirectionUIWidget(),
      //   '/NearbyUI': (BuildContext context) => const NearbyUIWidget(),
      //   '/Tracking': (BuildContext context) => const TrackingWidget(),
      //   '/AddPolyline': (BuildContext context) => const AddPolyline(),
      //   '/GradientPolyline': (BuildContext context) =>
      //       const AddGradientPolyline(),
      // },
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}

final _router = GoRouter(
  routes: [
    // GoRoute(
    //   path: '/',
    //   builder: (context, state) => LoginScreen(),
    // ),
    // GoRoute(
    //   path: '/profileScreen',
    //   builder: (context, state) => const ProfileScreen(),
    // ),
    GoRoute(path: '/', builder: (context, state) => MapScreen(), routes: [
      GoRoute(
        path: 'share',
        builder: (context, state) => AddEventsScreen(),
      )
    ])
  ],
);
