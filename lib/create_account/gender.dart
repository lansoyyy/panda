import 'package:flutter/material.dart';
import 'package:flutter_application_1/create_account/information.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Gender extends StatefulWidget {
  const Gender({Key key}) : super(key: key);

  @override
  State<Gender> createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  String gender;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50),
            InkWell(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                gender = 'Male';
                prefs.setString('gender', gender);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Information()));
              },
              child: const Image(
                height: 200,
                image: AssetImage('lib/images/male.png'),
              ),
            ),
            const SizedBox(height: 30),
            InkWell(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                gender = 'Female';
                prefs.setString('gender', gender);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Information()));
              },
              child: const Image(
                height: 200,
                image: AssetImage('lib/images/female.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
