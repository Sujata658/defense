import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:kasarijaane/components/constants.dart';
import 'package:latlong2/latlong.dart';
import '../components/searchbar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

class MainHome extends StatefulWidget {
  MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  LatLng center = LatLng(27.681932894249172, 85.31878090723217);

  @override
  void initState() {
    getCenter();
    super.initState();
  }

  void getCenter() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      center = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<LatLng> latLngList = [
      LatLng(27.681932894249172, 85.31878090723217),
      LatLng(27.617245, 85.323459),
      LatLng(27.687945, 85.353459),
      LatLng(center.latitude, center.longitude),
    ];

    List<Marker> _markers = latLngList
        .map((point) => Marker(
              point: point,
              width: 60,
              height: 60,
              builder: (context) => Icon(
                Icons.pin_drop,
                size: 40,
                color: Colors.blueAccent,
              ),
            ))
        .toList();

    return Scaffold(
      backgroundColor: kgrey,
      body: Column(
        children: [
          Flexible(
            child: Mapintro(
              center: center,
              markers: _markers,
            ),
          ),
          SearchBar(
            label: 'Search for pickup',
          ),
          SearchBar(
            label: 'Search for destination',
          ),
        ],
      ),
    );
  }
}

class Mapintro extends StatelessWidget {
  const Mapintro({
    Key? key,
    required this.center,
    required List<Marker> markers,
  })  : _markers = markers,
        super(key: key);

  final LatLng center;
  final List<Marker> _markers;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FlutterMap(
        options: MapOptions(
          center: center,
          zoom: 15,
          minZoom: 5.0,
          maxZoom: 18,
        ),
        nonRotatedChildren: [
          AttributionWidget(
            attributionBuilder: (attr) => Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'attr',
                style: TextStyle(fontSize: 10.0),
              ),
            ),
          ),
        ],
        children: [
          TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          MarkerClusterLayerWidget(
            options: MarkerClusterLayerOptions(
              maxClusterRadius: 120,
              size: Size(40, 40),
              fitBoundsOptions: FitBoundsOptions(
                padding: EdgeInsets.all(50),
              ),
              markers: _markers,
              polygonOptions: PolygonOptions(
                borderColor: Colors.blueAccent,
                color: Colors.black12,
                borderStrokeWidth: 3,
              ),
              builder: (context, markers) {
                return FloatingActionButton(
                  child: Text(markers.length.toString()),
                  onPressed: null,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
