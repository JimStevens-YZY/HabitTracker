import 'package:flutter/material.dart';
import '../../res/listData.dart';

class EventDetailsPage extends StatelessWidget {
  const EventDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text('Event',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))),
        body: const EventDetailsMain());
  }
}

class EventDetailsMain extends StatefulWidget {
  const EventDetailsMain({super.key});

  @override
  State<EventDetailsMain> createState() => _EventDetailsMainState();
}

class _EventDetailsMainState extends State<EventDetailsMain>
    with TickerProviderStateMixin {
  late TabController tabController;

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
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                      "https://seniorassistant.oss-cn-hangzhou.aliyuncs.com/zust-lcy-path/20230406/2023040622447.jpg",
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: Text(
                    'Free Online Meetup: Master the Art of Creating High-Converting Funnels with AI',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 25),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 3),
                          child: Icon(Icons.calendar_today_outlined,
                              size: 20,
                              color: Color.fromRGBO(99, 100, 112, 1.0))),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Friday, February 23, 2024',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600)),
                          Text('18:30 - 19:30 GMT',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w400))
                        ],
                      )
                    ],
                  ),
                  Icon(Icons.chevron_right_rounded,
                      size: 30, color: Color.fromRGBO(99, 100, 112, 1.0)),
                ],
              ),
              Divider(),
              const Row(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 3),
                          child: Icon(Icons.camera,
                              size: 20,
                              color: Color.fromRGBO(99, 100, 112, 1.0))),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Online event',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600)),
                          Text('Link visible for attendees',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w400))
                        ],
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 25),
              Container(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Medway & Maidstone under 40's Social",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(53, 52, 77, 1.0))),
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
                                    color: Color.fromRGBO(108, 111, 132, 1.0)),
                              ),
                            ],
                          ),
                        )),
                  ])),
              const SizedBox(height: 25),
              const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('About',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(
                      'Join us for an exclusive online event as we delve into the world of creating high-converting funnels for your business, powered by cutting-edge AI technology.',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                  const SizedBox(height: 25),
                  Row(
                    children: [
                      Text('Date: ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('23rd February 2025',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400)),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Hosting(1)',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold))
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
                                        "https://www.itying.com/images/flutter/3.png"),
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 17,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundImage: NetworkImage(
                                        "https://www.itying.com/images/flutter/3.png"),
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Going(27)',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold))
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
                                            "https://www.itying.com/images/flutter/3.png"),
                                      ),
                                    ),
                                    const CircleAvatar(
                                      radius: 17,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 15,
                                        backgroundImage: NetworkImage(
                                            "https://www.itying.com/images/flutter/3.png"),
                                      ),
                                    ),
                                    const CircleAvatar(
                                      radius: 17,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 15,
                                        backgroundImage: NetworkImage(
                                            "https://www.itying.com/images/flutter/3.png"),
                                      ),
                                    ),
                                    const CircleAvatar(
                                      radius: 17,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 15,
                                        backgroundImage: NetworkImage(
                                            "https://www.itying.com/images/flutter/3.png"),
                                      ),
                                    ),
                                    const CircleAvatar(
                                      radius: 17,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 15,
                                        backgroundImage: NetworkImage(
                                            "https://www.itying.com/images/flutter/3.png"),
                                      ),
                                    ),
                                    Container(
                                      height: 34,
                                      width: 34,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color.fromRGBO(
                                                255, 255, 255, 1),
                                            width: 2),
                                        borderRadius: BorderRadius.circular(50),
                                        color:
                                            Color.fromRGBO(196, 192, 192, 1.0),
                                      ),
                                      child: const Text(
                                        "+4",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const Text('Tapa Tapa',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                  const Text('Western Gateway',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                          "https://seniorassistant.oss-cn-hangzhou.aliyuncs.com/zust-lcy-path/20230406/2023040622447.jpg",
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover),
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 10),
                  const Text('Photos',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
