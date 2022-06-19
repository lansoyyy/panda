import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/introduction/introduction.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/profile/newProfile.dart';
import 'package:flutter_application_1/profile/profile.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5), () async {
      final prefs = await SharedPreferences.getInstance();

      if (prefs.getInt('count') == 1) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => NewProfile()));
      } else if (prefs.getInt('count') == 2) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MyApp()));
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Introduction()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PANDA',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(80, 0, 80, 10),
                      child: NeumorphicContainer(
                        height: 150,
                        width: 300,
                        borderRadius: 10,
                        primaryColor: Color(0xfff0f0f0),
                        curvature: Curvature.flat,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Image(
                            height: 20,
                            image: AssetImage('lib/images/pandalogo.png'),
                          ),
                        ),
                      ),
                    ),
                    const Image(
                      height: 40,
                      image: AssetImage('lib/images/pandatext.png'),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
