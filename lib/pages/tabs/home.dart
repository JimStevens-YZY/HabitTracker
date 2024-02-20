import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        ),
        body: const HomeMain());
  }
}

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.all(15), children: <Widget>[
      const Text("Explore EventGather",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
      const SizedBox(
        width: double.infinity,
        height: 20,
      ),
      const Text("Popular now",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
      const SizedBox(
        width: double.infinity,
        height: 20,
      ),
      SizedBox(
        height: 300,
        child: ListView(scrollDirection: Axis.horizontal, children: <Widget>[
          GestureDetector(
              onTap: () {
                // 点击事件代码
                Navigator.pushNamed(context, '/eventDetails');
              },
              child: Container(
                width: 240.0,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.2), //边框颜色
                      width: 1, //边框宽度
                    ), // 边色与边宽度
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10, //阴影范围
                        spreadRadius: 0.1, //阴影浓度
                        color: Colors.grey.withOpacity(0.2), //阴影颜色
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      child: Image.network(
                          "https://www.itying.com/images/flutter/1.png",
                          height: 145,
                          width: double.infinity,
                          fit: BoxFit.cover),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(bottom: 3.0, top: 5.0),
                              child: Text(
                                'TUE, FEB 6 ~ 17:00',
                                style: TextStyle(
                                    color: Color.fromRGBO(131, 112, 83, 1),
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.start,
                              )),
                          Padding(
                            padding: EdgeInsets.only(bottom: 3.0),
                            child: Text(
                              'We need to talk about We need to talk aboutWe need to talk about asdasdsa',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              //textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 15.0),
                            child: Text(
                              'Conscious Al',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 13),
                              //textAlign: TextAlign.center,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text('Online event',
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              118, 118, 119, 1.0),
                                          fontSize: 13))
                                ],
                              ),
                              Icon(Icons.bookmark_border,
                                  color: Color.fromRGBO(160, 160, 160, 1.0))
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )),
          const SizedBox(
            width: 20,
            height: 200,
          ),
          Container(
            width: 240.0,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.withOpacity(0.2), //边框颜色
                  width: 1, //边框宽度
                ), // 边色与边宽度
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10, //阴影范围
                    spreadRadius: 0.1, //阴影浓度
                    color: Colors.grey.withOpacity(0.2), //阴影颜色
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
                color: Colors.white),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: Image.network(
                      "https://www.itying.com/images/flutter/1.png",
                      height: 145,
                      width: double.infinity,
                      fit: BoxFit.cover),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(bottom: 3.0, top: 5.0),
                          child: Text(
                            'TUE, FEB 6 ~ 17:00',
                            style: TextStyle(
                                color: Color.fromRGBO(131, 112, 83, 1),
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.start,
                          )),
                      Padding(
                        padding: EdgeInsets.only(bottom: 3.0),
                        child: Text(
                          'We need to talk about We need to talk aboutWe need to talk about asdasdsa',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          //textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 15.0),
                        child: Text(
                          'Conscious Al',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 13),
                          //textAlign: TextAlign.center,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text('Online event',
                                  style: TextStyle(
                                      color: Color.fromRGBO(118, 118, 119, 1.0),
                                      fontSize: 13))
                            ],
                          ),
                          Icon(Icons.bookmark_border,
                              color: Color.fromRGBO(160, 160, 160, 1.0))
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 20,
            height: 200,
          ),
          Container(
            width: 180.0,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.withOpacity(0.2), //边框颜色
                  width: 1, //边框宽度
                ), // 边色与边宽度
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10, //阴影范围
                    spreadRadius: 0.1, //阴影浓度
                    color: Colors.grey.withOpacity(0.2), //阴影颜色
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
                color: Colors.white),
            child: Column(
              children: <Widget>[
                Image.network("https://www.itying.com/images/flutter/1.png"),
                const Text('我是一个文本')
              ],
            ),
          ),
        ]),
      ),
      const SizedBox(
        width: double.infinity,
        height: 20,
      ),
      const Text("Career & Business",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
    ]);
  }
}
