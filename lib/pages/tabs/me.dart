import 'dart:ui';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import 'emptyAppBar.dart';
import '../../res/style.dart';

import 'package:firebase_auth/firebase_auth.dart' // new
    hide
        EmailAuthProvider,
        PhoneAuthProvider;
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'widgets.dart';
import 'authentication.dart';
import 'guest_book.dart';
import 'package:go_router/go_router.dart';

class MePage extends StatelessWidget {
  const MePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    return Scaffold(
        primary: false,
        appBar: EmptyAppBar(),
        backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
        body: MeMain(
          rpx: rpx,
        ));
  }
}

class MeMain extends StatefulWidget {
  const MeMain({Key? key, required this.rpx}) : super(key: key);
  final double rpx;

  @override
  State<MeMain> createState() => _MeMainState();
}

class _MeMainState extends State<MeMain> {
/*  final _userInfo = Supabase.instance.client.from('users').select();*/

  @override
  Widget build(BuildContext context) {
/*    Consumer<ApplicationState>(
      builder: (context, appState, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (appState.loggedIn) ...[
            const Header('Discussion'),
            GuestBook(
              addMessage: (message) =>
                  appState.addMessageToGuestBook(message),
              messages: appState.guestBookMessages,
            ),
          ],
        ],
      ),
    ),*/
    return Consumer<ApplicationState>(builder: (context, appState, _) {
      final userName = FirebaseAuth.instance.currentUser?.displayName == null
          ? 'Oliver'
          : FirebaseAuth.instance.currentUser!.displayName;
      return Column(
        children: [
          if (appState.loggedIn) ...[
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.9,
                child: Consumer<ApplicationState>(
                  builder: (context, appState, _) => ListView(
                    children: [
                      Stack(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Image.network(
                                appState.users.isNotEmpty
                                    ? appState.users.first.background
                                    : "https://seniorassistant.oss-cn-hangzhou.aliyuncs.com/zust-lcy-path/20230406/2023040622447.jpg",
                                width: double.infinity,
                                height: 300,
                                fit: BoxFit.cover,
                              ),
                              BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                                child: Container(),
                              )
                            ],
                          ),
                          Positioned(
                              top: 100,
                              left: MediaQuery.of(context).size.width / 2 - 65,
                              child: SizedBox(
                                width: 140,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            radius: 60,
                                            backgroundColor: Colors.white,
                                            child: CircleAvatar(
                                              radius: 57,
                                              backgroundImage: NetworkImage(
                                                  "https://seniorassistant.oss-cn-hangzhou.aliyuncs.com/omg-img-path/avatar.jpeg"),
                                            ),
                                          ),
                                        ]),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(userName!,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 22,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600))
                                  ],
                                ),
                              )),
                        ],
                      ),
                      Container(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text('5',
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        Text('Groups',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            )),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                            appState.users.isNotEmpty
                                                ? appState.users.first.interests
                                                    .length
                                                    .toString()
                                                : "0",
                                            style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        const Text('Interests',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            )),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                            appState.signedEvent
                                                .where((event) =>
                                                    event.userId ==
                                                    FirebaseAuth.instance
                                                        .currentUser!.uid)
                                                .toList()
                                                .length
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        Text('RSVPS',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 15, left: 15, right: 15, bottom: 0),
                                child: Text("I'm looking to",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Wrap(
                                  spacing: 8,
                                  runSpacing: 10,
// direction: Axis.vertical,
// alignment:WrapAlignment.start,
// runAlignment: WrapAlignment.center,
                                  children: <Widget>[
                                    if (appState.users.isNotEmpty)
                                      for (var interest
                                          in appState.users.first.lookingTo)
                                        Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: const Color.fromRGBO(
                                                  240, 240, 245, 1.0),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4.0,
                                                      horizontal: 8.0),
                                              child: Text(interest,
                                                  style: const TextStyle(
                                                    fontSize: 12.0,
                                                    color: Color.fromRGBO(
                                                        113, 113, 115, 1.0),
                                                    fontWeight: FontWeight.w500,
                                                  )),
                                            ))
                                    else
                                      const Text(
                                          "You have not selected what you are looking for",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Color.fromRGBO(
                                                113, 113, 115, 1.0),
                                            fontWeight: FontWeight.w300,
                                          ))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, left: 15, right: 15, bottom: 0),
                                child: Text(
                                    "Interests (${appState.users.isNotEmpty ? appState.users.first.interests.length : 0})",
                                    style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Wrap(
                                  spacing: 8,
                                  runSpacing: 10,
// direction: Axis.vertical,
// alignment:WrapAlignment.start,
// runAlignment: WrapAlignment.center,
                                  children: <Widget>[
                                    if (appState.users.isNotEmpty)
                                      for (var interest
                                          in appState.users.first.interests)
                                        Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: const Color.fromRGBO(
                                                  240, 240, 245, 1.0),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4.0,
                                                      horizontal: 8.0),
                                              child: Text(interest,
                                                  style: const TextStyle(
                                                    fontSize: 12.0,
                                                    color: Color.fromRGBO(
                                                        113, 113, 115, 1.0),
                                                    fontWeight: FontWeight.w500,
                                                  )),
                                            ))
                                    else
                                      const Text(
                                          "You have not selected your interests yet.",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Color.fromRGBO(
                                                113, 113, 115, 1.0),
                                            fontWeight: FontWeight.w300,
                                          ))
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 15, left: 15, right: 15, bottom: 0),
                                child: Text("Organizer",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, left: 15, right: 15, bottom: 0),
                                child: GestureDetector(
                                  onTap: () {
                                    GoRouter.of(context).push('/startGroup');
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: const Color.fromRGBO(
                                                    207, 205, 210, 1.0)),
                                            child: const Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Start a new group',
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                  )),
                                              Text('Organize your own events',
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Color.fromRGBO(
                                                        113, 113, 115, 1.0),
                                                    fontWeight: FontWeight.w300,
                                                  )),
                                            ],
                                          )
                                        ],
                                      ),
                                      const Icon(Icons.chevron_right_rounded,
                                          color: Color.fromRGBO(
                                              118, 118, 118, 1.0))
                                    ],
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 15, left: 15, right: 15, bottom: 0),
                                child: Text("Member",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, left: 15, right: 15, bottom: 0),
                                child: GestureDetector(
                                  onTap: () {
                                    GoRouter.of(context).push('/discoverGroup');
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: const Color.fromRGBO(
                                                    207, 205, 210, 1.0)),
                                            child: const Icon(
                                              Icons.search_rounded,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Discover more groups',
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                  )),
                                              Text('Search by your interests',
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Color.fromRGBO(
                                                        113, 113, 115, 1.0),
                                                    fontWeight: FontWeight.w300,
                                                  )),
                                            ],
                                          )
                                        ],
                                      ),
                                      const Icon(Icons.chevron_right_rounded,
                                          color: Color.fromRGBO(
                                              118, 118, 118, 1.0))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ))
          ] else if (!appState.loggedIn) ...[
            Expanded(
              flex: 1,
              child: Container(
                  child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/bg.jpg'),
                        fit: BoxFit.fill, // 设置填充方式为填满父容器
                      ),
                    ),
                  ),
                  const Positioned(
                    top: 194,
                    left: 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'EventGather',
                          style: kTitleTextStyle,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Where Moments Unite,\nMemories Ignite',
                          style: kBodyTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.6,
                    left: MediaQuery.of(context).size.width / 2 - 104,
                    child: GestureDetector(
                      onTap: () {
                        context.push('/sign-in');
                      },
                      child: Container(
                        width: 208,
                        height: 48,
                        decoration: BoxDecoration(
                          gradient: kBtnLinearGradient,
                          boxShadow: kBtnShadow,
                          borderRadius: BorderRadius.circular(kBtnRadius),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Sign up",
                          style: kBtnTextStyle.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Positioned(
                      top: MediaQuery.of(context).size.height * 0.6 + 60,
                      left: MediaQuery.of(context).size.width / 2 - 104,
                      child: GestureDetector(
                        child: Container(
                          width: 208,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: kBtnShadow,
                            borderRadius: BorderRadius.circular(kBtnRadius),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Login',
                            style: kBtnTextStyle,
                          ),
                        ),
                        onTap: () {
                          context.push('/sign-in');
                        },
                      ))
                ],
              )),
            )

            /* GestureDetector(
                    child: LoginBtnWidget(),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return LoginPage();
                        },
                      ));
                    },
                  ),*/
          ]
        ],
      );
    });
  }
}

