import 'package:flutter/material.dart';
import 'package:flutter_application_1/search/locations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchGender extends StatefulWidget {
  const SearchGender({Key key}) : super(key: key);

  @override
  State<SearchGender> createState() => _SearchGenderState();
}

class _SearchGenderState extends State<SearchGender> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 70),
            const Text(
              'Looking for a?',
              style: TextStyle(
                fontFamily: 'Quicksand',
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setString('search_gender', 'Male');
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Locations()));
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
                prefs.setString('search_gender', 'Female');
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Locations()));
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
