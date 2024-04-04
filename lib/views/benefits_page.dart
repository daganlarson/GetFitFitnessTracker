import 'dart:developer';

import 'package:flutter/material.dart';

class BenefitsPage extends StatefulWidget {
  const BenefitsPage({super.key});

  @override
  State<BenefitsPage> createState() => _BenefitsPageState();
}

class _BenefitsPageState extends State<BenefitsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff3b5998),
        title: Text("Benefits"),
      ),
      body: ListView.builder(
        itemCount: 12,
        itemBuilder: (context, index) =>CardItem(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.edit),
      )

    );
  }
}

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 350.0,
        color: Colors.blue,
        child: Column(
          children: <Widget>[
            const ListTile(
              leading: CircleAvatar(),
              title: Text("Benefits test"),
              subtitle: Text("subtitle test"),
            ),
            Expanded(
              child: Container(
                /*decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://static.vecteezy.com/system/resources/thumbnails/005/024/692/small/man-workout-in-gym-for-healthy-llifestyle-free-vector.jpg"),
                    fit: BoxFit.cover,
                  )
                ), */
              )
            ),
            const SizedBox(height: 14.0),
            IconButton(
              icon: Image.asset('assets/Fitness Graphic.png'),
              iconSize: 50,
              onPressed: () { log('image button pressed'); },
            ),
            const Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.thumb_up, color: Colors.grey),
                  SizedBox(width: 8.0),
                  Text("Like"),
                ]
              )
            ]),
            const SizedBox(height: 12.0),
          ],
        )
      )
    );
  }
}
