import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'app_state.dart';

class DiscoverGroupPage extends StatelessWidget {
  const DiscoverGroupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
            title: const Text('Groups',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))),
        backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
        body: const DiscoverGroupMain());
  }
}

class DiscoverGroupMain extends StatefulWidget {
  const DiscoverGroupMain({super.key});

  @override
  State<DiscoverGroupMain> createState() => _DiscoverGroupMainState();
}

class _DiscoverGroupMainState extends State<DiscoverGroupMain>
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

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        TextField(
          autofocus: true,
          decoration: InputDecoration(
              hintText: "Explore more groups",
              prefixIcon: Icon(Icons.search_rounded),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffB6B6B6), width: 0.5),
                  borderRadius: BorderRadius.circular(20.0)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffB6B6B6), width: 1),
                  borderRadius: BorderRadius.circular(20.0)),
              contentPadding: const EdgeInsets.all(0.0)),
        ),
        const SizedBox(
          width: double.infinity,
          height: 15,
        ),
        const Text("Browse by category",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 20,
        ),
        SizedBox(
            width: double.infinity,
            child: Consumer<ApplicationState>(
              builder: (context, appState, _) => Wrap(
                alignment: WrapAlignment.spaceBetween,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (appState.categories.isNotEmpty) ...[
                    for (var category in appState.categories)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(category.categoryBg,
                                    height: 80, width: 120, fit: BoxFit.cover),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10),
                                child: Text(category.categoryName,
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromRGBO(
                                            53, 52, 77, 1.0))),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          )
                          /*             ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                                category.categoryBg,
                                height: 140,
                                width: 195,
                                fit: BoxFit.cover),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 5, top: 5, bottom: 20),
                            child: Text(category.categoryName,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(
                                        53, 52, 77, 1.0))),
                          ),*/
                        ],
                      ),
                  ],
                ],
              ),
            ))
      ],
    );
  }
}
