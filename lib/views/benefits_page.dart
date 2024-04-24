import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../models/appColors.dart';
import '../models/appTheme.dart';

final List<String> pngEntries = <String>['assets/images/FitnessGraphic.png','assets/images/runningGraphic.png','assets/images/yogaGraphic.jpg'];
final List<String> titleEntries = <String>['The Benefits of Exercise!', '11 Powerful Reasons Why You Should Be Running', 'Yoga for Mindfulness'];
final List<String> subtitleEntries = <String>['12 exercise benefits to encourage a workout routine', 'The Incredible Benefits of Running', 'The Benefits of a Daily Yoga Pracitce'];
final List<String> addressURLs = <String>['https://www.betterup.com/blog/exercise-benefits', 'https://www.beachbodyondemand.com/blog/benefits-of-running', 'https://mplsheart.org/news/yoga-and-meditation-study-communities-impacted-heart-disparities?gad_source=1&gclid=CjwKCAjwuJ2xBhA3EiwAMVjkVMWXHFK23j1eBuekW5WdLLhtj7511Cmi9UxPAWA1vDqJgddPZN3EgBoCUZgQAvD_BwE'];

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
        //backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text("Benefits"),
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {

          return Container(
              height: 350.0,
              //color: Theme.of(context).colorScheme.primaryContainer,
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(),
                    title: Text(titleEntries[index]),
                    subtitle: Text(subtitleEntries[index]),
                  ),
                  Expanded(
                      child: Container(
                        child: IconButton(
                          icon: Image.asset(pngEntries[index]),
                          onPressed: () => launchUrlString(addressURLs[index]),
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
          );
        }
      ),
    );
  }
}
