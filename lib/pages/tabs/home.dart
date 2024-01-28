import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
     final size = MediaQuery.of(context).size;
  
    return Stack(
      children:[
    Positioned(
            top: 0,
            left: 0,
            height: 170,
            width: size.width,
            child: Container(
            alignment: Alignment.center,
          child: EasyDateTimeLine(
            initialDate: DateTime.now(),
              onDateChange: (selectedDate) {
            //`selectedDate` the new date selected.
          },
          )
          ))
      ]



      // child: Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     ElevatedButton(
      //         onPressed: () {
      //           Navigator.pushNamed(context, "/shop",
      //               arguments: {"title": "shop传值", "aid": 21});
      //         },
      //         child: const Text("命名路由传值")),
      //     const SizedBox(
      //       height: 20,
      //     ),
      //     ElevatedButton(
      //         onPressed: () {
      //           Navigator.pushNamed(context, "/dialog");
      //         },
      //         child: const Text("Dialog演示")),
     
      //   ],
      // ),
    );
  }
}
