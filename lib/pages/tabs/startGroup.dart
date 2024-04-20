import 'package:flutter/material.dart';

class StartGroupPage extends StatelessWidget {
  const StartGroupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text('Start a group',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))),
        backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
        body: const StartGroupMain());
  }
}

class StartGroupMain extends StatefulWidget {
  const StartGroupMain({super.key});

  @override
  State<StartGroupMain> createState() => _StartGroupMainState();
}

class _StartGroupMainState extends State<StartGroupMain>
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
        const Text("Set your location for your group",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        TextField(
          autofocus: true,
          decoration: InputDecoration(
              hintText: "Search for locations",
              prefixIcon: Icon(Icons.explore)),
        ),
        const SizedBox(
          width: double.infinity,
          height: 30,
        ),
        const Text("Choose topics for your group",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        TextField(
          autofocus: true,
          decoration: InputDecoration(
              hintText: "Search for topics", prefixIcon: Icon(Icons.topic)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Wrap(
            spacing: 8,
            runSpacing: 10,
            // direction: Axis.vertical,
            // alignment:WrapAlignment.start,
            // runAlignment: WrapAlignment.center,
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border:
                          Border.all(color: Color.fromRGBO(12, 117, 135, 1.0))),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                    child: Text('Critique Group',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Color.fromRGBO(12, 117, 135, 1.0),
                          fontWeight: FontWeight.w500,
                        )),
                  )),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border:
                          Border.all(color: Color.fromRGBO(12, 117, 135, 1.0))),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                    child: Text('Dog training',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Color.fromRGBO(12, 117, 135, 1.0),
                          fontWeight: FontWeight.w500,
                        )),
                  )),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border:
                          Border.all(color: Color.fromRGBO(12, 117, 135, 1.0))),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                    child: Text('Wine and Food Pairing',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Color.fromRGBO(12, 117, 135, 1.0),
                          fontWeight: FontWeight.w500,
                        )),
                  )),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border:
                          Border.all(color: Color.fromRGBO(12, 117, 135, 1.0))),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                    child: Text('Activism',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Color.fromRGBO(12, 117, 135, 1.0),
                          fontWeight: FontWeight.w500,
                        )),
                  )),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border:
                          Border.all(color: Color.fromRGBO(12, 117, 135, 1.0))),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                    child: Text('Acoustic Guitar',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Color.fromRGBO(12, 117, 135, 1.0),
                          fontWeight: FontWeight.w500,
                        )),
                  )),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border:
                          Border.all(color: Color.fromRGBO(12, 117, 135, 1.0))),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                    child: Text('Outdoor Adventures',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Color.fromRGBO(12, 117, 135, 1.0),
                          fontWeight: FontWeight.w500,
                        )),
                  )),
            ],
          ),
        ),
        const SizedBox(
          width: double.infinity,
          height: 30,
        ),
        const Text("Name your group",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        const SizedBox(
          width: double.infinity,
          height: 15,
        ),
        const Text(
            "Choose a name that will give people a clear idea of what the group is about.",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400)),
        TextField(
          autofocus: true,
          decoration: InputDecoration(
              hintText: "Choose a name", prefixIcon: Icon(Icons.badge)),
        ),
        const SizedBox(
          width: double.infinity,
          height: 30,
        ),
        const Text("Describe your group",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        const SizedBox(
          width: double.infinity,
          height: 15,
        ),
        const Text(
            "We care about human connection, so someone will review your group to make it meets our community guidelines.",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400)),
        TextField(
          autofocus: true,
          decoration: InputDecoration(
              hintText: "Please write at least 50 characters",
              prefixIcon: Icon(Icons.info)),
        ),
        const SizedBox(
          width: double.infinity,
          height: 40,
        ),
        ElevatedButton(
          child: Text("Create"),
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(
                Color.fromRGBO(12, 117, 135, 1.0)),
            foregroundColor: MaterialStateProperty.resolveWith((states) {
              return states.contains(MaterialState.pressed)
                  ? Color.fromRGBO(12, 117, 135, 1.0)
                  : Colors.white;
            }),
          ),
          onPressed: () {},
        )
      ],
    );
  }
}
