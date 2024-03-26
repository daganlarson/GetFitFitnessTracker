//import 'dart:html';

import 'package:binarybrigade/pages/distance_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int pageIndex = 0;
  final screens = [
    const DistancePage(),
    const MyHomePage(),
  ];
  final screens2 = [
    const Center(child: Text('home')),
    const Center(child: Text('settings')),
    const Center(child: Text('person')),
    const Center(child: Text('calendar')),
    const Center(child: Text('explore')),
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
        body: screens[pageIndex],
        bottomNavigationBar: NavigationBar(

          onDestinationSelected: (pageIndex) =>
              setState(() => this.pageIndex = pageIndex),
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.home),
                label: 'Home'
            ),
            NavigationDestination(
                icon: Icon(Icons.settings),
                label: 'Settings'
            ),
            NavigationDestination(
                icon: Icon(Icons.person),
                label: 'Person'
            ),
            NavigationDestination(
                icon: Icon(Icons.calendar_month),
                label: 'Calendar'
            ),
            NavigationDestination(
                icon: Icon(Icons.explore),
                label: 'Explore'
            )
          ],
        ),
  );

    /*return const DefaultTabController(length: 5, child: Scaffold(
      bottomNavigationBar: TabBar( tabs: [
          Tab(
            icon: Icon(Icons.home),),
          Tab(
            icon: Icon(Icons.settings),),
          Tab(
            icon: Icon(Icons.person),),
          Tab(
            icon: Icon(Icons.calendar_month),),
          Tab(
            icon: Icon(Icons.explore),
            text: 'Track'),
        ],
      ),
      body: TabBarView( children: [
        Icon(Icons.home),
        Icon(Icons.settings),
        Icon(Icons.person),
        Icon(Icons.calendar_month),
        Icon(Icons.explore),
      ]
    )
    )); */


}
