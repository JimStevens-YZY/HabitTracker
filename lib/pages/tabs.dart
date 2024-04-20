import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './tabs/home.dart';
import './tabs/me.dart';
import './tabs/group.dart';
import './tabs/events.dart';
import './tabs/messages.dart';
import 'package:go_router/go_router.dart';
import './tabs/app_state.dart';
import 'package:firebase_auth/firebase_auth.dart' // new
    hide
        EmailAuthProvider,
        PhoneAuthProvider;

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;
  final List<Widget> _pages = const [
    HomePage(),
    GroupPage(),
    MessagesPage(),
    EventsPage(),
    MePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Consumer<ApplicationState>(
          builder: (context,appState, _)=>Column(
            children: [
              SizedBox(height: 70,),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: Text("Profile"),
                onTap: () {
                  context.push('/profile');
                },
              ),
              const Divider(),
              Consumer<ApplicationState>(
                builder: (context, appState, _) {
                  void signOut() {
                    FirebaseAuth.instance.signOut();
                  }

                  return ListTile(
                      leading: CircleAvatar(
                        child: Icon(Icons.logout),
                      ),
                      title: Text("LogOut"),
                      onTap: () {
                        !appState.loggedIn ? context.push('/sign-in') : signOut();
                      });
                },
              ),
              const Divider(),
            ],
          ),
        )
      ),
      body: _pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
          fixedColor: Color.fromRGBO(98, 97, 99, 1.0),
          unselectedItemColor: Color.fromRGBO(169, 168, 169, 1.0),
          //选中的颜色
          // iconSize:35,           //底部菜单大小
          currentIndex: _currentIndex,
          //第几个菜单选中
          type: BottomNavigationBarType.fixed,
          //如果底部有4个或者4个以上的菜单的时候需要配置这个参数
          onTap: (index) {
            //点击菜单触发的方法
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.group_work), label: "Groups"),
            BottomNavigationBarItem(
                icon: Icon(Icons.question_answer), label: "Messages"),
            BottomNavigationBarItem(
                icon: Icon(Icons.confirmation_number), label: "Events"),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "Me")
          ]),
/*      floatingActionButton: Container(
        height: 60,
        //调整FloatingActionButton的大小
        width: 60,
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.only(top: 5),
        //调整FloatingActionButton的位置
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: FloatingActionButton(
            backgroundColor: _currentIndex == 2 ? Colors.red : Colors.blue,
            child: const Icon(Icons.add),
            onPressed: () {
              setState(() {
                _currentIndex = 2;
              });
            }),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked, */ //配置浮动按钮的位置
    );
  }
}
