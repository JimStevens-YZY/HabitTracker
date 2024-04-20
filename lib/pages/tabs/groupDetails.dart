import 'package:flutter/material.dart';
import '../../res/listData.dart';
import 'package:firebase_auth/firebase_auth.dart' // new
    hide
    EmailAuthProvider,
    PhoneAuthProvider;
import 'package:cloud_firestore/cloud_firestore.dart';

class GroupDetailsPage extends StatelessWidget {
  final String groupId;
  const GroupDetailsPage({super.key, required this.groupId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text('Group',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))),
        body: GroupDetailsMain(groupId: this.groupId));
  }
}

class GroupDetailsMain extends StatefulWidget {
  final String groupId;
  const GroupDetailsMain({super.key, required this.groupId});

  @override
  State<GroupDetailsMain> createState() => _GroupDetailsMainState();
}

class _GroupDetailsMainState extends State<GroupDetailsMain>
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
    final _future = FirebaseFirestore.instance
        .collection("groups")
        .doc(widget.groupId)
        .get();
    print(widget.groupId);
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final group = snapshot.data!;
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
                          group["groupBg"],
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Text(group["groupName"],
                        style:
                        const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 10),
                  Row(children: [
                    Wrap(
                      spacing: 2,
                      runSpacing: 10,
                      children: <Widget>[
                        for (int i = 0; i < group["groupOrganizers"].length; i++)
                          const CircleAvatar(
                          radius: 17,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundImage: NetworkImage(
                                "https://www.itying.com/images/flutter/3.png"),
                          ),
                        ),
                  /*      CircleAvatar(
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
                        ),*/
                      ],
                    ),
                  ]),
                  const SizedBox(height: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${group["groupOrganizers"].length} Members',
                          style:
                          const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      Text('${group["groupLocation"]} · Public group',
                          style:
                          const TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Color.fromRGBO(108, 111, 132, 1.0))),
                      const SizedBox(height: 10),
                      Text(
                          group["groupDesc"],
                          style:
                          const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('Organizer',
                          style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      for (var organizer in group["groupOrganizers"])
                        Text(organizer,
                          style:
                          const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                      const SizedBox(height: 10),
                      const Divider(),
                      const SizedBox(height: 10),
                      const Text('Events',
                          style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                    ],
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
/*    return ListView(
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
                child: Text('Fun Activities to Do in London on a Weekend',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 10),
              const Row(children: [
                Wrap(
                  spacing: 2,
                  runSpacing: 10,
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
              ]),
              const SizedBox(height: 10),
              const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('7,905 Members',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  Text('London, United Kindom · Public group',
                      style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Color.fromRGBO(108, 111, 132, 1.0))),
                  const SizedBox(height: 10),
                  Text(
                      'Join us for an exclusive online event as we delve into the world of creating high-converting funnels for your business, powered by cutting-edge AI technology.',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Organizer',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text('Tapa Tapa',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                  Text('Western Gateway',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                  SizedBox(height: 10),
                  Divider(),
                  SizedBox(height: 10),
                  Text('Events',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                ],
              )
            ],
          ),
        ),
      ],
    );*/
  }
}
