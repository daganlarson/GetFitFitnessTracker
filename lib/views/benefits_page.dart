import 'package:flutter/material.dart';

class BenefitsPage extends StatefulWidget {
  const BenefitsPage({super.key});

  @override
  State<BenefitsPage> createState() => _BenefitsPageState();
}

class _BenefitsPageState extends State<BenefitsPage> {

  late Container myContainer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff3b5998),
        title: Text("Benefits"),
      ),
      body: ListView.builder(
        itemCount: 12,
        itemBuilder: (context, index) =>CardItem(child: myContainer),
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
    super.key, required Container child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
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
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://static.vecteezy.com/system/resources/thumbnails/005/024/692/small/man-workout-in-gym-for-healthy-llifestyle-free-vector.jpg"),
                    fit: BoxFit.cover,
                  )
                ),
              )
            ),
            SizedBox(height: 14.0),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.thumb_up, color: Colors.grey),
                  SizedBox(width: 8.0),
                  Text("Like"),
                ]
              )
            ]),
            SizedBox(height: 12.0),
          ],
        )
      )
            );
  }
}
