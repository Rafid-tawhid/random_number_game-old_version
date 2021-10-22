import 'package:flutter/material.dart';
class PlayerDashboard extends StatefulWidget {
  const PlayerDashboard({Key? key}) : super(key: key);

  @override
  _PlayerDashboardState createState() => _PlayerDashboardState();
}

class _PlayerDashboardState extends State<PlayerDashboard> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('World Records'),centerTitle: true,),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "img/bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              ListTile(
                title: Text('Rafid'),
                leading: RawMaterialButton(
                  onPressed: () {},
                  elevation: 18.0,

                  fillColor: Colors.white,
                  child: Icon(
                    Icons.wine_bar_rounded,
                    color: Colors.deepOrange,
                    size: 30.0,
                  ),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                ),
                subtitle: Text('Legend'+' 11 jul 2021'),
                trailing: Text('522'),
              ),
              ListTile(
                title: Text('Rafid'),
                leading: RawMaterialButton(
                  onPressed: () {},
                  elevation: 18.0,
                  fillColor: Colors.white,
                  child: Icon(
                    Icons.wine_bar_rounded,
                    color: Colors.deepOrange,
                    size: 30.0,
                  ),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                ),
                subtitle: Text('Legend'+' 11 jul 2021'),
                trailing: Text('522'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
