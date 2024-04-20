/*
//ios风格的路由
import 'package:event_gather/pages/tabs/discoverGroup.dart';
import 'package:event_gather/pages/tabs/eventDetails.dart';
import 'package:event_gather/pages/tabs/groupDetails.dart';
import 'package:event_gather/pages/tabs/chatPage.dart';
import 'package:event_gather/pages/tabs/startGroup.dart';
import 'package:flutter/cupertino.dart';
import '../pages/tabs.dart';


//1、配置路由
Map routes = {
  "/": (contxt) => const Tabs(),
  '/eventDetails': (contxt) => const EventDetailsPage(),
  '/groupDetails': (contxt) => const GroupDetailsPage(),
  '/chatPage': (contxt) => const ChatPage(),
  '/startGroupPage': (contxt) => const StartGroupPage(),
  '/discoverGroupPage': (contxt) => const DiscoverGroupPage()
};

//2、配置onGenerateRoute  固定写法  这个方法也相当于一个中间件，这里可以做权限判断
var onGenerateRoute = (RouteSettings settings) {
  final String? name = settings.name; //  /news 或者 /search
  final Function? pageContentBuilder = routes[name];                          //  Function = (contxt) { return const NewsPage()}

  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = CupertinoPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          CupertinoPageRoute(builder: (context) => pageContentBuilder(context));

      return route;
    }
  }
  return null;
};
*/

import 'package:event_gather/pages/tabs/discoverGroup.dart';
import 'package:event_gather/pages/tabs/eventDetails.dart';
import 'package:event_gather/pages/tabs/groupDetails.dart';
import 'package:event_gather/pages/tabs/chatPage.dart';
import 'package:event_gather/pages/tabs/startGroup.dart';
import 'package:flutter/cupertino.dart';
import '../pages/tabs.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Tabs(),
      routes: [
        GoRoute(
          path: 'sign-in',
          builder: (context, state) {
            return SignInScreen(
              actions: [
                ForgotPasswordAction(((context, email) {
                  final uri = Uri(
                    path: '/sign-in/forgot-password',
                    queryParameters: <String, String?>{
                      'email': email,
                    },
                  );
                  context.push(uri.toString());
                })),
                AuthStateChangeAction(((context, state) {
                  final user =
                  switch (state) {
                  SignedIn state =>
                  state.user
                  ,
                  UserCreated state => state.credential.user,
                  _ => null
                  };
                  if (user == null) {
                  return;
                  }
                  if (state is UserCreated) {
                  user.updateDisplayName(user.email!.split('@')[0]);
                  }
                  if (!user.emailVerified) {
                  user.sendEmailVerification();
                  const snackBar = SnackBar(
                  content: Text(
                  'Please check your email to verify your email address'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  context.pushReplacement('/');
                  })),
              ],
            );
          },
          routes: [
            GoRoute(
              path: 'forgot-password',
              builder: (context, state) {
                final arguments = state.uri.queryParameters;
                return ForgotPasswordScreen(
                  email: arguments['email'],
                  headerMaxExtent: 200,
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: 'profile',
          builder: (context, state) {
            return ProfileScreen(
              providers: const [],
              actions: [
                SignedOutAction((context) {
                  context.pushReplacement('/');
                }),
              ],
            );
          },
        ),
        GoRoute(
          path: "eventDetails/:eventId",
          builder: (context, state) {
            final eventId = state.pathParameters['eventId']!;
            return EventDetailsPage(eventId: eventId);
          },
        ),
        GoRoute(
          path: "groupDetails/:groupId",
          builder: (context, state) {
            final groupId = state.pathParameters['groupId']!;
            return GroupDetailsPage(groupId: groupId);
          },
        ),
        GoRoute(
          path: "chatPage/:chatId",
          builder: (context, state) {
            final chatId = state.pathParameters['chatId']!;
            return ChatPage(chatId: chatId);
          },
        ),
        GoRoute(
          path: "discoverGroup",
          builder: (context, state) => const DiscoverGroupPage(),
        ),
        GoRoute(
          path: "startGroup",
          builder: (context, state) => const StartGroupPage(),
        )
      ],
    ),
  ],
);
