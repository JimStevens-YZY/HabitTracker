import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart' as ph;


class FunctionPage extends StatefulWidget {
  @override
  _FunctionPageState createState() => _FunctionPageState();
}

class _FunctionPageState extends State<FunctionPage> {
  GoogleMapController? mapController;
  final Set<Marker> _markers = {};
  LatLng _currentPosition = LatLng(51.5072, -0.1276);
  bool _isRecorderInitialized = false;
  bool _isRecording = false;
  int? _noiseLevel;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    Location location = new Location();

    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    LocationData currentLocation = await location.getLocation();

    setState(() {
      _currentPosition =
          LatLng(currentLocation.latitude ?? 0, currentLocation.longitude ?? 0);
    });
  }


  Future<void> _fetchNearbyTheaters(LatLng currentPosition) async {
    const apiKey = 'AIzaSyAdTknHEdeDrUvMahgZawQo2JwmpafovPo';
    final String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${currentPosition.latitude},${currentPosition.longitude}&radius=10000&type=theatre&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _updateMarkers(data['results']);
    } else {
      print('Failed to load nearby theatres. Error: ${response.body}');
    }
  }

  void _updateMarkers(List<dynamic> theaters) {
    setState(() {
      _markers.clear();
      for (var theater in theaters) {
        final marker = Marker(
          markerId: MarkerId(theater['place_id']),
          position: LatLng(theater['geometry']['location']['lat'],
              theater['geometry']['location']['lng']),
          infoWindow: InfoWindow(
            title: theater['name'],
            snippet: theater['vicinity'],
          ),
        );
        _markers.add(marker);
      }
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    const int noiseThreshold = 70;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 400,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: SizedBox(
                  height: size.height,
                  width: size.width * 0.85,
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _currentPosition,
                      zoom: 12.0,
                    ),
                    markers: _markers,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
