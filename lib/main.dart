import 'package:flutter/material.dart';
import './routers/routers.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:firebase_ui_auth/firebase_ui_auth.dart'; // new
import 'package:provider/provider.dart';                 // new
import 'pages/tabs/app_state.dart';
import 'package:go_router/go_router.dart'; // new
import 'pages/tabs.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


/*Future <void>main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://rijtxybjyhmqrozwdylg.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJpanR4eWJqeWhtcXJvendkeWxnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDk2NzEwNDcsImV4cCI6MjAyNTI0NzA0N30.FGR_xkddzr2lSgCGA21EHyO_BU0AH6MxtMMkgOUxTeE',
  );
  runApp(const MyApp());
}*/

void main() {
  // Modify from here...
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider(
    create: (context) => ApplicationState(),
    builder: ((context, child) => const MyApp()),
  ));
  // ...to here.
}

/*final _router = GoRouter(
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
                  final user = switch (state) {
                  SignedIn state => state.user,
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
          path: "/eventDetails",
          builder: (context, state) => const EventDetailsPage(),

        )
      ],
    ),
  ],
);*/


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      /*initialRoute: "/",*/
      routerConfig: router,
      /*onGenerateRoute: onGenerateRoute,*/
    );
  }
}
