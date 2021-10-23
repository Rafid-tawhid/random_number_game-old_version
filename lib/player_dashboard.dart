import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayerDashboard extends StatefulWidget {
  const PlayerDashboard({Key? key}) : super(key: key);

  @override
  _PlayerDashboardState createState() => _PlayerDashboardState();
}

class _PlayerDashboardState extends State<PlayerDashboard> {
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('World Records'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),

        body: StreamBuilder<QuerySnapshot>(
          stream: db.collection('players').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else
              return Container(

                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("img/bg.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                  alignment: Alignment.topLeft,
                child: ListView(
                  children: snapshot.data!.docs.map((doc) {
                    return ListTile(
                      leading: RawMaterialButton(
                        onPressed: () {},
                        elevation: 8.0,
                        fillColor: Colors.white,
                        child: Icon(
                          Icons.wine_bar_rounded,
                          color: Colors.deepOrange,
                          size: 30.0,
                        ),
                        shape: CircleBorder(),
                      ),
                      title: Text(
                        doc['name'],
                        style: TextStyle(fontSize: 20),
                      ),
                      subtitle: Row(

                        children: [
                          Text(
                            doc['title'],style: TextStyle(color: Colors.red),

                          ),
                          Text(
                            doc['date'],style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                      trailing: Text(doc['score'].toString()),
                    );
                  }).toList(),
                ),
              );
          },
        ),
      ),
    );
  }
}
