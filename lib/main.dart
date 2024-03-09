import 'package:flutter/material.dart';
import './routers/routers.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future <void>main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://rijtxybjyhmqrozwdylg.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJpanR4eWJqeWhtcXJvendkeWxnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDk2NzEwNDcsImV4cCI6MjAyNTI0NzA0N30.FGR_xkddzr2lSgCGA21EHyO_BU0AH6MxtMMkgOUxTeE',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: "/",
      onGenerateRoute: onGenerateRoute,
    );
  }
}
