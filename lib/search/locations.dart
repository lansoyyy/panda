import 'package:flutter/material.dart';
import 'package:flutter_application_1/search/search.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Locations extends StatefulWidget {
  const Locations({Key key}) : super(key: key);

  @override
  State<Locations> createState() => _LocationsState();
}

class _LocationsState extends State<Locations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Text(
              'Looking for a match in',
              style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.black),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setString('search_region', 'Region 1');
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Search()));
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    height: 200,
                    color: Colors.red,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Image(
                                  height: 30,
                                  image: AssetImage('lib/images/location.png'),
                                ),
                                Text(
                                  'Region 1',
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 44.0,
                                      color: Colors.white),
                                ),
                              ]),
                        ),
                        const SizedBox(height: 10),
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            child: Text(
                              'Ilocos Norte, Ilocos Sur, La Union, Pangasinan',
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w100,
                                  fontSize: 12.0,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setString('search_region', 'Region 2');
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Search()));
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    height: 200,
                    color: Colors.blue,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Image(
                                  height: 30,
                                  image: AssetImage('lib/images/location.png'),
                                ),
                                Text(
                                  'Region 2',
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 44.0,
                                      color: Colors.white),
                                ),
                              ]),
                        ),
                        const SizedBox(height: 10),
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            child: Text(
                              'Batanes, Cagayan, Isabela, Nueva Vizcaya, Quirino',
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w100,
                                  fontSize: 12.0,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                onTap:
                () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setString('search_region', 'Region 3');
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Search()));
                };
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    height: 200,
                    color: Colors.amber,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Image(
                                  height: 30,
                                  image: AssetImage('lib/images/location.png'),
                                ),
                                Text(
                                  'Region 3',
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 44.0,
                                      color: Colors.white),
                                ),
                              ]),
                        ),
                        const SizedBox(height: 10),
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            child: Text(
                              'Aurora, Bataan, Bulacan, Nueva Ecija, Pampanga, Tarlac, Zambales',
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w100,
                                  fontSize: 12.0,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setString('search_region', 'Region 4');
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Search()));
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    height: 200,
                    color: Colors.green,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Image(
                                  height: 30,
                                  image: AssetImage('lib/images/location.png'),
                                ),
                                Text(
                                  'Region 4',
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 44.0,
                                      color: Colors.white),
                                ),
                              ]),
                        ),
                        const SizedBox(height: 10),
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            child: Text(
                              'Batangas, Cavite, Laguna, Quezon, Rizal',
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w100,
                                  fontSize: 12.0,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setString('search_region', 'Region 5');
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Search()));
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    height: 200,
                    color: Colors.pink,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Image(
                                  height: 30,
                                  image: AssetImage('lib/images/location.png'),
                                ),
                                Text(
                                  'Region 5',
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 44.0,
                                      color: Colors.white),
                                ),
                              ]),
                        ),
                        const SizedBox(height: 10),
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            child: Text(
                              'Albay, Camarines Norte, Camarines Sur, Catanduanes, Masbate, Sorsogon',
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w100,
                                  fontSize: 12.0,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setString('search_region', 'Region 6');
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Search()));
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    height: 200,
                    color: Colors.orange,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Image(
                                  height: 30,
                                  image: AssetImage('lib/images/location.png'),
                                ),
                                Text(
                                  'Region 6',
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 44.0,
                                      color: Colors.white),
                                ),
                              ]),
                        ),
                        const SizedBox(height: 10),
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            child: Text(
                              'Aklan, Antique, Capiz, Guimaras, Iloilo, Negros Occidental',
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w100,
                                  fontSize: 12.0,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setString('search_region', 'Region 7');
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Search()));
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    height: 200,
                    color: Colors.teal,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Image(
                                  height: 30,
                                  image: AssetImage('lib/images/location.png'),
                                ),
                                Text(
                                  'Region 7',
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 44.0,
                                      color: Colors.white),
                                ),
                              ]),
                        ),
                        const SizedBox(height: 10),
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            child: Text(
                              'Bohol, Cebu, Negros Oriental, Siquijor',
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w100,
                                  fontSize: 12.0,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setString('search_region', 'Region 8');
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Search()));
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    height: 200,
                    color: Colors.grey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Image(
                                  height: 30,
                                  image: AssetImage('lib/images/location.png'),
                                ),
                                Text(
                                  'Region 8',
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 44.0,
                                      color: Colors.white),
                                ),
                              ]),
                        ),
                        const SizedBox(height: 10),
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            child: Text(
                              'Biliran, Eastern Samar, Leyte, Northern Samar, Samar, Southern Leyte',
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w100,
                                  fontSize: 12.0,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setString('search_region', 'Region 9');
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Search()));
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    height: 200,
                    color: Colors.purple,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Image(
                                  height: 30,
                                  image: AssetImage('lib/images/location.png'),
                                ),
                                Text(
                                  'Region 9',
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 44.0,
                                      color: Colors.white),
                                ),
                              ]),
                        ),
                        const SizedBox(height: 10),
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            child: Text(
                              'Zamboanga del Norte, Zamboanga del Sur, Zamboanga Sibugay',
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w100,
                                  fontSize: 12.0,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setString('search_region', 'Region 10');
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Search()));
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    height: 200,
                    color: Colors.brown,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Image(
                                  height: 30,
                                  image: AssetImage('lib/images/location.png'),
                                ),
                                Text(
                                  'Region 10',
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 44.0,
                                      color: Colors.white),
                                ),
                              ]),
                        ),
                        const SizedBox(height: 10),
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            child: Text(
                              'Bukidnon, Camiguin, Lanao del Norte, Misamis Occidental, Misamis Oriental',
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w100,
                                  fontSize: 12.0,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setString('search_region', 'Region 11');
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Search()));
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    height: 200,
                    color: Colors.redAccent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Image(
                                  height: 30,
                                  image: AssetImage('lib/images/location.png'),
                                ),
                                Text(
                                  'Region 11',
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 44.0,
                                      color: Colors.white),
                                ),
                              ]),
                        ),
                        const SizedBox(height: 10),
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            child: Text(
                              'Davao de Oro, Davao del Norte, Davao del Sur, Davao Occidental, Davao Oriental',
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w100,
                                  fontSize: 12.0,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setString('search_region', 'Region 12');
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Search()));
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    height: 200,
                    color: Colors.blueGrey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Image(
                                  height: 30,
                                  image: AssetImage('lib/images/location.png'),
                                ),
                                Text(
                                  'Region 12',
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 44.0,
                                      color: Colors.white),
                                ),
                              ]),
                        ),
                        const SizedBox(height: 10),
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            child: Text(
                              'Cotabato, Sarangani, South Cotabato, Sultan Kudarat',
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w100,
                                  fontSize: 12.0,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setString('search_region', 'Region 13');
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Search()));
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    height: 200,
                    color: Colors.pinkAccent[700],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Image(
                                  height: 30,
                                  image: AssetImage('lib/images/location.png'),
                                ),
                                Text(
                                  'Region 13',
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 44.0,
                                      color: Colors.white),
                                ),
                              ]),
                        ),
                        const SizedBox(height: 10),
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            child: Text(
                              'Agusan del Norte, Agusan del Sur, Dinagat Islands, Surigao del Norte, Surigao del Sur',
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w100,
                                  fontSize: 12.0,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setString('search_region', 'NCR');
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Search()));
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    height: 200,
                    color: Colors.yellow[700],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Image(
                                  height: 30,
                                  image: AssetImage('lib/images/location.png'),
                                ),
                                Text(
                                  'NCR',
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 44.0,
                                      color: Colors.white),
                                ),
                              ]),
                        ),
                        const SizedBox(height: 10),
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            child: Text(
                              'Caloocan, Las Piñas, Makati, Malabon, Mandaluyong, Manila, Marikina, Muntinlupa.',
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w100,
                                  fontSize: 12.0,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setString('search_region', 'CAR');
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Search()));
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    height: 200,
                    color: Colors.cyan[700],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Image(
                                  height: 30,
                                  image: AssetImage('lib/images/location.png'),
                                ),
                                Text(
                                  'CAR',
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 44.0,
                                      color: Colors.white),
                                ),
                              ]),
                        ),
                        const SizedBox(height: 10),
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            child: Text(
                              'Abra, Apayao, Benguet, Ifugao, Kalinga, Mountain Province',
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w100,
                                  fontSize: 12.0,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setString('search_region', 'MIMAROPA');
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Search()));
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    height: 200,
                    color: Colors.grey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Image(
                                  height: 30,
                                  image: AssetImage('lib/images/location.png'),
                                ),
                                Text(
                                  'MIMAROPA',
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 44.0,
                                      color: Colors.white),
                                ),
                              ]),
                        ),
                        const SizedBox(height: 10),
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            child: Text(
                              'Marinduque, Occidental Mindoro, Oriental Mindoro, Palawan, Romblon',
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w100,
                                  fontSize: 12.0,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setString('search_region', 'BARMM');
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Search()));
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    height: 200,
                    color: Colors.greenAccent[700],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Image(
                                  height: 30,
                                  image: AssetImage('lib/images/location.png'),
                                ),
                                Text(
                                  'BARMM',
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 44.0,
                                      color: Colors.white),
                                ),
                              ]),
                        ),
                        const SizedBox(height: 10),
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            child: Text(
                              'Basilan, Lanao del Sur, Maguindanao, Sulu, Tawi-Tawi',
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w100,
                                  fontSize: 12.0,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
