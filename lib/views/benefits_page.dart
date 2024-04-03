import 'package:flutter/material.dart';

class BenefitsPage extends StatefulWidget {
  BenefitsPage({super.key});

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Center(child: Text('Home Page')),
      );


  @override
  State<BenefitsPage> createState() => _BenefitsPageState();
}

class _BenefitsPageState extends BenefitsPage {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff3b5998),
        title: Text("Benefits"),
      ),
      body: Column(
        children: [
          Container(
            height: 350.0,
            color: Colors.red,
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(),
                  title: Text("Benefits test"),
                  subtitle: Text("subtitle test"),
                ),
                Expanded(
                  child: Container(
                    color: Colors.blue,
                  )
                ),
                SizedBox(height: 14.0),
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    chldren: <Widget>
                  )
                ])
              ],
            )
          )
        ],
      )


    );
  }
}
