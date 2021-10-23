import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
        appBar: AppBar(title: Text('World Records'),centerTitle: true ,  leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),),
        // body: Container(
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //       image: AssetImage(
        //           "img/bg.jpg"),
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        //   child: Column(
        //     children: [
        //       ListTile(
        //         title: Text('Rafid'),
        //         leading: RawMaterialButton(
        //           onPressed: () {},
        //           elevation: 18.0,
        //
        //           fillColor: Colors.white,
        //           child: Icon(
        //             Icons.wine_bar_rounded,
        //             color: Colors.deepOrange,
        //             size: 30.0,
        //           ),
        //           padding: EdgeInsets.all(15.0),
        //           shape: CircleBorder(),
        //         ),
        //         subtitle: Row(
        //           mainAxisSize: MainAxisSize.min,
        //           mainAxisAlignment: MainAxisAlignment.spaceAround,
        //           children: [
        //             Text('Legend',style: TextStyle(color: Colors.red),),
        //             Text('11 jul 2021',style: TextStyle(color: Colors.blue),),
        //           ],
        //         ),
        //         trailing: Text('522'),
        //       ),
        //
        //     ],
        //   ),
        // ),

        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('players').snapshots(),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
          {
            if(!snapshot.hasData)
              {
                return Center(child: Text("No Values"));
              }
            else
              
          },
        ),
      ),
    );
  }
}
