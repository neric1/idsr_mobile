import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:idsr/data/entity/models/tracked_entity.dart';
import 'package:idsr/presentation/map_legend.dart';
import 'package:idsr/utils/utils.dart';
import 'package:latlong2/latlong.dart';
const _oceanColor = Color(0xFFD6DFE6);
const _landColor = Color(0xFFF2F2F2);
const  removedCountry=[ "morocco","libya", "tunisia", "sudan", "egypt", "djibouti", "somalia","somaliland","w sahara"];
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
  List<({String name, LatLng point, double minZoom})> labels = [];
  Map<String, int> counts = {};
  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
  final polygonHitNotifier =
  ValueNotifier<LayerHitResult<Object>?>(null);



  @override
  void initState() {
    // TODO: implement initState'

  counts=getTrackedEntity(widget.trackedEntity);

  _loadGeoJson();
    super.initState();
  }

  void _onMapTap() {
    final result = polygonHitNotifier.value;
    if (result == null || result.hitValues.isEmpty) return;
    final hit = result.hitValues.first as ({String name, int count});
    _showTooltip(context, hit.name, '${hit.count} ongoing events');
  }

  getTrackedEntity(List<TrackedEntity> trackedEntity){
    final Map<String, int> counts = {};

    for (var instance in trackedEntity) {
      if (instance.enrollments != null && instance.enrollments.isNotEmpty) {
        final orgUnitName = instance.enrollments[0].orgUnitName as String?;
        final orgUnitId = instance.enrollments[0].orgUnit as String?;
        if (orgUnitName != null) {
          counts[normalizeCountryName(getCountryNameOnMap(orgUnitId!,orgUnitName))] = (counts[normalizeCountryName(getCountryNameOnMap(orgUnitId,orgUnitName))] ?? 0) + 1;
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
    if (count >= 9) return  Colors.red.shade900;
    if (count >= 6) return Colors.orange.shade900;
    if (count >= 3) return Colors.orange.shade300;
    if (count >= 1) return  Colors.yellow.shade200;
    return  Color(0xFF248f24);
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
      String displayName,
      List<Polygon> polygons,
      List<Marker> markers,
      ) {
    final points = geoJsonRingToLatLng(ring);

    final int count = counts[countryName] ?? 0;
    final bool isRemoved = removedCountry.contains(countryName);

    final fillColor = isRemoved?Color(0xFFF2EFE9 ) :colorForCount(count);

    polygons.add(
      Polygon(
        points: points,
        // Blend onto a land colour so fills look the same without a basemap.
        color: Color.alphaBlend(fillColor.withOpacity(0.6), _landColor),
        borderColor: Colors.blueGrey,
        borderStrokeWidth: 1,
        hitValue: isRemoved ? null : (name: displayName, count: count),
      ),
    );

    // if (shouldShowCircle(count)) {
    //   final size = circleSizeForCount(count);
    //
    //   markers.add(
    //     Marker(
    //       width: size,
    //       height: size,
    //       point: _computeCentroid(points),
    //       child: Container(
    //         decoration: BoxDecoration(
    //           shape: BoxShape.circle,
    //           color: fillColor,
    //           border: Border.all(color: Colors.red.shade900, width: 1),
    //         ),
    //       ),
    //     ),
    //   );
    // }
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
    final List<({String name, LatLng point, double minZoom})> tempLabels = [];

    for (final feature in jsonData['features']) {
      final properties = feature['properties'];
      final rawName = properties['name'];
      final name = normalizeCountryName(rawName);

      // Natural Earth ships a label anchor and the zoom at which to show it.
      tempLabels.add((
        name: rawName,
        point: LatLng((properties['label_y'] as num).toDouble(), (properties['label_x'] as num).toDouble()),
        minZoom: (properties['min_label'] as num).toDouble(),
      ));



      final geometry = feature['geometry'];

      if (geometry['type'] == 'Polygon') {
        final ring = geometry['coordinates'][0];
        _addPolygon(ring, name, rawName, tempPolygons, tempMarkers);
      }

      if (geometry['type'] == 'MultiPolygon') {
        for (final poly in geometry['coordinates']) {
          final ring = poly[0];
          _addPolygon(ring, name, rawName, tempPolygons, tempMarkers);
        }
      }
    }

    setState(() {
      polygons = tempPolygons;
      markers = tempMarkers;
      labels = tempLabels..sort((a, b) => a.minZoom.compareTo(b.minZoom));
    });
  }

  Widget _buildCountryLabels(BuildContext context) {
    final camera = MapCamera.of(context);
    // Labels are sorted by importance; skip any that would overlap one already placed.
    final placed = <Rect>[];
    final visible = labels.where((label) {
      if (label.minZoom > camera.zoom + 0.5) return false;
      final p = camera.latLngToScreenPoint(label.point);
      final rect = Rect.fromCenter(
        center: Offset(p.x, p.y),
        width: label.name.length * 5.5 + 4,
        height: 12,
      );
      if (placed.any(rect.overlaps)) return false;
      placed.add(rect);
      return true;
    }).toList();
    return MarkerLayer(
      markers: [
        for (final label in visible)
          Marker(
            point: label.point,
            width: 100,
            height: 12,
            child: IgnorePointer(
              child: Text(
                label.name.toUpperCase(),
                textAlign: TextAlign.center,
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.visible,
                style: const TextStyle(
                  fontSize: 7,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                  color: Colors.black54,
                  shadows: [Shadow(color: Colors.white70, blurRadius: 2)],
                ),
              ),
            ),
          ),
      ],
    );
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
              initialZoom: 2.6,
              backgroundColor: _oceanColor,
    interactionOptions: const InteractionOptions(
    flags: InteractiveFlag.none,
    ),
            ),
            children: [
              // No basemap tiles: the GeoJSON polygons and labels below are
              // the whole map, so it has no third-party tile dependency.
              if (polygons.isNotEmpty)
                GestureDetector(
                  onTap: _onMapTap,
                  child: PolygonLayer(
                    hitNotifier: polygonHitNotifier,
                    polygons: polygons,
                  ),
                ),
              if (labels.isNotEmpty)
                Builder(builder: _buildCountryLabels),
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
          child:  MapLegend(),
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
void _showTooltip(BuildContext context, String country, String details) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(country),
      content: Text(details),
    ),
  );
}