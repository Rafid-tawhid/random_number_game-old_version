import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/src/iterable_extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:random_number_game/custom_widget/login_controller.dart';
import 'package:random_number_game/main.dart';
import 'package:random_number_game/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'custom_widget/custom_drawer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = "Bot User", userId = "10", city = "Dhaka";
  bool loading= false;
  Map _userObj={};
  TextEditingController nameController = new TextEditingController();
  TextEditingController idController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  final controler = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Your Profile'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: ListView(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ClipRRect(

                        borderRadius: BorderRadius.circular(25.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            'https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg',
                            height: 80.0,
                            width: 80.0,

                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextField(
                          controller: nameController,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            // border: InputBorder.none,
                            hintText: 'ENTER YOUR NAME',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: idController,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            // border: InputBorder.none,
                            hintText: 'ENTER YOUR E-MAIL',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: cityController,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            // border: InputBorder.none,
                            hintText: 'YOUR CITY',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 58),
                        child: RaisedButton(
                          onPressed: () {
                            name = nameController.text;
                            userId = idController.text;
                            city = cityController.text;

                            saveDataToSharedPref(name, userId, city);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MaterialApp(
                                        debugShowCheckedModeBanner: false,
                                        home: Scaffold(
                                          drawer: Drawer(
                                            child: CustomDrawer(),
                                          ),
                                          appBar: AppBar(
                                            title: const Text(
                                              "G-Game",
                                            ),
                                            centerTitle: true,
                                          ),
                                          body: HomePage(),
                                        ),
                                      )),
                            );
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xff374ABE),
                                    Color(0xff64B6FF)
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(30.0)),
                            child: Container(
                              constraints: const BoxConstraints(
                                  maxWidth: 200.0, minHeight: 50.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Save",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      ),


                      Container(
                        child: loading? Column(
                          children: [
                            Image.network(_userObj["picture"]["data"]["url"]),
                            Text(_userObj["name"]),
                            Text(_userObj["email"]),
                          TextButton(child: Text("Logout"),onPressed: (){
                            FacebookAuth.instance.logOut().then((value){
                              setState(() {
                                loading=false;
                                _userObj={};
                              });
                            });
                          },),
                          ],

                        ):Center(
                           child: ElevatedButton(
                             child: Text("Login"),
                             onPressed: () async{
                               FacebookAuth.instance.login(
                                   permissions: ["public_profile","email"]
                               ).then((value){
                                 FacebookAuth.instance.getUserData().then((userData) {
                                   setState(() {
                                     loading=true;
                                     _userObj=userData;
                                   });
                                 });
                               });
                             },
                           ),
                        ),
                      ),

                      Center(
                        child: Obx(() {
                          if (controler.googleAccount.value == null) {
                            return buildSocialIcon();
                          } else {
                            return buildProfileView();
                          }
                        }),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container buildProfileView() {
      // nameController=(controler.googleAccount.value?.displayName ?? '') as TextEditingController;
      // idController=(controler.googleAccount.value?.email ?? '') as TextEditingController;

      return Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage:
                Image.network(controler.googleAccount.value?.photoUrl ?? '')
                    .image,
                radius: 50,
              ),
            ),
            Text(controler.googleAccount.value?.displayName ?? ''),
            Text(controler.googleAccount.value?.email ?? ''),
          ],
        ),
      );


  }

  Container buildSocialIcon() {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,

        children: [
          ElevatedButton(

            onPressed: () {
              controler.login();
            },
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                'G',
                style: TextStyle(fontSize: 26, color: Colors.blue),
              ),
            ),
            style: ElevatedButton.styleFrom(

              shape: CircleBorder(),primary: Colors.white,


            ),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //    // _loginWithFaceBook();
          //     _loginWithFaceBook2();
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.all(6.0),
          //     child: Text(
          //       'f',
          //       style: TextStyle(fontSize: 26, color: Colors.white),
          //     ),
          //   ),
          //   style: ElevatedButton.styleFrom(
          //     shape: CircleBorder(),
          //   ),
          // ),
        ],
      ),
    );
  }

  void saveDataToSharedPref(String name, String userId, String city) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("nm", name);
    sharedPreferences.setString("id", userId);
    sharedPreferences.setString("ct", city);
    print('address saved');
  }

  void _loginWithFaceBook2() async{

    FacebookAuth.instance.login(
        permissions: ["public_profile","email"]
    ).then((value){
      FacebookAuth.instance.getUserData().then((userData) {
        setState(() {
          _userObj=userData;
        });
      });
    });

  }

  // void _loginWithFaceBook()async {
  //   setState(() {
  //     loading=true;
  //   });
  //   try{
  //     final facebookLoginResult=await FacebookAuth.instance.login();
  //     final userData=await FacebookAuth.instance.getUserData();
  //     final facebookAuthCredential=FacebookAuthProvider.credential(facebookLoginResult.accessToken!.token);
  //     await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  //
  //
  //     print(userData.toString());
  //     // await FirebaseFirestore.instance.collection('users').add({
  //     //   'email':userData['email'],
  //     //   'name':userData['name'],
  //     //   'imageUrl':userData['picture']['data']['url'],
  //     //
  //     // });
  //   }
  //   on FirebaseAuthException catch(e)
  //   {
  //     print(e);
  //     showDialog(context: context, builder: (context)=>AlertDialog(
  //       title: Text(e.code),
  //     ));
  //   }
  //   finally{
  //     setState(() {
  //       loading=false;
  //     });
  //   }
  //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
  //
  // }
}
