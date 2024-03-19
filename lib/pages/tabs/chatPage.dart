import 'package:flutter/material.dart';
import '../../res/listData.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(235, 235, 236, 1.0),
        appBar: AppBar(
            backgroundColor: Color.fromRGBO(235, 235, 236, 1.0),
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
        Expanded(
            child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                        "https://www.itying.com/images/flutter/3.png",
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover),
                  ),
                 Container(
                   decoration: const BoxDecoration(
                       color: Color.fromRGBO(255, 255, 255, 1.0),
                       borderRadius: BorderRadius.all(Radius.circular(8.0))),
                   margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                   padding: const EdgeInsets.only(
                       top: 8, bottom: 8, left: 10, right: 10),
                   child: ConstrainedBox(
                     constraints: const BoxConstraints(
                       maxWidth: 200.0,
                     ),
                     child: const Text('aaaaaaaaaaaaaaaaa',
                         softWrap: true,
                         style: TextStyle(
                             fontSize: 16.0,
                             fontWeight: FontWeight.w400,
                             color: Color.fromRGBO(0, 0, 0, 1.0))),
                   ),
                 )
                 /* Container(
                      //alignment: Alignment.centerLeft,
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(61, 133, 233, 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 8, left: 10, right: 10),
                      margin: const EdgeInsets.fromLTRB(50.0, 10.0, 10.0, 10.0),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 200.0,
                        ),
                        child: const Text('aaaaaaaaaaaaaaaaa',
                            softWrap: true,
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(255, 255, 255, 1.0))),
                      )),*/
                  //const Expanded(child: SizedBox()),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Expanded(child: SizedBox()),
                  Container(
                      alignment: Alignment.centerRight,
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(61, 133, 233, 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 8, left: 10, right: 10),
                      margin: const EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 10.0),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 200.0,
                        ),
                        child: const Text('aaaaaaaaaaaaaaaaa',
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
                  color: Color.fromRGBO(240, 240, 241, 1.0),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          width: size.width * 0.7,
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
