import 'package:flutter/material.dart';
import '../../res/listData.dart';

import 'package:firebase_auth/firebase_auth.dart' // new
    hide
        EmailAuthProvider,
        PhoneAuthProvider;
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart' as ph;

class EventDetailsPage extends StatelessWidget {
  final String eventId;

  const EventDetailsPage({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
            title: const Text('Event',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))),
        backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
        body: EventDetailsMain(eventId: this.eventId));
  }
}

class EventDetailsMain extends StatefulWidget {
  final String eventId;

  const EventDetailsMain({super.key, required this.eventId});

  @override
  State<EventDetailsMain> createState() => _EventDetailsMainState();
}

class _EventDetailsMainState extends State<EventDetailsMain>
    with TickerProviderStateMixin {
  late TabController tabController;

  final _formKey = GlobalKey<FormState>(debugLabel: '_GuestBookState');
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 3);

    tabController.addListener(() {
      if (tabController.animation!.value == tabController.index) {
        print(tabController.index); //获取点击或滑动页面的索引值 }
      }
    });
  }

  List<Widget> _getListData() {
    var tempList = listData.map((value) {
      return Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: const Color.fromRGBO(233, 233, 233, 0.9), width: 1)),
        child: Column(
          children: <Widget>[
            Image.network(value['imageUrl']),
            const SizedBox(height: 12),
            Text(
              value['title'],
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            )
          ],
        ),
      );
    });
    return tempList.toList();
  }

  @override
  Widget build(BuildContext context) {
    final _future = FirebaseFirestore.instance
        .collection("allEvents")
        .doc(widget.eventId)
        .get();

    CollectionReference groups =
        FirebaseFirestore.instance.collection('groups');

    GoogleMapController? mapController;
    final _markers = {
      const Marker(
        markerId: MarkerId('Sydney'),
        position: LatLng(51.5072, -0.1276),
      )
    };
    LatLng _currentPosition = LatLng(51.5072, -0.1276);

    void _onMapCreated(GoogleMapController controller) {
      mapController = controller;
      //_getCurrentLocation();
    }

/*    final db = FirebaseFirestore.instance;
    var data;
    final docRef = db.collection("allEvents").doc("fnGPOnnVNV6uhwzvltvR");
    docRef.get().then(
          (DocumentSnapshot doc) {
        data = doc.data();
        print('${widget.eventId}${data}aadasd');
        // ...
      },
      onError: (e) => print("Error getting document: $e"),
    );*/
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final event = snapshot.data!;
        return Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 200,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(event['eventBg'],
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Text(event['eventName'],
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                    padding: EdgeInsets.only(top: 3),
                                    child: Icon(Icons.calendar_today_outlined,
                                        size: 20,
                                        color:
                                            Color.fromRGBO(99, 100, 112, 1.0))),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(event['eventDate'],
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600)),
                                    Text('${event['eventTime']} GMT',
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400))
                                  ],
                                )
                              ],
                            ),
                            const Icon(Icons.chevron_right_rounded,
                                size: 30,
                                color: Color.fromRGBO(99, 100, 112, 1.0)),
                          ],
                        ),
                        const Divider(),
                        Row(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                    padding: EdgeInsets.only(top: 3),
                                    child: Icon(Icons.camera,
                                        size: 20,
                                        color:
                                            Color.fromRGBO(99, 100, 112, 1.0))),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 300,
                                      child: Text(
                                        event['eventLocation'],
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const Text('Link visible for attendees',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400))
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 25),
                        const Text('From Group',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        FutureBuilder<DocumentSnapshot>(
                          future: groups.doc(event['groupId']).get(),
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              Map<String, dynamic> data =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              return Container(
                                  height: 100,
                                  child: Flex(
                                      direction: Axis.horizontal,
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Row(children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                    data["groupBg"],
                                                    height: double.infinity,
                                                    width:
                                                        (size.width - 30) / 3 -
                                                            35,
                                                    fit: BoxFit.cover),
                                              ),
                                            ])),
                                        Expanded(
                                            flex: 3,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(data["groupName"],
                                                      style: const TextStyle(
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Color.fromRGBO(
                                                              53, 52, 77, 1.0)),
                                                      maxLines: 2,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                  Text(
                                                    data["groupDesc"],
                                                    style: const TextStyle(
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    data["groupLocation"],
                                                    style: const TextStyle(
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Color.fromRGBO(
                                                            108,
                                                            111,
                                                            132,
                                                            1.0)),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ]));
                            }

                            return Text("loading");
                          },
                        ),
                        /*Container(
                            height: 100,
                            child: Flex(direction: Axis.horizontal, children: [
                              Expanded(
                                  flex: 1,
                                  child: Row(children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                          "https://seniorassistant.oss-cn-hangzhou.aliyuncs.com/zust-lcy-path/20230406/2023040622447.jpg",
                                          height: double.infinity,
                                          width: 100,
                                          fit: BoxFit.cover),
                                    ),
                                  ])),
                              const Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "Medway & Maidstone under 40's Social",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromRGBO(
                                                    53, 52, 77, 1.0))),
                                        Text(
                                            'A friendly group from local people living in Thamesmead',
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w400)),
                                        Text(
                                          'Rochester, G5',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w400,
                                              color: Color.fromRGBO(
                                                  108, 111, 132, 1.0)),
                                        ),
                                      ],
                                    ),
                                  )),
                            ])),*/
                        const SizedBox(height: 25),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('About',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10),
                            Text(event['eventDesc'],
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400)),
                            const SizedBox(height: 25),
                            Row(
                              children: [
                                const Text('Date: ',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                    '${event['eventDate']} ${event['eventTime']}',
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ],
                        ),
                        const Divider(),
                        const SizedBox(height: 10),
                        Flex(
                            direction: Axis.horizontal,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Hosting(1)',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ]),
                                      SizedBox(height: 10),
                                      Wrap(
                                        spacing: -10,
                                        runSpacing: 10,
                                        // direction: Axis.vertical,
                                        // alignment:WrapAlignment.start,
                                        // runAlignment: WrapAlignment.center,
                                        children: <Widget>[
                                          CircleAvatar(
                                            radius: 17,
                                            backgroundColor: Colors.white,
                                            child: CircleAvatar(
                                              radius: 15,
                                              backgroundImage: NetworkImage(
                                                  "https://seniorassistant.oss-cn-hangzhou.aliyuncs.com/omg-img-path/avatar1.jpg"),
                                            ),
                                          ),
                                          CircleAvatar(
                                            radius: 17,
                                            backgroundColor: Colors.white,
                                            child: CircleAvatar(
                                              radius: 15,
                                              backgroundImage: NetworkImage(
                                                  "https://seniorassistant.oss-cn-hangzhou.aliyuncs.com/omg-img-path/avatar2.jpeg"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('Going(27)',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ]),
                                          const SizedBox(height: 10),
                                          Wrap(
                                            spacing: -10,
                                            runSpacing: 10,
                                            // direction: Axis.vertical,
                                            alignment: WrapAlignment.start,
                                            runAlignment: WrapAlignment.start,
                                            children: <Widget>[
                                              const CircleAvatar(
                                                radius: 17,
                                                backgroundColor: Colors.white,
                                                child: CircleAvatar(
                                                  radius: 15,
                                                  backgroundImage: NetworkImage(
                                                      "https://seniorassistant.oss-cn-hangzhou.aliyuncs.com/omg-img-path/avatar3.jpeg"),
                                                ),
                                              ),
                                              const CircleAvatar(
                                                radius: 17,
                                                backgroundColor: Colors.white,
                                                child: CircleAvatar(
                                                  radius: 15,
                                                  backgroundImage: NetworkImage(
                                                      "https://seniorassistant.oss-cn-hangzhou.aliyuncs.com/omg-img-path/avatar4.jpg"),
                                                ),
                                              ),
                                              const CircleAvatar(
                                                radius: 17,
                                                backgroundColor: Colors.white,
                                                child: CircleAvatar(
                                                  radius: 15,
                                                  backgroundImage: NetworkImage(
                                                      "https://seniorassistant.oss-cn-hangzhou.aliyuncs.com/omg-img-path/avatar5.jpeg"),
                                                ),
                                              ),
                                              const CircleAvatar(
                                                radius: 17,
                                                backgroundColor: Colors.white,
                                                child: CircleAvatar(
                                                  radius: 15,
                                                  backgroundImage: NetworkImage(
                                                      "https://seniorassistant.oss-cn-hangzhou.aliyuncs.com/omg-img-path/avatar6.jpg"),
                                                ),
                                              ),
                                              const CircleAvatar(
                                                radius: 17,
                                                backgroundColor: Colors.white,
                                                child: CircleAvatar(
                                                  radius: 15,
                                                  backgroundImage: NetworkImage(
                                                      "https://seniorassistant.oss-cn-hangzhou.aliyuncs.com/omg-img-path/avatar7.jpg"),
                                                ),
                                              ),
                                              Container(
                                                height: 34,
                                                width: 34,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          const Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                      width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: const Color.fromRGBO(
                                                      196, 192, 192, 1.0),
                                                ),
                                                child: const Text(
                                                  "+22",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 13),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ))),
                            ]),
                        const SizedBox(height: 25),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text('Location',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10),
                            Text(event['eventLocation'],
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500)),
                            /*const Text('Western Gateway',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400)),*/
                            const SizedBox(height: 10),
                            Container(
                              height: 200,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: SizedBox(
                                  height: 100,
                                  width: size.width,
                                  child: GoogleMap(
                                    onMapCreated: _onMapCreated,
                                    initialCameraPosition: CameraPosition(
                                      target: _currentPosition,
                                      zoom: 16.0,
                                    ),
                                    markers: _markers,
                                  ),
                                ),
                              ),
                            ),
                            /* SizedBox(
                              height: 200,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                    "https://seniorassistant.oss-cn-hangzhou.aliyuncs.com/oss-img-path/location.jpeg",
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover),
                              ),
                            ),*/
                            const Divider(),
                            const SizedBox(height: 10),
                            const Text('Discussion',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10),
                            Consumer<ApplicationState>(
                              builder: (context, appState, _) {
                                var messages =
                                    appState.guestBookMessages.where((element) {
                                  return element.eventId == widget.eventId;
                                }).toList();
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (appState.loggedIn) ...[
                                      for (var message in messages)
                                        Row(
                                          children: [
                                            Text('${message.name}: ',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            Text(message.message,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w400))
                                          ],
                                        )
                                    ] else if (!appState.loggedIn) ...[
                                      const Text(
                                          'Please Log in to see discussion',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400)),
                                    ]
                                  ],
                                );
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
                child: Container(
                    width: size.width,
                    height: 85,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(240, 240, 241, 1.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: SafeArea(
                          child: Form(
                        key: _formKey,
                        child: Consumer<ApplicationState>(
                          builder: (context, appState, _) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(3),
                                width: size.width * 0.65,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30.0)),
                                constraints: const BoxConstraints(
                                    minHeight: 30.0, maxHeight: 150.0),
                                child: TextField(
                                    controller: _controller,
                                    maxLines: null,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                        hintStyle: TextStyle(fontSize: 14.0),
                                        isDense: true,
                                        contentPadding: EdgeInsets.all(5.0),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide
                                                .none))) /*TextFormField(
                                  controller: _controller,
                                  maxLines: null,
                                  keyboardType: TextInputType.multiline,
                                  decoration: const InputDecoration(
                                    hintStyle: TextStyle(fontSize: 14.0),
                                    isDense: true,
                                    contentPadding: EdgeInsets.all(5.0),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.deepPurple),
                                    ),
                                  ),
                                )*/
                                ,
                              ),
                              IconButton(
                                icon: const Icon(
                                    Icons.send,
                                    size: 24),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate() &&
                                      _controller.text.isNotEmpty) {
                                    await appState.addMessageToGuestBook(
                                        _controller.text, widget.eventId);
                                    _controller.clear();
                                  } else if (_controller.text.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg: "Enter your message to continue",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                },
                                // child: Text('Send'),
                                /*  style: OutlinedButton.styleFrom(
                                    minimumSize: Size(size.width * 0.2, 35),
                                    side: const BorderSide(
                                        color:
                                            Color.fromRGBO(171, 168, 174, 1)),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    )),*/
                              ),
                              IconButton(
                                icon: const Icon(
                                    Icons.add_circle_outline,
                                    size: 24,
                                    color: Color.fromRGBO(26, 26, 27, 1.0)),
                                onPressed: () async {
                                  await appState.signUpEvent(
                                      event['eventDate'],
                                      event['eventDesc'],
                                      event['eventName'],
                                      event['eventBg'],
                                      event['eventTime']);
                                  Fluttertoast.showToast(
                                      msg: "Signed Up Successfully",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                },
                                // child: Text('RSVP'),
                                /*  style: OutlinedButton.styleFrom(
                                    minimumSize: Size(size.width * 0.2, 35),
                                    side: const BorderSide(color: Color.fromRGBO(171, 168, 174, 1)),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    )),*/
                              )
                            ],
                          ),
                        ),
                      )),
                    )))
          ],
        );
      },
    );
  }
}
