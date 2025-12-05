import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MyMapWidget extends StatefulWidget {
  @override
  State<MyMapWidget> createState() => _MyMapWidgetState();
}

class _MyMapWidgetState extends State<MyMapWidget> {
  final MapController _mapController = MapController();


  void _zoomIn() {
    final camera = _mapController.camera;
    final newZoom = (camera.zoom + 1).clamp(0.0, 20.0);

    _mapController.move(camera.center, newZoom);


  }

  void _zoomOut() {
    final camera = _mapController.camera;
    final newZoom = (camera.zoom - 1).clamp(0.0, 20.0);

    _mapController.move(camera.center, newZoom);
  }
  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: LatLng(0, 16),
              initialZoom: 2.8,
              backgroundColor: Colors.black,
    interactionOptions: const InteractionOptions(
    flags: InteractiveFlag.none, // disables drag + everything
    ),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png',
                //'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                // tileBuilder: themeProvider.themeMode == ThemeMode.dark
                //     ? darkModeTileBuilder
                //     : null,
                userAgentPackageName: 'com.afro.idsr', // ensure set
              ),
              // MarkerLayer(
              //   markers: [
              //     Marker(
              //       width: 80,
              //       height: 80,
              //       point: const LatLng(-1.95, 30.06),
              //       child: const Icon(Icons.location_on, size: 40, color: Colors.red),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
        Positioned(
          right: 5,
          bottom: 10,
          child: Column(
            children: [
              _zoomButton(Icons.add, _zoomIn),
              const SizedBox(height: 3),
              _zoomButton(Icons.remove, _zoomOut),
            ],
          ),
        ),
      ],
    );
  }

  Widget _zoomButton(IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.white,
      elevation: 4,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: SizedBox(
          height: 25,
          width: 25,
          child: Icon(icon, size: 18),
        ),
      ),
    );
  }
}
