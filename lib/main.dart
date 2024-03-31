import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("couldn't connect");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: const HomePage(title: 'Flutter Demo Home Page'),
            );
          } else {
            Widget loading = const MaterialApp();
            return loading;
          }
        });
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(length: 4, child: Scaffold(
      bottomNavigationBar: TabBar( tabs: [
          Tab(icon: Icon(Icons.home),),
          Tab(icon: Icon(Icons.settings),),
          Tab(icon: Icon(Icons.person),),
          Tab(icon: Icon(Icons.calendar_month),),
        ],
      ),
      body: TabBarView( children: [
        Icon(Icons.home),
        Icon(Icons.settings),
        Icon(Icons.person),
        Icon(Icons.calendar_month),
      ]
    )
    ));
  }
}
