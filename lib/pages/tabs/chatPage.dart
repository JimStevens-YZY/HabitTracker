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
    return Column(
      children: [
        /*      Positioned(
          top: 0,
          left: 0,
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                            "https://www.itying.com/images/flutter/3.png",
                            height: 48,
                            width: 48,
                            fit: BoxFit.cover),
                      ),
                      Container(
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
                                        color:
                                            Color.fromRGBO(51, 51, 52, 1.0))),
                              ],
                            ),
                            Row(
                              children: [
                                Text('aaaaaaaaaaaaaaa',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            Color.fromRGBO(147, 148, 149, 1.0)))
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        width: 200,
                        height: 48,
                        child: const Column(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('momo',
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            Color.fromRGBO(51, 51, 52, 1.0))),
                              ],
                            ),
                            Row(
                              children: [
                                Text('aaaaaaaaaaaaaaa',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            Color.fromRGBO(147, 148, 149, 1.0)))
                              ],
                            )
                          ],
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                            "https://www.itying.com/images/flutter/3.png",
                            height: 48,
                            width: 48,
                            fit: BoxFit.cover),
                      ),
                    ],
                  ),
                ],
              )),
        ),*/
        Expanded(
            child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                        "https://www.itying.com/images/flutter/3.png",
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    width: 180,
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
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(child: SizedBox()),
                  Container(
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(43, 77, 182, 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      padding: EdgeInsets.all(5.0),
                      margin: EdgeInsets.fromLTRB(50.0, 10.0, 10.0, 10.0),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 200.0,
                        ),
                        child: Text('aaaaaaaaaaaaaaaaa',
                            softWrap: true,
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(255, 255, 255, 1.0))),
                      )),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                        "https://www.itying.com/images/flutter/3.png",
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover),
                  ),
                ],
              )
            ],
          ),
        )),
        Container(
            child: Container(
                width: size.width,
                height: 85,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(237, 237, 236, 1.0),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          width: 300,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(3.0)),
                          constraints: const BoxConstraints(
                              minHeight: 30.0, maxHeight: 150.0),
                          child: const TextField(
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                  hintStyle: TextStyle(fontSize: 14.0),
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(5.0),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none))),
                        ),
                        Icon(Icons.sentiment_very_satisfied,
                            size: 30, color: Color.fromRGBO(26, 26, 27, 1.0)),
                        Icon(Icons.add_circle_outline,
                            size: 30, color: Color.fromRGBO(26, 26, 27, 1.0))
                      ],
                    ),
                  ),
                )))
      ],
    );
  }
}
