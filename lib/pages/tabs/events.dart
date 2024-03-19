import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
            title: const Text('Events',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
        backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
        body: const EventsMain());
  }
}

class EventsMain extends StatefulWidget {
  const EventsMain({super.key});

  @override
  State<EventsMain> createState() => _EventsMainState();
}

class _EventsMainState extends State<EventsMain> with TickerProviderStateMixin {
  late TabController tabController;

  final _future = Supabase.instance.client.from('signed_events').select();

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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabBar(
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          labelColor: const Color.fromRGBO(52, 87, 219, 1.0),
          indicatorColor: const Color.fromRGBO(49, 77, 194, 1.0),
          labelStyle:
              const TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          unselectedLabelStyle:
              const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
          controller: tabController,
          tabs: const [
            Tab(child: Text("Upcoming")),
            Tab(child: Text("Past events"))
          ],
        ),
        Container(
          height: 400,
          child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _future,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final events = snapshot.data!;
                return ListView.builder(
                  padding: const EdgeInsets.all(15),
                  itemCount: events.length,
                  itemBuilder: ((context, index) {
                    final event = events[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("January",
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold)),
                        const SizedBox(
                          width: double.infinity,
                          height: 10,
                        ),
                        Container(
                            height: 120,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.2), //边框颜色
                                  width: 1, //边框宽度
                                ), // 边色与边宽度
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 10, //阴影范围
                                    spreadRadius: 0.1, //阴影浓度
                                    color: Colors.grey.withOpacity(0.2), //阴影颜色
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: Flex(direction: Axis.horizontal, children: [
                              Expanded(
                                  flex: 2,
                                  child: Padding(
                                      padding: const EdgeInsets.all(25),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              event['signed_event_name'] +
                                                  '-' +
                                                  event['signed_event_desc'],
                                              style: const TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w500)),
                                          const SizedBox(height: 6),
                                          Text(
                                              event['signed_event_date'] +
                                                  ' at ' +
                                                  event['signed_event_time'],
                                              style: const TextStyle(
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w400))
                                        ],
                                      ))),
                              Expanded(
                                  flex: 1,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    child: Image.network(
                                        "https://seniorassistant.oss-cn-hangzhou.aliyuncs.com/zust-lcy-path/20230406/2023040622447.jpg",
                                        height: double.infinity,
                                        fit: BoxFit.cover),
                                  ))
                            ]))
                      ],
                    );
                  }),
                );
              }),
          /*ListView(
            padding: const EdgeInsets.all(15),
            children: [
              const Text("January",
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              const SizedBox(
                width: double.infinity,
                height: 10,
              ),

              Container(
                  height: 120,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.2), //边框颜色
                        width: 1, //边框宽度
                      ), // 边色与边宽度
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10, //阴影范围
                          spreadRadius: 0.1, //阴影浓度
                          color: Colors.grey.withOpacity(0.2), //阴影颜色
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Flex(direction: Axis.horizontal, children: [
                    const Expanded(
                        flex: 2,
                        child: Padding(
                            padding: EdgeInsets.all(25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Swiftogeddon - The Taylor Swift Club Night',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500)),
                                Text('Friday, March 1 at 21:00',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400))
                              ],
                            ))),
                    Expanded(
                        flex: 1,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          child: Image.network(
                              "https://seniorassistant.oss-cn-hangzhou.aliyuncs.com/zust-lcy-path/20230406/2023040622447.jpg",
                              height: double.infinity,
                              fit: BoxFit.cover),
                        ))
                  ]))
            ],
          ),*/
        )
      ],
    );
  }
}
