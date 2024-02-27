import 'package:flutter/material.dart';
import '../../res/listData.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text('momo',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))),
        body: const ChatPageMain());
  }
}

class ChatPageMain extends StatefulWidget {
  const ChatPageMain({super.key});

  @override
  State<ChatPageMain> createState() => _ChatPageMainState();
}

class _ChatPageMainState extends State<ChatPageMain>
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
    return Stack(
      children: [
        Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: size.width,
              height: 85,
              decoration: BoxDecoration(
                color: Color.fromRGBO(237, 237, 236, 1.0),
              ),
              child: Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(bottom: 30, left: 20),
                      child: Container(
                        width: 280,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(3.0)),
                        constraints:
                            BoxConstraints(minHeight: 30.0, maxHeight: 150.0),
                        child: TextField(
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                hintStyle: TextStyle(fontSize: 14.0),
                                isDense: true,
                                contentPadding: EdgeInsets.all(5.0),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none))),
                      ))
                ],
              ),
            ))
      ],
    );
  }
}
