import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(15),
      children:<Widget>[
        Text(
          "Explore EventGather",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold
          ) 
        ),
        SizedBox(
          width: double.infinity,
          height: 20,
        ),
        Text(
          "Popular now",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold
          )
        ),
        SizedBox(
          width: double.infinity,
          height: 20,
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 2),
          padding: const EdgeInsets.all(18),
          height: 200,
          child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Container(
              width: 180.0,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4.0,
                  ),
                ],
              borderRadius: BorderRadius.circular(5),
              color: Colors.white
            ), 
          ),
          SizedBox(
          width: 20,
          height: 200,
          ),
          Container(
            width: 180.0,
               decoration: BoxDecoration(
                border: new Border.all(
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
              color: Colors.white
            ), 
              
            
            child: Column(
children: <Widget>[ Image.network("https://www.itying.com/images/flutter/1.png"), const Text('我是一个文本')
], ),
          ),

          SizedBox(
          width: 20,
          height: 200,
          ),
          Container(
            width: 180.0,
               decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4.0,
                  ),
                ],
              borderRadius: BorderRadius.circular(5),
              color: Colors.white
            ), 
              
            
            child: Column(
children: <Widget>[ Image.network("https://www.itying.com/images/flutter/1.png"), const Text('我是一个文本')
], ),
          ),
          ]
        ),      

        ),
        
        Card(
            shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          margin: const EdgeInsets.all(10),
          child:Column(
            children: <Widget>[
              Container(
                width:300,
                height:100,
                child: AspectRatio(
                aspectRatio: 20/9,
                child:
                  Image.network(
                    "https://www.itying.com/images/flutter/2.png",
                    fit: BoxFit.cover,
                  )
              ), 
              ),
             
              ListTile(
                leading: ClipOval(
                child:
Image.network("https://www.itying.com/images/flutter/2.png",fit:
BoxFit.cover,height:60,width: 60),
                    ),
                    title:const Text("xxxx"),
                    subtitle:const Text("xxxxxxx"),
)
              ]
          )
        ),



        Image.network("https://www.itying.com/images/flutter/1.png"),
          Container(
            height: 44,
            padding:const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: const Text(
'我是一个标题',
textAlign: TextAlign.center, style: TextStyle(
                  fontSize: 18,
                ),
), ),
      ]
    );
  }
}
