import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';
import 'package:flora_app/Config/config.dart';
import 'package:firebase_core/firebase_core.dart';


class AuthenticScreen extends StatefulWidget {
  @override
  _AuthenticScreenState createState() => _AuthenticScreenState();
}

class _AuthenticScreenState extends State<AuthenticScreen> {

  static Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(colors: [Colors.pink, Colors.lightGreenAccent],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0,0.0),
            stops: [0.0,1.0],
            tileMode: TileMode.clamp,
            ),
          ),
          ),
              title: Text(
            "Flora app",
        style: TextStyle(fontSize: 55.0, color: Colors.white, fontFamily: "Signatra.ttf"),),
        centerTitle: true,
        bottom: TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.lock, color: Colors.white,),
              text: "Login",
            ),
            Tab(
              icon: Icon(Icons.person, color: Colors.white,),
              text: "Register",
            ),
          ],
          indicatorColor: Colors.white38,
          indicatorWeight: 5.0,

        ),
        ),
      body: Container(

        decoration: BoxDecoration(
          gradient: new LinearGradient(
            colors: [Colors.pink, Colors.lightGreenAccent],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: TabBarView(
          children: [
            Login(),
            Register(),
          ],
        ),
      ),
      ),
    );
  }
}
