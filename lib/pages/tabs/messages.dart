import 'package:flutter/material.dart';
import '../../res/listData.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            title: const Text('Messages',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
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
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(
                        "https://www.itying.com/images/flutter/3.png"),
                  ),
                  GestureDetector(
                      onTap: () {
                        // 点击事件代码
                        Navigator.pushNamed(context, '/chatPage');
                      },
                      child:  Container(
                        padding: const EdgeInsets.only(left: 10),
                        width: 350,
                        height: 48,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('momo',
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromRGBO(51, 51, 52, 1.0))),
                                Text('02:34',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(147, 148, 149, 1.0)))
                              ],
                            ),
                            Row(
                              children: [
                                Text('aaaaaaaaaaaaaaa',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(147, 148, 149, 1.0)))
                              ],
                            )
                          ],
                        ),
                      )
                  ),

                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
