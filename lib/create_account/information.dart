import 'package:flutter/material.dart';
import 'package:flutter_application_1/create_account/interest.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Information extends StatefulWidget {
  const Information({Key key}) : super(key: key);

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  int _value = 1;
  String facebookAccount;
  String instagramAccount;
  String twitterAccount;
  String region;
  String province;
  String municipality;

  @override
  Widget build(BuildContext context) {
    showToast1() {
      return Fluttertoast.showToast(
          msg: 'CANNOT PROCEED!',
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 14.0,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT);
    }

    showToast2() {
      return Fluttertoast.showToast(
          msg: 'CANNOT PROCEED! PLEASE SELECT YOUR REGION',
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 14.0,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_SHORT);
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50)),
              child: Container(
                  color: Colors.grey[200],
                  height: 400,
                  width: 500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Social Media's",
                          style: TextStyle(
                              fontFamily: 'Quicksand',
                              color: Colors.black,
                              fontSize: 16.0)),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                        child: TextFormField(
                          style: const TextStyle(color: Colors.black),
                          onChanged: (_facebookAccount) {
                            facebookAccount = _facebookAccount;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Image(
                                height: 20,
                                image: AssetImage('lib/images/facebook.png'),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            labelText: 'Facebook Name',
                            labelStyle: const TextStyle(
                              fontFamily: 'Quicksand',
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                            hintMaxLines: 10,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                        child: TextFormField(
                          style: const TextStyle(color: Colors.black),
                          onChanged: (_instagramAccount) {
                            instagramAccount = _instagramAccount;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Image(
                                height: 20,
                                image: AssetImage('lib/images/instagram.png'),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            labelText: 'Instagram Account',
                            labelStyle: const TextStyle(
                              fontFamily: 'Quicksand',
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            hintMaxLines: 10,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                        child: TextFormField(
                          style: const TextStyle(color: Colors.black),
                          onChanged: (_twitterAccount) {
                            twitterAccount = _twitterAccount;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Image(
                                height: 20,
                                image: AssetImage('lib/images/twitter.png'),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            labelText: 'Twitter Account',
                            labelStyle: const TextStyle(
                              fontFamily: 'Quicksand',
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            hintMaxLines: 10,
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            const SizedBox(height: 10),
            Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.location_on_outlined,
                                color: Colors.black),
                            Text(
                              'Location',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 100, right: 100),
                      child: DropdownButton(
                        iconEnabledColor: Colors.black,
                        isExpanded: true,
                        value: _value,
                        items: [
                          DropdownMenuItem(
                            onTap: () async {
                              region = 'Region 1';
                              final prefs =
                                  await SharedPreferences.getInstance();

                              prefs.setString('region', 'Region 1');
                            },
                            child: Center(
                                child: Row(children: const [
                              Icon(Icons.location_history, color: Colors.black),
                              SizedBox(width: 10),
                              Text("Region 1",
                                  style: TextStyle(
                                    fontFamily: 'Quicksand',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ))
                            ])),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            onTap: () async {
                              region = 'Region 2';
                              final prefs =
                                  await SharedPreferences.getInstance();

                              prefs.setString('region', 'Region 2');
                            },
                            child: Center(
                                child: Row(children: const [
                              Icon(Icons.location_history, color: Colors.black),
                              SizedBox(width: 10),
                              Text("Region 2",
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black))
                            ])),
                            value: 2,
                          ),
                          DropdownMenuItem(
                            onTap: () async {
                              region = 'Region 3';
                              final prefs =
                                  await SharedPreferences.getInstance();

                              prefs.setString('region', 'Region 3');
                            },
                            child: Center(
                                child: Row(children: const [
                              Icon(Icons.location_history, color: Colors.black),
                              SizedBox(width: 10),
                              Text("Region 3",
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black))
                            ])),
                            value: 3,
                          ),
                          DropdownMenuItem(
                            onTap: () async {
                              region = 'Region 4';
                              final prefs =
                                  await SharedPreferences.getInstance();

                              prefs.setString('region', 'Region 4');
                            },
                            child: Center(
                                child: Row(children: const [
                              Icon(Icons.location_history, color: Colors.black),
                              SizedBox(width: 10),
                              Text("Region 4",
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black))
                            ])),
                            value: 4,
                          ),
                          DropdownMenuItem(
                            onTap: () async {
                              region = 'Region 5';
                              final prefs =
                                  await SharedPreferences.getInstance();

                              prefs.setString('region', 'Region 5');
                            },
                            child: Center(
                                child: Row(children: const [
                              Icon(Icons.location_history, color: Colors.black),
                              SizedBox(width: 10),
                              Text("Region 5",
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black))
                            ])),
                            value: 5,
                          ),
                          DropdownMenuItem(
                            onTap: () async {
                              region = 'Region 6';
                              final prefs =
                                  await SharedPreferences.getInstance();

                              prefs.setString('region', 'Region 6');
                            },
                            child: Center(
                                child: Row(children: const [
                              Icon(Icons.location_history, color: Colors.black),
                              SizedBox(width: 10),
                              Text("Region 6",
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black))
                            ])),
                            value: 6,
                          ),
                          DropdownMenuItem(
                            onTap: () async {
                              region = 'Region 7';
                              final prefs =
                                  await SharedPreferences.getInstance();

                              prefs.setString('region', 'Region 7');
                            },
                            child: Center(
                                child: Row(children: const [
                              Icon(Icons.location_history, color: Colors.black),
                              SizedBox(width: 10),
                              Text("Region 7",
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black))
                            ])),
                            value: 7,
                          ),
                          DropdownMenuItem(
                            onTap: () async {
                              region = 'Region 8';
                              final prefs =
                                  await SharedPreferences.getInstance();

                              prefs.setString('region', 'Region 8');
                            },
                            child: Center(
                                child: Row(children: const [
                              Icon(Icons.location_history, color: Colors.black),
                              SizedBox(width: 10),
                              Text("Region 8",
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black))
                            ])),
                            value: 8,
                          ),
                          DropdownMenuItem(
                            onTap: () async {
                              region = 'Region 9';
                              final prefs =
                                  await SharedPreferences.getInstance();

                              prefs.setString('region', 'Region 9');
                            },
                            child: Center(
                                child: Row(children: const [
                              Icon(Icons.location_history, color: Colors.black),
                              SizedBox(width: 10),
                              Text("Region 9",
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black))
                            ])),
                            value: 9,
                          ),
                          DropdownMenuItem(
                            onTap: () async {
                              region = 'Region 10';
                              final prefs =
                                  await SharedPreferences.getInstance();

                              prefs.setString('region', 'Region 10');
                            },
                            child: Center(
                                child: Row(children: const [
                              Icon(Icons.location_history, color: Colors.black),
                              SizedBox(width: 10),
                              Text("Region 10",
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black))
                            ])),
                            value: 10,
                          ),
                          DropdownMenuItem(
                            onTap: () async {
                              region = 'Region 11';
                              final prefs =
                                  await SharedPreferences.getInstance();

                              prefs.setString('region', 'Region 11');
                            },
                            child: Center(
                                child: Row(children: const [
                              Icon(Icons.location_history, color: Colors.black),
                              SizedBox(width: 10),
                              Text("Region 11",
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black))
                            ])),
                            value: 11,
                          ),
                          DropdownMenuItem(
                            onTap: () async {
                              region = 'Region 12';
                              final prefs =
                                  await SharedPreferences.getInstance();

                              prefs.setString('region', 'Region 12');
                            },
                            child: Center(
                                child: Row(children: const [
                              Icon(Icons.location_history, color: Colors.black),
                              SizedBox(width: 10),
                              Text("Region 12",
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black))
                            ])),
                            value: 12,
                          ),
                          DropdownMenuItem(
                            onTap: () async {
                              region = 'Region 13';
                              final prefs =
                                  await SharedPreferences.getInstance();

                              prefs.setString('region', 'Region 13');
                            },
                            child: Center(
                                child: Row(children: const [
                              Icon(Icons.location_history, color: Colors.black),
                              SizedBox(width: 10),
                              Text("Region 13",
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black))
                            ])),
                            value: 13,
                          ),
                          DropdownMenuItem(
                            onTap: () async {
                              region = 'NCR';
                              final prefs =
                                  await SharedPreferences.getInstance();

                              prefs.setString('region', 'NCR');
                            },
                            child: Center(
                                child: Row(children: const [
                              Icon(Icons.location_history, color: Colors.black),
                              SizedBox(width: 10),
                              Text("NCR",
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black))
                            ])),
                            value: 14,
                          ),
                          DropdownMenuItem(
                            onTap: () async {
                              region = 'CAR';
                              final prefs =
                                  await SharedPreferences.getInstance();

                              prefs.setString('region', 'CAR');
                            },
                            child: Center(
                                child: Row(children: const [
                              Icon(Icons.location_history, color: Colors.black),
                              SizedBox(width: 10),
                              Text("CAR",
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black))
                            ])),
                            value: 15,
                          ),
                          DropdownMenuItem(
                            onTap: () async {
                              region = 'MIMAROPA';
                              final prefs =
                                  await SharedPreferences.getInstance();

                              prefs.setString('region', 'MIMAROPA');
                            },
                            child: Center(
                                child: Row(children: const [
                              Icon(Icons.location_history, color: Colors.black),
                              SizedBox(width: 10),
                              Text("MIMAROPA",
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black))
                            ])),
                            value: 16,
                          ),
                          DropdownMenuItem(
                            onTap: () async {
                              region = 'BARMM';
                              final prefs =
                                  await SharedPreferences.getInstance();

                              prefs.setString('region', 'BARMM');
                            },
                            child: Center(
                                child: Row(children: const [
                              Icon(Icons.location_history, color: Colors.black),
                              SizedBox(width: 10),
                              Text("BARMM",
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black))
                            ])),
                            value: 17,
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _value = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.black),
                        onChanged: (_province) {
                          province = _province;
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 1, color: Colors.black),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          labelText: 'Province/City',
                          labelStyle: const TextStyle(
                            fontFamily: 'Quicksand',
                            color: Colors.black,
                            fontSize: 12.0,
                          ),
                          hintMaxLines: 10,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.black),
                        onChanged: (_municipality) {
                          municipality = _municipality;
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 1, color: Colors.black),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          labelText: 'Municipality/Baranggay',
                          labelStyle: const TextStyle(
                            fontFamily: 'Quicksand',
                            color: Colors.black,
                            fontSize: 12.0,
                          ),
                          hintMaxLines: 10,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(90, 20, 90, 0),
                      child: FloatingActionButton(
                          child: const Text(
                            'Continue',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.bold),
                          ),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          onPressed: () async {
                            print(region);
                            if (region == null) {
                              showToast2();
                            } else {
                              try {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setString(
                                    'facebookAccount', facebookAccount);
                                prefs.setString(
                                    'instagramAccount', instagramAccount);
                                prefs.setString(
                                    'twitterAccount', twitterAccount);
                                prefs.setString('province', province);
                                prefs.setString('municipality', municipality);

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: ((context) => Interest())));
                              } catch (e) {
                                showToast1();
                              }
                            }
                          },
                          backgroundColor: Colors.white),
                    ),
                    const SizedBox(height: 50),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
