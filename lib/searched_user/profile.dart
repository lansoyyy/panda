import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_application_1/searched_user/gallery.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SearchedUser_Profile extends StatefulWidget {
  const SearchedUser_Profile({Key key}) : super(key: key);

  @override
  State<SearchedUser_Profile> createState() => _SearchedUser_ProfileState();
}

class _SearchedUser_ProfileState extends State<SearchedUser_Profile> {
  showToast() {
    return Fluttertoast.showToast(
        msg: 'CANNOT PROCCEED!',
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT);
  }

  int age;
  String instagramAccount;
  String facebookAccount;
  String twitterAccount;
  String firstName;
  String lastName;
  String contactNumber;
  String weight;
  String height;
  String caption;
  String gender1;
  String newHeight;
  String newWeight;
  String image;
  String region;
  @override
  void initState() {
    super.initState();
    getData();
  }

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  String fileName;
  File imageFile;

  String downloadURL;

  getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      firstName = prefs.getString('firstName');
      lastName = prefs.getString('lastName');
      instagramAccount = prefs.getString('instagramAccount');
      facebookAccount = prefs.getString('facebookAccount');
      twitterAccount = prefs.getString('twitterAccount');
      age = prefs.getInt('age');
      contactNumber = prefs.getString('contactNumber');
      gender1 = prefs.getString('gender');
      height = prefs.getString('height');
      weight = prefs.getString('weight');
      caption = prefs.getString('caption');
      image = prefs.getString('url');
      region = prefs.getString('region');
    });
  }

  @override
  Widget build(BuildContext context) {
    weight ??= '0 kg';
    height ??= "0'0 ft";
    caption ??= 'No caption';
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50)),
            child: Container(
              height: 450,
              color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SearchedUser_Gallery()));
                          },
                          child: const Icon(
                            Icons.photo_size_select_actual_rounded,
                            color: Colors.white,
                            size: 30,
                          )),
                      const CircleAvatar(
                        minRadius: 40,
                        maxRadius: 40,
                        backgroundImage: AssetImage('lib/images/male.png'),
                      ),
                      InkWell(
                          onTap: () {
                            // MESSAGE
                            // Navigator.of(context).push(MaterialPageRoute(
                            // builder: (context) => SearchGender()));
                          },
                          child: const Icon(
                            Icons.message_rounded,
                            color: Colors.white,
                            size: 30,
                          )),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text('Full Name',
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 10.0,
                          color: Colors.white)),
                  Text('$firstName  $lastName',
                      style: const TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 24.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                    child: Text('" $caption "',
                        style: const TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(children: [
                        const Text('Height (ft)',
                            style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 10.0,
                                color: Colors.white)),
                        Text("$height",
                            style: const TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 24.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ]),
                      Column(children: [
                        const Text('Weight (kg)',
                            style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 10.0,
                                color: Colors.white)),
                        Text("$weight",
                            style: const TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 24.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ]),
                      Column(children: [
                        const Text('Age',
                            style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 10.0,
                                color: Colors.white)),
                        Text("$age",
                            style: const TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 24.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ]),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(children: [
                        const Text('Contact Number',
                            style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 10.0,
                                color: Colors.white)),
                        Text("$contactNumber",
                            style: const TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 24.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ]),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Social Media's",
            style: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                color: Colors.red),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 40,
                color: Colors.white,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Image(
                    height: 30,
                    image: AssetImage('lib/images/twitter.png'),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "$twitterAccount",
                    style: const TextStyle(
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.red),
                  ),
                ]),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 40,
                color: Colors.white,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Image(
                    height: 30,
                    image: AssetImage('lib/images/instagram.png'),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "$instagramAccount",
                    style: const TextStyle(
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.red),
                  ),
                ]),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: 40,
                color: Colors.white,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Image(
                    height: 30,
                    image: AssetImage('lib/images/facebook.png'),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "$facebookAccount",
                    style: const TextStyle(
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.red),
                  ),
                ]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(90, 20, 90, 0),
            child: FlatButton(
                child: const Text(
                  'Back',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.bold),
                ),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                color: Colors.red),
          ),
          const SizedBox(height: 50),
        ]),
      ),
    );
  }
}
