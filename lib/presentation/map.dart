import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MyMapWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(0, 16),
        initialZoom: 2.9,

      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.afro.idsr', // ensure set
        ),
        MarkerLayer(
          markers: [
            Marker(
              width: 80,
              height: 80,
              point: const LatLng(-1.95, 30.06),
              child: const Icon(Icons.location_on, size: 40, color: Colors.red),
            ),
          ],
        ),
      ],
    );
  }
}
