import 'package:flutter/material.dart';
import 'package:neumorphic_container/neumorphic_container.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.fromLTRB(80, 10, 80, 10),
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
            const SizedBox(height: 50),
            const Text(
              'Application Name',
              style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w200,
                  fontSize: 10.0,
                  color: Colors.black),
            ),
            const SizedBox(height: 10),
            const Text(
              'PANDA',
              style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  color: Colors.black),
            ),
            const SizedBox(height: 20),
            const Text(
              'Created by',
              style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w200,
                  fontSize: 10.0,
                  color: Colors.black),
            ),
            const SizedBox(height: 10),
            const Text(
              'Lance Olana',
              style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  color: Colors.black),
            ),
            const SizedBox(height: 20),
            const Text(
              'Year created',
              style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w200,
                  fontSize: 10.0,
                  color: Colors.black),
            ),
            const SizedBox(height: 10),
            const Text(
              '2022',
              style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  color: Colors.black),
            ),
            const SizedBox(height: 100),
            const Text(
              'Made using FLUTTER + FIREBASE',
              style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w200,
                  fontSize: 8.0,
                  color: Colors.black),
            ),
            const SizedBox(height: 50),
          ]),
        ));
  }
}