class SilverTopBar extends StatelessWidget {
  const SilverTopBar(
      {Key? key, required this.extraPicHeight, required this.fitType})
      : super(key: key);
  final double extraPicHeight;
  final BoxFit fitType;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Image.network(
              "https://seniorassistant.oss-cn-hangzhou.aliyuncs.com/zust-lcy-path/20230406/2023040622447.jpg",
              width: double.infinity,
              height: 300 + extraPicHeight,
              fit: fitType,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
              child: Container(),
            )
          ],
        ),
        Positioned(
            top: 120 + extraPicHeight,
            left: MediaQuery.of(context).size.width / 2 - 65,
            child: const SizedBox(
              width: 140,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 57,
                            backgroundImage: NetworkImage(
                                "https://www.itying.com/images/flutter/3.png"),
                          ),
                        ),
                      ]),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Jim Stevens',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w600))
                ],
              ),
            )),
      ],
    );
  }
}

/*class MeMain extends StatefulWidget {
  const MeMain({Key? key, required this.rpx}) : super(key: key);
  final double rpx;

  @override
  State<MeMain> createState() => _MeMainState();
}

class _MeMainState extends State<MeMain> with TickerProviderStateMixin {
  double extraPicHeight = 0;
  late BoxFit fitType;
  double prev_dy = 0;
  late double rpx;
  late AnimationController animationController;
  late Animation<double> anim;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 3);
    prev_dy = 0;
    fitType = BoxFit.cover;
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    anim = Tween(begin: 0.0, end: 0.0).animate(animationController);
  }

  updatePicHeight(changed) {
    if (prev_dy == 0) {
      prev_dy = changed;
    }
    extraPicHeight += changed - prev_dy;
    if (extraPicHeight >= 200) {
      fitType = BoxFit.fitHeight;
    } else {
      fitType = BoxFit.cover;
    }
    setState(() {
      prev_dy = changed;
      extraPicHeight = extraPicHeight;
    });
  }

  runAnimate() {
    setState(() {
      anim = Tween(begin: extraPicHeight, end: 0.0).animate(animationController)
        ..addListener(() {
          if (extraPicHeight >= 200) {
            fitType = BoxFit.fitHeight;
          } else {
            fitType = BoxFit.cover;
          }
          setState(() {
            extraPicHeight = anim.value;
          });
        });
      prev_dy = 0;
    });
  }

  final _userInfo = Supabase.instance.client.from('users').select();

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerMove: (result) {
        updatePicHeight(result.position.dy);
      },
      onPointerUp: (_) {
        runAnimate();
        animationController.forward(from: 0);
      },
      child: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
              */ /* leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {},
            ),*/ /*
              floating: true,
              pinned: false,
              snap: true,
              expandedHeight: 250 + extraPicHeight,
              //必须设定,否则无法显示
              flexibleSpace: FlexibleSpaceBar(
                background: SilverTopBar(
                    extraPicHeight: extraPicHeight, fitType: fitType),
              )),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('5',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    )),
                                Text('Groups',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    )),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('3',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    )),
                                Text('Interests',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    )),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('7',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    )),
                                Text('RSVPS',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 15, left: 15, right: 15, bottom: 0),
                        child: Text("I'm looking to",
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 10,
                          // direction: Axis.vertical,
                          // alignment:WrapAlignment.start,
                          // runAlignment: WrapAlignment.center,
                          children: <Widget>[
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color:
                                      const Color.fromRGBO(240, 240, 245, 1.0),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 8.0),
                                  child: Text('😀sdasd',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color:
                                            Color.fromRGBO(113, 113, 115, 1.0),
                                        fontWeight: FontWeight.w500,
                                      )),
                                )),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color.fromRGBO(
                                        240, 240, 245, 1.0)),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 8.0),
                                  child: Text('😀aasdasd',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color:
                                            Color.fromRGBO(113, 113, 115, 1.0),
                                        fontWeight: FontWeight.w500,
                                      )),
                                )),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color.fromRGBO(
                                        240, 240, 245, 1.0)),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 8.0),
                                  child: Text('😀aaaasd',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color:
                                            Color.fromRGBO(113, 113, 115, 1.0),
                                        fontWeight: FontWeight.w500,
                                      )),
                                )),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color.fromRGBO(
                                        240, 240, 245, 1.0)),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 8.0),
                                  child: Text('aaaaaasdasd',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color:
                                            Color.fromRGBO(113, 113, 115, 1.0),
                                        fontWeight: FontWeight.w500,
                                      )),
                                )),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color.fromRGBO(
                                        240, 240, 245, 1.0)),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 8.0),
                                  child: Text('aaaaaasdasd',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color:
                                            Color.fromRGBO(113, 113, 115, 1.0),
                                        fontWeight: FontWeight.w500,
                                      )),
                                )),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color.fromRGBO(
                                        240, 240, 245, 1.0)),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 8.0),
                                  child: Text('aaaaaasdasd',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color:
                                            Color.fromRGBO(113, 113, 115, 1.0),
                                        fontWeight: FontWeight.w500,
                                      )),
                                )),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 15, left: 15, right: 15, bottom: 0),
                        child: Text("Interests (18)",
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 10,
                          // direction: Axis.vertical,
                          // alignment:WrapAlignment.start,
                          // runAlignment: WrapAlignment.center,
                          children: <Widget>[
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color:
                                      const Color.fromRGBO(240, 240, 245, 1.0),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 8.0),
                                  child: Text('😀sdasd',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color:
                                            Color.fromRGBO(113, 113, 115, 1.0),
                                        fontWeight: FontWeight.w500,
                                      )),
                                )),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color.fromRGBO(
                                        240, 240, 245, 1.0)),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 8.0),
                                  child: Text('😀aasdasd',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color:
                                            Color.fromRGBO(113, 113, 115, 1.0),
                                        fontWeight: FontWeight.w500,
                                      )),
                                )),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color.fromRGBO(
                                        240, 240, 245, 1.0)),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 8.0),
                                  child: Text('😀aaaasd',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color:
                                            Color.fromRGBO(113, 113, 115, 1.0),
                                        fontWeight: FontWeight.w500,
                                      )),
                                )),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color.fromRGBO(
                                        240, 240, 245, 1.0)),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 8.0),
                                  child: Text('aaaaaasdasd',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color:
                                            Color.fromRGBO(113, 113, 115, 1.0),
                                        fontWeight: FontWeight.w500,
                                      )),
                                )),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color.fromRGBO(
                                        240, 240, 245, 1.0)),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 8.0),
                                  child: Text('aaaaaasdasd',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color:
                                            Color.fromRGBO(113, 113, 115, 1.0),
                                        fontWeight: FontWeight.w500,
                                      )),
                                )),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color.fromRGBO(
                                        240, 240, 245, 1.0)),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 8.0),
                                  child: Text('aaaaaasdasd',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color:
                                            Color.fromRGBO(113, 113, 115, 1.0),
                                        fontWeight: FontWeight.w500,
                                      )),
                                )),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 15, left: 15, right: 15, bottom: 0),
                        child: Text("Organizer",
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15, left: 15, right: 15, bottom: 0),
                        child: GestureDetector(
                          onTap: () {
                            // 点击事件代码
                            Navigator.pushNamed(context, '/startGroupPage');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: const Color.fromRGBO(
                                            207, 205, 210, 1.0)),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Start a new group',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          )),
                                      Text('Organize your own events',
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Color.fromRGBO(
                                                113, 113, 115, 1.0),
                                            fontWeight: FontWeight.w300,
                                          )),
                                    ],
                                  )
                                ],
                              ),
                              const Icon(Icons.chevron_right_rounded,
                                  color: Color.fromRGBO(118, 118, 118, 1.0))
                            ],
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 15, left: 15, right: 15, bottom: 0),
                        child: Text("Member",
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15, left: 15, right: 15, bottom: 0),
                        child: GestureDetector(
                          onTap: () {
                            // 点击事件代码
                            Navigator.pushNamed(context, '/discoverGroupPage');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: const Color.fromRGBO(
                                            207, 205, 210, 1.0)),
                                    child: const Icon(
                                      Icons.search_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Discover more groups',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          )),
                                      Text('Search by your interests',
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Color.fromRGBO(
                                                113, 113, 115, 1.0),
                                            fontWeight: FontWeight.w300,
                                          )),
                                    ],
                                  )
                                ],
                              ),
                              const Icon(Icons.chevron_right_rounded,
                                  color: Color.fromRGBO(118, 118, 118, 1.0))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ));
            },
            childCount: 1,
          ))
        ],
      ),
    );
  }
}

class SilverTopBar extends StatelessWidget {
  const SilverTopBar(
      {Key? key, required this.extraPicHeight, required this.fitType})
      : super(key: key);
  final double extraPicHeight;
  final BoxFit fitType;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Image.network(
              "https://seniorassistant.oss-cn-hangzhou.aliyuncs.com/zust-lcy-path/20230406/2023040622447.jpg",
              width: double.infinity,
              height: 300 + extraPicHeight,
              fit: fitType,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
              child: Container(),
            )
          ],
        ),
        Positioned(
            top: 120 + extraPicHeight,
            left: MediaQuery.of(context).size.width / 2 - 65,
            child: const SizedBox(
              width: 140,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 57,
                            backgroundImage: NetworkImage(
                                "https://www.itying.com/images/flutter/3.png"),
                          ),
                        ),
                      ]),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Jim Stevens',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w600))
                ],
              ),
            )),
      ],
    );
  }
}*/
