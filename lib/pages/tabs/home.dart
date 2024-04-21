import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' // new
    hide
        EmailAuthProvider,
        PhoneAuthProvider;
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'widgets.dart';
import 'authentication.dart';
import 'guest_book.dart';
import 'package:go_router/go_router.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
          title: const Text('Home',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
        backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
        body: const HomeMain());
  }
}

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  String? _currentAddress;
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled return an error message
      print('Location services are disabled.');
    }

    // Check location permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return print(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // If permissions are granted, return the current location
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = '${place.street}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

/*  Future<void> _getCurrentLocation() async {
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
  }*/
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView(padding: const EdgeInsets.all(15), children: <Widget>[
      const Text("Explore EventGather",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
      const SizedBox(
        width: double.infinity,
        height: 20,
      ),
      const Text("Popular now",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
      const SizedBox(
        width: double.infinity,
        height: 10,
      ),
      SizedBox(
        height: 315,
        child: Consumer<ApplicationState>(
            builder: (context, appState, _) => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(15),
                  itemCount: appState.allEvent
                      .where((element) => element.eventCategory == 1)
                      .toList()
                      .length,
                  itemBuilder: ((context, index) {
                    final event = appState.allEvent
                        .where((element) => element.eventCategory == 1)
                        .toList()[index];
                    return Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              // 点击事件代码
                              GoRouter.of(context)
                                  .push('/eventDetails/${event.eventId}');
                            },
                            child: Container(
                              width: 240.0,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.2), //边框颜色
                                    width: 1, //边框宽度
                                  ), // 边色与边宽度
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 10, //阴影范围
                                      spreadRadius: 0.1, //阴影浓度
                                      color:
                                          Colors.grey.withOpacity(0.2), //阴影颜色
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              child: Column(
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    child: Image.network(event.eventBg,
                                        height: 145,
                                        width: double.infinity,
                                        fit: BoxFit.cover),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 3.0, top: 5.0),
                                            child: Text(
                                              '${event.eventDate} ${event.eventTime}',
                                              style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      131, 112, 83, 1),
                                                  fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.start,
                                            )),
                                        SizedBox(
                                          height: 45,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 3.0),
                                            child: Text(
                                              event.eventDesc,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              //textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 0.0),
                                          child: Text(
                                            event.eventName,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            //textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(
                                              width: 180,
                                              child: Text(
                                                event.eventLocation,
                                                style: const TextStyle(
                                                    color: Color.fromRGBO(
                                                        118, 118, 119, 1.0),
                                                    fontSize: 13),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const Icon(Icons.bookmark_border,
                                                color: Color.fromRGBO(
                                                    160, 160, 160, 1.0))
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
                        const SizedBox(
                          width: 20,
                          height: 200,
                        ),
                      ],
                    );
                  }),
                )),
      ),
      const SizedBox(
        width: double.infinity,
        height: 10,
      ),
      const Text("Career & Business",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
      const SizedBox(
        width: double.infinity,
        height: 10,
      ),
      SizedBox(
        height: 315,
        child: Consumer<ApplicationState>(
            builder: (context, appState, _) => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(15),
                  itemCount: appState.allEvent
                      .where((element) => element.eventCategory == 2)
                      .toList()
                      .length,
                  itemBuilder: ((context, index) {
                    final event = appState.allEvent
                        .where((element) => element.eventCategory == 2)
                        .toList()[index];
                    return Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              // 点击事件代码
                              GoRouter.of(context)
                                  .push('/eventDetails/${event.eventId}');
                            },
                            child: Container(
                              width: 240.0,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.2), //边框颜色
                                    width: 1, //边框宽度
                                  ), // 边色与边宽度
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 10, //阴影范围
                                      spreadRadius: 0.1, //阴影浓度
                                      color:
                                          Colors.grey.withOpacity(0.2), //阴影颜色
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              child: Column(
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    child: Image.network(event.eventBg,
                                        height: 145,
                                        width: double.infinity,
                                        fit: BoxFit.cover),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 3.0, top: 5.0),
                                            child: Text(
                                              '${event.eventDate} ${event.eventTime}',
                                              style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      131, 112, 83, 1),
                                                  fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.start,
                                            )),
                                        SizedBox(
                                          height: 45,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 3.0),
                                            child: Text(
                                              event.eventDesc,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              //textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 0.0),
                                          child: Text(
                                            event.eventName,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            //textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(
                                              width: 180,
                                              child: Text(
                                                event.eventLocation,
                                                style: const TextStyle(
                                                    color: Color.fromRGBO(
                                                        118, 118, 119, 1.0),
                                                    fontSize: 13),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const Icon(Icons.bookmark_border,
                                                color: Color.fromRGBO(
                                                    160, 160, 160, 1.0))
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
                        const SizedBox(
                          width: 20,
                          height: 200,
                        ),
                      ],
                    );
                  }),
                )),
      ),
      const Text("Outdoors & Adventure",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
      const SizedBox(
        width: double.infinity,
        height: 10,
      ),
      SizedBox(
        height: 315,
        child: Consumer<ApplicationState>(
            builder: (context, appState, _) => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(15),
                  itemCount: appState.allEvent
                      .where((element) => element.eventCategory == 3)
                      .toList()
                      .length,
                  itemBuilder: ((context, index) {
                    final event = appState.allEvent
                        .where((element) => element.eventCategory == 3)
                        .toList()[index];
                    return Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              // 点击事件代码
                              GoRouter.of(context)
                                  .push('/eventDetails/${event.eventId}');
                            },
                            child: Container(
                              width: 240.0,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.2), //边框颜色
                                    width: 1, //边框宽度
                                  ), // 边色与边宽度
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 10, //阴影范围
                                      spreadRadius: 0.1, //阴影浓度
                                      color:
                                          Colors.grey.withOpacity(0.2), //阴影颜色
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              child: Column(
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    child: Image.network(event.eventBg,
                                        height: 145,
                                        width: double.infinity,
                                        fit: BoxFit.cover),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 3.0, top: 5.0),
                                            child: Text(
                                              '${event.eventDate} ${event.eventTime}',
                                              style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      131, 112, 83, 1),
                                                  fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.start,
                                            )),
                                        SizedBox(
                                          height: 45,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 3.0),
                                            child: Text(
                                              event.eventDesc,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              //textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 0.0),
                                          child: Text(
                                            event.eventName,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            //textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(
                                              width: 180,
                                              child: Text(
                                                event.eventLocation,
                                                style: const TextStyle(
                                                    color: Color.fromRGBO(
                                                        118, 118, 119, 1.0),
                                                    fontSize: 13),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const Icon(Icons.bookmark_border,
                                                color: Color.fromRGBO(
                                                    160, 160, 160, 1.0))
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
                        const SizedBox(
                          width: 20,
                          height: 200,
                        ),
                      ],
                    );
                  }),
                )),
      ),
      const Text("Learning",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
      const SizedBox(
        width: double.infinity,
        height: 10,
      ),
      SizedBox(
        height: 315,
        child: Consumer<ApplicationState>(
            builder: (context, appState, _) => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(15),
                  itemCount: appState.allEvent
                      .where((element) => element.eventCategory == 4)
                      .toList()
                      .length,
                  itemBuilder: ((context, index) {
                    final event = appState.allEvent
                        .where((element) => element.eventCategory == 4)
                        .toList()[index];
                    return Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              // 点击事件代码
                              GoRouter.of(context)
                                  .push('/eventDetails/${event.eventId}');
                            },
                            child: Container(
                              width: 240.0,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.2), //边框颜色
                                    width: 1, //边框宽度
                                  ), // 边色与边宽度
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 10, //阴影范围
                                      spreadRadius: 0.1, //阴影浓度
                                      color:
                                          Colors.grey.withOpacity(0.2), //阴影颜色
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              child: Column(
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    child: Image.network(event.eventBg,
                                        height: 145,
                                        width: double.infinity,
                                        fit: BoxFit.cover),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 3.0, top: 5.0),
                                            child: Text(
                                              '${event.eventDate} ${event.eventTime}',
                                              style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      131, 112, 83, 1),
                                                  fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.start,
                                            )),
                                        SizedBox(
                                          height: 45,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 3.0),
                                            child: Text(
                                              event.eventDesc,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              //textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 0.0),
                                          child: Text(
                                            event.eventName,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            //textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(
                                              width: 180,
                                              child: Text(
                                                event.eventLocation,
                                                style: const TextStyle(
                                                    color: Color.fromRGBO(
                                                        118, 118, 119, 1.0),
                                                    fontSize: 13),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const Icon(Icons.bookmark_border,
                                                color: Color.fromRGBO(
                                                    160, 160, 160, 1.0))
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
                        const SizedBox(
                          width: 20,
                          height: 200,
                        ),
                      ],
                    );
                  }),
                )),
      ),
      const Text("Health & Wellness",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
      const SizedBox(
        width: double.infinity,
        height: 10,
      ),
      SizedBox(
        height: 315,
        child: Consumer<ApplicationState>(
            builder: (context, appState, _) => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(15),
                  itemCount: appState.allEvent
                      .where((element) => element.eventCategory == 5)
                      .toList()
                      .length,
                  itemBuilder: ((context, index) {
                    final event = appState.allEvent
                        .where((element) => element.eventCategory == 5)
                        .toList()[index];
                    return Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              // 点击事件代码
                              GoRouter.of(context)
                                  .push('/eventDetails/${event.eventId}');
                            },
                            child: Container(
                              width: 240.0,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.2), //边框颜色
                                    width: 1, //边框宽度
                                  ), // 边色与边宽度
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 10, //阴影范围
                                      spreadRadius: 0.1, //阴影浓度
                                      color:
                                          Colors.grey.withOpacity(0.2), //阴影颜色
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              child: Column(
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    child: Image.network(event.eventBg,
                                        height: 145,
                                        width: double.infinity,
                                        fit: BoxFit.cover),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 3.0, top: 5.0),
                                            child: Text(
                                              '${event.eventDate} ${event.eventTime}',
                                              style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      131, 112, 83, 1),
                                                  fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.start,
                                            )),
                                        SizedBox(
                                          height: 45,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 3.0),
                                            child: Text(
                                              event.eventDesc,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              //textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 0.0),
                                          child: Text(
                                            event.eventName,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            //textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(
                                              width: 180,
                                              child: Text(
                                                event.eventLocation,
                                                style: const TextStyle(
                                                    color: Color.fromRGBO(
                                                        118, 118, 119, 1.0),
                                                    fontSize: 13),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const Icon(Icons.bookmark_border,
                                                color: Color.fromRGBO(
                                                    160, 160, 160, 1.0))
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
                        const SizedBox(
                          width: 20,
                          height: 200,
                        ),
                      ],
                    );
                  }),
                )),
      ),
      const Text("Tech",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
      const SizedBox(
        width: double.infinity,
        height: 10,
      ),
      SizedBox(
        height: 315,
        child: Consumer<ApplicationState>(
            builder: (context, appState, _) => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(15),
                  itemCount: appState.allEvent
                      .where((element) => element.eventCategory == 6)
                      .toList()
                      .length,
                  itemBuilder: ((context, index) {
                    final event = appState.allEvent
                        .where((element) => element.eventCategory == 6)
                        .toList()[index];
                    return Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              // 点击事件代码
                              GoRouter.of(context)
                                  .push('/eventDetails/${event.eventId}');
                            },
                            child: Container(
                              width: 240.0,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.2), //边框颜色
                                    width: 1, //边框宽度
                                  ), // 边色与边宽度
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 10, //阴影范围
                                      spreadRadius: 0.1, //阴影浓度
                                      color:
                                          Colors.grey.withOpacity(0.2), //阴影颜色
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              child: Column(
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    child: Image.network(event.eventBg,
                                        height: 145,
                                        width: double.infinity,
                                        fit: BoxFit.cover),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 3.0, top: 5.0),
                                            child: Text(
                                              '${event.eventDate} ${event.eventTime}',
                                              style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      131, 112, 83, 1),
                                                  fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.start,
                                            )),
                                        SizedBox(
                                          height: 45,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 3.0),
                                            child: Text(
                                              event.eventDesc,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              //textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 0.0),
                                          child: Text(
                                            event.eventName,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            //textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(
                                              width: 180,
                                              child: Text(
                                                event.eventLocation,
                                                style: const TextStyle(
                                                    color: Color.fromRGBO(
                                                        118, 118, 119, 1.0),
                                                    fontSize: 13),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const Icon(Icons.bookmark_border,
                                                color: Color.fromRGBO(
                                                    160, 160, 160, 1.0))
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
                        const SizedBox(
                          width: 20,
                          height: 200,
                        ),
                      ],
                    );
                  }),
                )),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('LAT: ${_currentPosition?.latitude ?? ""}'),
          Text('LNG: ${_currentPosition?.longitude ?? ""}'),
          Text('ADDRESS: ${_currentAddress ?? ""}'),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: _determinePosition,
            child: const Text("Get Current Location"),
          )
        ],
      ),
/*    FutureBuilder(
      future: _determinePosition(),
      builder: (context, snapshot) {
        return Column(
          children: [
            Text('LAT: ${_currentPosition?.latitude ?? ""}'),
            Text('LNG: ${_currentPosition?.longitude ?? ""}'),
            Text('ADDRESS: ${_currentAddress ?? ""}'),
          ],
        );
      },
    ),*/
/*      Consumer<ApplicationState>(
        builder: (context, appState, _) => AuthFunc(
            loggedIn: appState.loggedIn,
            signOut: () {
              FirebaseAuth.instance.signOut();
            }),
      ),*/

/*      Consumer<ApplicationState>(
        builder: (context, appState, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (appState.loggedIn) ...[
              const Header('Discussion'),
              GuestBook(
                addMessage: (message) =>
                    appState.addMessageToGuestBook(message),
                messages: appState.guestBookMessages,
              ),
            ],
          ],
        ),
      ),*/
    ]);
  }
}
