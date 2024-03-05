import 'package:flutter/material.dart';

class DiscoverGroupPage extends StatelessWidget {
  const DiscoverGroupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text('Groups',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))),
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
      ],
    );
  }
}
