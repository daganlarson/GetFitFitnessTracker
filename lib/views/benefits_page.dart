import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../models/appTheme.dart';

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
        backgroundColor: AppTheme.colors.outerSpace,
        title: Text("Benefits"),
      ),
      body: ListView.builder(
        itemCount: 12,
        itemBuilder: (context, index) =>CardItem(),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.edit),
      )*/

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
                child: IconButton(
                  icon: Image.asset('assets/images/FitnessGraphic.png'),
                  onPressed: () => launchUrlString('https://www.betterup.com/blog/exercise-benefits'),
                ),
              )
            ),
            const SizedBox(height: 14.0),
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
