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
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
        const SizedBox(
          width: double.infinity,
          height: 20,
        ),
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                  "https://seniorassistant.oss-cn-hangzhou.aliyuncs.com/zust-lcy-path/20230406/2023040622447.jpg",
                  height: 70,
                  width: 100,
                  fit: BoxFit.cover),
            ),
            const SizedBox(
              width: 15
            ),
            Text('New Groups',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500))
          ],
        ),
        const SizedBox(
            height: 15
        ),
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                  "https://seniorassistant.oss-cn-hangzhou.aliyuncs.com/zust-lcy-path/20230406/2023040622447.jpg",
                  height: 70,
                  width: 100,
                  fit: BoxFit.cover),
            ),
            const SizedBox(
                width: 15
            ),
            Text('Art & Culture',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),

          ],
        ),
        const SizedBox(
            height: 15
        ),
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                  "https://seniorassistant.oss-cn-hangzhou.aliyuncs.com/zust-lcy-path/20230406/2023040622447.jpg",
                  height: 70,
                  width: 100,
                  fit: BoxFit.cover),
            ),
            const SizedBox(
                width: 15
            ),
            Text('Career & Business',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),

          ],
        ),
        const SizedBox(
            height: 15
        ),
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                  "https://seniorassistant.oss-cn-hangzhou.aliyuncs.com/zust-lcy-path/20230406/2023040622447.jpg",
                  height: 70,
                  width: 100,
                  fit: BoxFit.cover),
            ),
            const SizedBox(
                width: 15
            ),
            Text('Community & Environment',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),

          ],
        ),
        const SizedBox(
            height: 15
        ),
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                  "https://seniorassistant.oss-cn-hangzhou.aliyuncs.com/zust-lcy-path/20230406/2023040622447.jpg",
                  height: 70,
                  width: 100,
                  fit: BoxFit.cover),
            ),
            const SizedBox(
                width: 15
            ),
            Text('Dancing',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),

          ],
        ),
        const SizedBox(
            height: 15
        ),
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                  "https://seniorassistant.oss-cn-hangzhou.aliyuncs.com/zust-lcy-path/20230406/2023040622447.jpg",
                  height: 70,
                  width: 100,
                  fit: BoxFit.cover),
            ),
            const SizedBox(
                width: 15
            ),
            Text('Games',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),

          ],
        ),
        const SizedBox(
            height: 15
        ),
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                  "https://seniorassistant.oss-cn-hangzhou.aliyuncs.com/zust-lcy-path/20230406/2023040622447.jpg",
                  height: 70,
                  width: 100,
                  fit: BoxFit.cover),
            ),
            const SizedBox(
                width: 15
            ),
            Text('Health & Wellbeing',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),

          ],
        ),
        const SizedBox(
            height: 15
        ),
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                  "https://seniorassistant.oss-cn-hangzhou.aliyuncs.com/zust-lcy-path/20230406/2023040622447.jpg",
                  height: 70,
                  width: 100,
                  fit: BoxFit.cover),
            ),
            const SizedBox(
                width: 15
            ),
            Text('Hobbies & Passions',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),

          ],
        )

      ],
    );
  }
}
