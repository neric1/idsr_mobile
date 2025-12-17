import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:idsr/data/entity/models/tracked_entity.dart';
import 'package:idsr/presentation/map_legend.dart';
import 'package:latlong2/latlong.dart';

class MyMapWidget extends StatefulWidget {
  List<TrackedEntity> trackedEntity;
  MyMapWidget({super.key,required this.trackedEntity});

  @override
  State<MyMapWidget> createState() => _MyMapWidgetState();
}

class _MyMapWidgetState extends State<MyMapWidget> {
  final MapController _mapController = MapController();
  List<Polygon> polygons = [];
  List<Marker> markers = [];
  Map<String, int> counts = {};
  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
@override
  void initState() {
    // TODO: implement initState'

  counts=getTrackedEntity(widget.trackedEntity);
  _loadGeoJson();

    super.initState();
  }
  getTrackedEntity(List<TrackedEntity> trackedEntity){
    final Map<String, int> counts = {};

    for (var instance in trackedEntity) {
      if (instance.enrollments != null && instance.enrollments.isNotEmpty) {
        final orgUnitName = instance.enrollments[0].orgUnitName as String?;
        if (orgUnitName != null) {
          counts[normalizeCountryName(orgUnitName)] = (counts[normalizeCountryName(orgUnitName)] ?? 0) + 1;
        }
      }
    }
  return counts;
  }
  void _zoomIn() {
    final camera = _mapController.camera;
    final newZoom = (camera.zoom + 0.5).clamp(0.0, 20.0);

    _mapController.move(camera.center, newZoom);


  }

  void _zoomOut() {
    final camera = _mapController.camera;
    final newZoom = (camera.zoom - 0.5).clamp(0.0, 20.0);

    _mapController.move(camera.center, newZoom);
  }
  Color colorForCount(int count) {
    if (count >= 10) return const Color(0xFFD95B43); // red
    if (count >= 8) return const Color(0xFFF6C85F);
    if (count >= 6) return const Color(0xFFFFF3B0);
    if (count >= 4) return const Color(0xFFD98C5F);
    if (count >= 2) return const Color(0xFFF2C18D);
    if (count >= 1) return const Color(0xFFF8E6CC);
    return  Colors.grey;
  }
  List<LatLng> geoJsonRingToLatLng(List ring) {
    return ring.map<LatLng>((point) {
      return LatLng(
        (point[1] as num).toDouble(),
        (point[0] as num).toDouble(),
      );
    }).toList();
  }

  bool shouldShowCircle(int count) {
    return count >= 6; // 🔴 show only medium+ risk
  }

  double circleSizeForCount(int count) {
    if (count >= 10) return 20;
    if (count >= 8) return 16;
    if (count >= 6) return 12;
    return 0;
  }

  void _addPolygon(
      List ring,
      String countryName,
      List<Polygon> polygons,
      List<Marker> markers,
      ) {
    final points = geoJsonRingToLatLng(ring);

    final int count = counts[countryName] ?? 0;

    final fillColor = colorForCount(count);

    polygons.add(
      Polygon(
        points: points,
        color: fillColor.withOpacity(0.6),
        borderColor: Colors.blueGrey,
        borderStrokeWidth: 1,
      ),
    );

    if (shouldShowCircle(count)) {
      final size = circleSizeForCount(count);

      markers.add(
        Marker(
          width: size,
          height: size,
          point: _computeCentroid(points),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: fillColor,
              border: Border.all(color: Colors.red.shade900, width: 1),
            ),
          ),
        ),
      );
    }
  }
  String normalizeCountryName(String name) {
    return name
        .toLowerCase()
        .replaceAll("’", "'")
        .replaceAll("ô", "o")
        .replaceAll("é", "e")
        .replaceAll("ê", "e")
        .replaceAll(RegExp(r'[^a-z\s]'), '')
        .trim();
  }


  Future<void> _loadGeoJson() async {
    final data = await rootBundle.loadString('assets/world.json');
    final jsonData = jsonDecode(data);

    final List<Polygon> tempPolygons = [];
    final List<Marker> tempMarkers = [];

    for (final feature in jsonData['features']) {
      final rawName = feature['properties']['name'];
      final name = normalizeCountryName(rawName);

      final geometry = feature['geometry'];

      if (geometry['type'] == 'Polygon') {
        final ring = geometry['coordinates'][0];
        _addPolygon(ring, name, tempPolygons, tempMarkers);
      }

      if (geometry['type'] == 'MultiPolygon') {
        for (final poly in geometry['coordinates']) {
          final ring = poly[0];
          _addPolygon(ring, name, tempPolygons, tempMarkers);
        }
      }
    }

    setState(() {
      polygons = tempPolygons;
      markers = tempMarkers;
    });
  }

  // Future<void> _loadGeoJson() async {
  //   final data = await rootBundle.loadString('assets/world.json');
  //   final jsonData = jsonDecode(data);
  //
  //   final List<Polygon> tempPolygons = [];
  //   final List<Marker> tempMarkers = [];
  //
  //   for (var feature in jsonData['features']) {
  //     final name = feature['properties']['name'];
  //     // if (name != 'Rwanda') continue; // only Rwanda
  //
  //     final coordinates = feature['geometry']['coordinates'][0];
  //     final points = coordinates.map<LatLng>((c) => LatLng(c[1], c[0])).toList();
  //     final int count = counts[name] ?? 0;
  //     print("object====");
  //     print(count);
  //     print(name);
  //     final Color fillColor = colorForCount(count);
  //     tempPolygons.add(
  //       Polygon(
  //         points: points,
  //         color: fillColor.withOpacity(0.6),
  //         borderColor: Colors.blue,
  //         borderStrokeWidth: 2,
  //       ),
  //     );
  //     final centroid = _computeCentroid(points);
  //     tempMarkers.add(
  //       Marker(
  //         width: 14,
  //         height: 14,
  //         point: centroid,
  //         child:  Container(
  //           decoration: BoxDecoration(
  //             shape: BoxShape.circle,
  //             color: fillColor.withOpacity(0.7),
  //             border: Border.all(color: Colors.red.shade900, width: 1),
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  //
  //   setState(() {
  //     polygons = tempPolygons;
  //     markers = tempMarkers;
  //   });
  // }


  LatLng _computeCentroid(List<LatLng> points) {
    double latSum = 0;
    double lngSum = 0;
    for (var p in points) {
      latSum += p.latitude;
      lngSum += p.longitude;
    }
    return LatLng(latSum / points.length, lngSum / points.length);
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
              initialZoom: 2.5,
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

              if (polygons.isNotEmpty)
                PolygonLayer(
                  polygons: polygons,
                ),
              if (markers.isNotEmpty)
                MarkerLayer(markers: markers),
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
        Positioned(
          bottom: 0,
          left: 0,
          child: const MapLegend(),
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
