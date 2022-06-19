import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:neumorphic_container/neumorphic_container.dart';

class LoadingScreen3 extends StatefulWidget {
  @override
  _LoadingScreen3State createState() => _LoadingScreen3State();
}

class _LoadingScreen3State extends State<LoadingScreen3> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 2), () async {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => MyApp()));
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
