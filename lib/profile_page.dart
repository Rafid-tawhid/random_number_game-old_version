import 'package:flutter/material.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('Your Profile'),centerTitle: true ,  leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),),
        body: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS785biEGWYfQ3kCbvts_QRuNPn7IJpvovN4A&usqp=CAU',
                    height: 80.0,
                    width: 80.0,
                  ),
                ),
                Text('Rafid Tawhid',style: TextStyle(fontSize: 22,color: Colors.blue),textAlign: TextAlign.justify,),
              ],
            )
          ],
        ),
      ),
    );
  }
}
