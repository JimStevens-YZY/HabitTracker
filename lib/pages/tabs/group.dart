import 'package:flutter/material.dart';
import '../../res/listData.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
            title: const Text('Groups',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
        backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
        body: const GroupMain());
  }
}

class GroupMain extends StatefulWidget {
  const GroupMain({super.key});

  @override
  State<GroupMain> createState() => _GroupMainState();
}

class _GroupMainState extends State<GroupMain> with TickerProviderStateMixin {
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
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Groups you'll like",
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              const SizedBox(
                width: double.infinity,
                height: 20,
              ),
              Consumer<ApplicationState>(
                builder: (context, appState, _) => Column(
                  children: [
                    if (appState.allGroups.isNotEmpty) ...[
                      for (var group in appState.allGroups
                          .where((element) => element.groupType == 1)
                          .toList())
                        GestureDetector(
                          onTap: () {
                            GoRouter.of(context).push('/groupDetails/${group.groupId}');
                          },
                          child: Container(
                              height: 130,
                              padding: const EdgeInsets.only(bottom: 10),
                              child:
                                  Flex(direction: Axis.horizontal, children: [
                                Expanded(
                                    flex: 1,
                                    child: Row(children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(group.groupBg,
                                            height: double.infinity,
                                            width: (size.width - 30) / 3,
                                            fit: BoxFit.cover),
                                      ),
                                    ])),
                                Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            group.groupName,
                                            style: const TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromRGBO(
                                                    53, 52, 77, 1.0)),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            group.groupDesc,
                                            style: const TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w400),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            group.groupLocation,
                                            style: const TextStyle(
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w400,
                                                color: Color.fromRGBO(
                                                    108, 111, 132, 1.0)),
                                          ),
                                          Row(
                                            children: [
                                              const Icon(Icons.person_sharp,
                                                  size: 15,
                                                  color: Color.fromRGBO(
                                                      99, 100, 112, 1.0)),
                                              SizedBox(width: 6),
                                              Text(
                                                '${group.groupOrganizers.length} Members',
                                                style: const TextStyle(
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color.fromRGBO(
                                                        56, 55, 79, 1.0)),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )),
                              ])),
                        ),
                    ],
                  ],
                ),
              ),
              /*GestureDetector(
                onTap: () {

                  GoRouter.of(context).push('/groupDetails');
                  */ /*Navigator.pushNamed(context, '/groupDetails');*/ /*
                },
                child:Container(
                    height: 120,
                    child: Flex(direction: Axis.horizontal, children: [
                      Expanded(
                          flex: 1,
                          child: Row(children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                  "https://seniorassistant.oss-cn-hangzhou.aliyuncs.com/zust-lcy-path/20230406/2023040622447.jpg",
                                  height: double.infinity,
                                  width: 120,
                                  fit: BoxFit.cover),
                            ),
                          ])),
                      const Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Medway & Maidstone under 40's Social",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromRGBO(53, 52, 77, 1.0))),
                                Text(
                                    'A friendly group from local people living in Thamesmead',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400)),
                                Text(
                                  'Rochester, G5',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(108, 111, 132, 1.0)),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.person_sharp,
                                        size: 15,
                                        color: Color.fromRGBO(99, 100, 112, 1.0)),
                                    SizedBox(width: 6),
                                    Text(
                                      '39 Members',
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w400,
                                          color: Color.fromRGBO(56, 55, 79, 1.0)),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )),
                    ])),
              ),*/
              const SizedBox(
                width: double.infinity,
                height: 10,
              ),
              const Text("Popular in London",
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              const SizedBox(
                width: double.infinity,
                height: 20,
              ),
              Consumer<ApplicationState>(
                builder: (context, appState, _){
                  var groups = appState.allGroups.where((element) => element.groupType == 2).toList();

                  return Column(
                    children: [
                      if (appState.allGroups.isNotEmpty) ...[
                        /*for (var group in appState.allGroups
                            .where((element) => element.groupType == 2)
                            .toList())*/
                        for (var index = 0; index < groups.length; index++)
                          GestureDetector(
                            onTap: () {
                              GoRouter.of(context).push('/groupDetails/${groups[index].groupId}');
                              /*Navigator.pushNamed(context, '/groupDetails');*/
                            },
                            child:  Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 200,
                                    width: double.infinity,
                                    child: Stack(
                                      fit: StackFit.loose,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.network(
                                              groups[index].groupBg,
                                              height: 200,
                                              width: double.infinity,
                                              fit: BoxFit.cover),
                                        ),
                                        Positioned(
                                            top: 10,
                                            left: 10,
                                            height: 30,
                                            width: 30,
                                            child: Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(50),
                                                color: Colors.white,
                                              ),
                                              child: Text(
                                                (index+1).toString(),
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(groups[index].groupName,
                                            style: const TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromRGBO(53, 52, 77, 1.0))),
                                        Text(
                                          groups[index].groupDesc,
                                          style: const TextStyle(
                                              fontSize: 12.0, fontWeight: FontWeight.w400),maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          groups[index].groupLocation,
                                          style: const TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w400,
                                              color: Color.fromRGBO(108, 111, 132, 1.0)),
                                        ),
                                      ],
                                    ),
                                  ),
/*                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                          "https://seniorassistant.oss-cn-hangzhou.aliyuncs.com/zust-lcy-path/20230406/2023040622447.jpg",
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Medway & Maidstone under 40's Social",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(53, 52, 77, 1.0))),
                          Text(
                              'A friendly group from local people living in Thamesmead',
                              style: TextStyle(
                                  fontSize: 12.0, fontWeight: FontWeight.w400)),
                          Text(
                            'Rochester, G5',
                            style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(108, 111, 132, 1.0)),
                          ),
                        ],
                      ),
                    ),*/

/*                    GridView.count(
                      shrinkWrap: true,
                      crossAxisSpacing: 10.0,
                      //水平子 Widget 之间间距
                      mainAxisSpacing: 10.0,
                      //垂直子 Widget 之间间距
                      padding: const EdgeInsets.all(10),
                      crossAxisCount: 2,
                      //一行的 Widget 数量
                      childAspectRatio: 0.7,
                      //宽度和高度的比例
                      children: _getListData(),
                    )*/
                                ],
                              ),
                            ),
                          )
                      ],
                    ],
                  );
                }

              ),                  const SizedBox(
                width: double.infinity,
                height: 10,
              ),
              const Text("Browse by categories",
                  style: TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.bold)),
              const SizedBox(
                width: double.infinity,
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
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                      category.categoryBg,
                                      height: 140,
                                      width: 0.45 * size.width,
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
                                ),
                              ],
                            ),
                        ],
                      ],
                    ),
                  ))
              /*Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      child: Stack(
                        fit: StackFit.loose,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                                "https://seniorassistant.oss-cn-hangzhou.aliyuncs.com/zust-lcy-path/20230406/2023040622447.jpg",
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover),
                          ),
                          Positioned(
                              top: 10,
                              left: 10,
                              height: 30,
                              width: 30,
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white,
                                ),
                                child: const Text(
                                  "1",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                              )),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Medway & Maidstone under 40's Social",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(53, 52, 77, 1.0))),
                          Text(
                              'A friendly group from local people living in Thamesmead',
                              style: TextStyle(
                                  fontSize: 12.0, fontWeight: FontWeight.w400)),
                          Text(
                            'Rochester, G5',
                            style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(108, 111, 132, 1.0)),
                          ),
                        ],
                      ),
                    ),
*//*                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                          "https://seniorassistant.oss-cn-hangzhou.aliyuncs.com/zust-lcy-path/20230406/2023040622447.jpg",
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Medway & Maidstone under 40's Social",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(53, 52, 77, 1.0))),
                          Text(
                              'A friendly group from local people living in Thamesmead',
                              style: TextStyle(
                                  fontSize: 12.0, fontWeight: FontWeight.w400)),
                          Text(
                            'Rochester, G5',
                            style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(108, 111, 132, 1.0)),
                          ),
                        ],
                      ),
                    ),*//*
                    const SizedBox(
                      width: double.infinity,
                      height: 40,
                    ),
                    const Text("Browse by categories",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      width: double.infinity,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                            category.categoryBg,
                                            height: 140,
                                            width: 195,
                                            fit: BoxFit.cover),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 5, top: 5, bottom: 20),
                                        child: Text(category.categoryName,
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w600,
                                                color: Color.fromRGBO(
                                                    53, 52, 77, 1.0))),
                                      ),
                                    ],
                                  ),
                              ],
                            ],
                          ),
                        ))
*//*                    GridView.count(
                      shrinkWrap: true,
                      crossAxisSpacing: 10.0,
                      //水平子 Widget 之间间距
                      mainAxisSpacing: 10.0,
                      //垂直子 Widget 之间间距
                      padding: const EdgeInsets.all(10),
                      crossAxisCount: 2,
                      //一行的 Widget 数量
                      childAspectRatio: 0.7,
                      //宽度和高度的比例
                      children: _getListData(),
                    )*//*
                  ],
                ),
              )*/
            ],
          ),
        ),
      ],
    );
  }
}
