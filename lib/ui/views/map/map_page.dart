// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:geolocator/geolocator.dart';
// // import 'package:flutter_map/flutter_map.dart';
// // import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:latlong2/latlong.dart';
//
// class MapPage extends StatefulWidget {
//   const MapPage({super.key});
//
//   @override
//   State<MapPage> createState() => _MapPageState();
// }
//
// final Completer<GoogleMapController> _controller =
//     Completer<GoogleMapController>();
//
// Future<Position> getUserCurrentLocation() async {
//   await Geolocator.requestPermission()
//       .then((value) {})
//       .onError((error, stackTrace) async {
//     await Geolocator.requestPermission();
//     print("ERROR" + error.toString());
//   });
//   return await Geolocator.getCurrentPosition();
// }
//
// final List<Marker> _markers = <Marker>[
//   Marker(
//       markerId: MarkerId('1'),
//       position: LatLng(20.42796133580664, 75.885749655962),
//       infoWindow: InfoWindow(
//         title: 'My Position',
//       )),
// ];
//
// class _MapPageState extends State<MapPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         mapType: MapType.normal,
//         initialCameraPosition: CameraPosition(
//             target: LatLng(47.91320396117613, 106.92863171828164), zoom: 17),
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//         markers: Set<Marker>.of(_markers),
//         // liteModeEnabled: true,
//         myLocationEnabled: true,
//       ),
//       floatingActionButton: Stack(
//         children: [
//           Positioned(
//             right: 0,
//             bottom: 80.h,
//             child: FloatingActionButton(
//               onPressed: () async {
//                 getUserCurrentLocation().then((value) async {
//                   print(value.latitude.toString() +
//                       " " +
//                       value.longitude.toString());
//
//                   // marker added for current users location
//                   _markers.add(Marker(
//                     markerId: MarkerId("2"),
//                     position: LatLng(value.latitude, value.longitude),
//                     infoWindow: InfoWindow(
//                       title: 'My Current Location',
//                     ),
//                   ));
//
//                   // specified current users location
//                   CameraPosition cameraPosition = new CameraPosition(
//                     target: LatLng(value.latitude, value.longitude),
//                     zoom: 14,
//                   );
//
//                   final GoogleMapController controller =
//                       await _controller.future;
//                   controller.animateCamera(
//                       CameraUpdate.newCameraPosition(cameraPosition));
//                   setState(() {});
//                 });
//               },
//               child: Icon(Icons.local_activity),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
