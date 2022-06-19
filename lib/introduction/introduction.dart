import 'package:flutter/material.dart';
import 'package:flutter_application_1/loading_screen3.dart';
import 'package:flutter_application_1/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Introduction extends StatefulWidget {
  const Introduction({Key key}) : super(key: key);

  @override
  State<Introduction> createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
      children: [
        Container(
          color: Colors.red[400],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Image(
                  height: 300,
                  image: AssetImage('lib/images/introduction_post.PNG'),
                ),
              ),
              const SizedBox(height: 100),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text('POST',
                    style: GoogleFonts.permanentMarker(
                      textStyle: const TextStyle(
                          fontFamily: 'Permanent Marker',
                          fontSize: 60.0,
                          color: Colors.white),
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 100),
                child: Text('Post your best looking pictures!',
                    style: GoogleFonts.permanentMarker(
                      textStyle: const TextStyle(
                          fontFamily: 'Permanent Marker',
                          fontSize: 14.0,
                          color: Colors.white),
                    )),
              ),
              const SizedBox(height: 50),
              Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Text('Swipe  ',
                        style: GoogleFonts.permanentMarker(
                          textStyle: const TextStyle(
                              fontFamily: 'Permanent Marker',
                              fontSize: 14.0,
                              color: Colors.white),
                        )),
                    const Icon(Icons.arrow_forward_rounded,
                        color: Colors.white),
                  ]))
            ],
          ),
        ),
        Container(
          color: Colors.deepPurple[400],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Image(
                  height: 250,
                  image: AssetImage('lib/images/introduction_search.PNG'),
                ),
              ),
              const SizedBox(height: 100),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text('SEARCH',
                    style: GoogleFonts.permanentMarker(
                      textStyle: const TextStyle(
                          fontFamily: 'Permanent Marker',
                          fontSize: 60.0,
                          color: Colors.white),
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 100),
                child: Text('Look for people near or away from you!',
                    style: GoogleFonts.permanentMarker(
                      textStyle: const TextStyle(
                          fontFamily: 'Permanent Marker',
                          fontSize: 14.0,
                          color: Colors.white),
                    )),
              ),
              const SizedBox(height: 50),
              Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Text('Swipe  ',
                        style: GoogleFonts.permanentMarker(
                          textStyle: const TextStyle(
                              fontFamily: 'Permanent Marker',
                              fontSize: 14.0,
                              color: Colors.white),
                        )),
                    const Icon(Icons.arrow_forward_rounded,
                        color: Colors.white),
                  ]))
            ],
          ),
        ),
        Container(
          color: Colors.pink[400],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Image(
                  height: 220,
                  image: AssetImage('lib/images/introduction_message.PNG'),
                ),
              ),
              const SizedBox(height: 100),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text('MESSAGE',
                    style: GoogleFonts.permanentMarker(
                      textStyle: const TextStyle(
                          fontFamily: 'Permanent Marker',
                          fontSize: 60.0,
                          color: Colors.white),
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 100),
                child: Text('Experience real life conversations!',
                    style: GoogleFonts.permanentMarker(
                      textStyle: const TextStyle(
                          fontFamily: 'Permanent Marker',
                          fontSize: 14.0,
                          color: Colors.white),
                    )),
              ),
              const SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();

                      prefs.setInt('count', 0);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoadingScreen3()));
                    },
                    child: Container(
                      child: Row(children: [
                        Text('Get Started',
                            style: GoogleFonts.permanentMarker(
                              textStyle: const TextStyle(
                                  fontFamily: 'Permanent Marker',
                                  fontSize: 14.0,
                                  color: Colors.white),
                            )),
                        const SizedBox(width: 5),
                        const Icon(Icons.arrow_forward_rounded,
                            color: Colors.white)
                      ]),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    ));
  }
}
