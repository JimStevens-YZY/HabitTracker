import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../res/listData.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
            title: const Text('Messages',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
        backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
        body: const MessagesMain());
  }
}

class MessagesMain extends StatefulWidget {
  const MessagesMain({super.key});

  @override
  State<MessagesMain> createState() => _MessagesMainState();
}

class _MessagesMainState extends State<MessagesMain>
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
    final size = MediaQuery.of(context).size;
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              for (int i = 0; i < userAvatar.length; i++)
                Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundImage:
                              NetworkImage(userAvatar[i]["avatar"]),
                        ),
                        GestureDetector(
                            onTap: () {
                              // 点击事件代码
                              GoRouter.of(context).push('/chatPage/${i}');
                            },
                            child: Container(
                              padding: const EdgeInsets.only(left: 10),
                              width: 350,
                              height: 48,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(userAvatar[i]["name"],
                                          style: TextStyle(
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromRGBO(
                                                  51, 51, 52, 1.0))),
                                      Text(userAvatar[i]["time"],
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w400,
                                              color: Color.fromRGBO(
                                                  147, 148, 149, 1.0)))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                          width: size.width * 0.7,
                                          child:  Text(
                                            userAvatar[i]["message"],
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w400,
                                                color: Color.fromRGBO(
                                                    147, 148, 149, 1.0)),
                                            overflow: TextOverflow.ellipsis,
                                          )
                                      )

                                    ],
                                  )
                                ],
                              ),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    )
                  ],
                )
            ],
          ),
        ),
      ],
    );
  }
}
