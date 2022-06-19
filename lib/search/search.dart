import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/profile/inbox.dart';
import 'package:flutter_application_1/profile/inbox_messages.dart';
import 'package:flutter_application_1/profile/message.dart';

import 'package:flutter_application_1/profile/newProfile.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';

import 'package:flutter_application_1/search/search_gender.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';

String search_gender;
String search_region;

FirebaseStorage storage = FirebaseStorage.instance;

internetToast() {
  return Fluttertoast.showToast(
      msg: 'No Internet Connection!',
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 14.0,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT);
}

// Read Image
Future<List<Map<String, dynamic>>> _loadImages() async {
  List<Map<String, dynamic>> files = [];

  final ListResult result =
      await storage.ref('post/$search_region/$search_gender/').list();
  final List<Reference> allFiles = result.items;

  await Future.forEach<Reference>(allFiles, (file) async {
    final String fileUrl = await file.getDownloadURL();
    final FullMetadata fileMeta = await file.getMetadata();
    files.add({
      'url': fileUrl,
      'path': file.fullPath,
      'firstName': fileMeta.customMetadata['firstName'] ?? 'Empty',
      'lastName': fileMeta.customMetadata['lastName'] ?? 'Empty',
      'province': fileMeta.customMetadata['province'] ?? 'Empty',
      'gender': fileMeta.customMetadata['gender'] ?? 'Empty',
      'municipality': fileMeta.customMetadata['municipality'] ?? 'Empty',
      'region': fileMeta.customMetadata['region'] ?? 'Empty',
      'age': fileMeta.customMetadata['age'] ?? 'Empty',
      'instagramAccount':
          fileMeta.customMetadata['instagramAccount'] ?? 'Empty',
      'facebookAccount': fileMeta.customMetadata['facebookAccount'] ?? 'Empty',
      'twitterAccount': fileMeta.customMetadata['twitterAccount'] ?? 'Empty',
      'contactNumber': fileMeta.customMetadata['contactNumber'] ?? 'Empty',
      'height': fileMeta.customMetadata['height'] ?? 'Empty',
      'weight': fileMeta.customMetadata['weight'] ?? 'Empty',
      'caption': fileMeta.customMetadata['caption'] ?? 'Empty',
      'profilePicture': fileMeta.customMetadata['profilePicture'] ?? 'Empty',
      'gallery': fileMeta.customMetadata['gallery'] ?? 'Empty',
      'interest': fileMeta.customMetadata['interest'] ?? 'Empty',
    });
  });
  return files;
}

// Read Image

class Search extends StatefulWidget {
  const Search({Key key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  String province;
  String municipality;
  String gender;
  String firstName;
  int age;
  String region;

  getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      search_gender = prefs.getString('search_gender');
      search_region = prefs.getString('search_region');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: 700,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.fromLTRB(90, 10, 90, 0),
                child: FlatButton(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Icon(Icons.arrow_back_rounded, color: Colors.black),
                          SizedBox(width: 40),
                          Text(
                            'Back',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0),
                          ),
                        ]),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    color: Colors.white),
              ),
              Expanded(
                child: FutureBuilder(
                  future: _loadImages(),
                  builder: (context,
                      AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          final Map<String, dynamic> image =
                              snapshot.data[index];

                          return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.location_on_rounded,
                                        color: Colors.black, size: 20),
                                    const SizedBox(width: 10),
                                    Text(
                                        image['province'] +
                                            ', ' +
                                            image['municipality'],
                                        style: GoogleFonts.permanentMarker(
                                          textStyle: const TextStyle(
                                              fontFamily: 'Permanent Marker',
                                              fontSize: 12.0,
                                              color: Colors.black),
                                        )),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(0),
                                          bottomRight: Radius.circular(0),
                                          topLeft: Radius.circular(0),
                                          topRight: Radius.circular(0)),
                                      image: DecorationImage(
                                          image: NetworkImage(image['url']),
                                          fit: BoxFit.cover,
                                          alignment: const Alignment(-0.3, 0)),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        width: 300.0,
                                        height: 500.0,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: [
                                                Colors.transparent,
                                                Colors.black
                                              ],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              stops: [0.4, 1]),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, bottom: 20),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(image['gender'],
                                                  style: GoogleFonts
                                                      .permanentMarker(
                                                    textStyle: const TextStyle(
                                                        fontFamily:
                                                            'Permanent Marker',
                                                        fontSize: 12.0,
                                                        color: Colors.white),
                                                  )),
                                              Text(
                                                  image['firstName'] +
                                                      ', ' +
                                                      image['age'],
                                                  style: GoogleFonts
                                                      .permanentMarker(
                                                    textStyle: const TextStyle(
                                                        fontFamily:
                                                            'Permanent Marker',
                                                        fontSize: 45.0,
                                                        color: Colors.white),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: InkWell(
                                    onTap: () async {
                                      final prefs =
                                          await SharedPreferences.getInstance();

                                      prefs.setString('searchFirstName',
                                          image['firstName']);
                                      prefs.setString(
                                          'searchLastName', image['lastName']);
                                      prefs.setString('searchFacebook',
                                          image['facebookAccount']);
                                      prefs.setString('searchInstagram',
                                          image['instagramAccount']);
                                      prefs.setString('searchTwitter',
                                          image['twitterAccount']);
                                      prefs.setString(
                                          'searchInterest', image['interest']);
                                      prefs.setString(
                                          'searchGallery', image['gallery']);
                                      prefs.setString('searchContactNumber',
                                          image['contactNumber']);
                                      prefs.setString(
                                          'searchAge', image['age']);

                                      prefs.setString(
                                          'searchGender', image['gender']);

                                      bool result =
                                          await InternetConnectionChecker()
                                              .hasConnection;

                                      if (result == true) {
                                        final prefs = await SharedPreferences
                                            .getInstance();
                                        prefs.setString('receiverFirstName',
                                            image['firstName']);
                                        prefs.setString('receiverLastName',
                                            image['lastName']);
                                        prefs.setString('profilePictureURL',
                                            image['profilePicture']);
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SearchedUser_Profile()));
                                      } else if (result == false) {
                                        internetToast();
                                      }
                                    },
                                    child: Container(
                                      width: 150,
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Icon(Icons.person,
                                                  color: Colors.black,
                                                  size: 18),
                                              SizedBox(width: 5),
                                              Text(
                                                'View Profile',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Quicksand',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16.0),
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Padding(
                                  padding: EdgeInsets.only(left: 25, right: 25),
                                  child: Divider(
                                    height: 20,
                                    thickness: 2,
                                    color: Colors.white,
                                  ),
                                ),
                              ]);
                        },
                      );
                    }

                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 62,
                    color: Colors.white,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(children: [
                            IconButton(
                                iconSize: 30,
                                onPressed: () async {
                                  bool result =
                                      await InternetConnectionChecker()
                                          .hasConnection;

                                  if (result == true) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SearchGender()));
                                  } else if (result == false) {
                                    internetToast();
                                  }
                                },
                                icon: const Icon(
                                  Icons.search_rounded,
                                  color: Colors.black,
                                )),
                            const Text(
                              'Search',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 8.0),
                            ),
                            const SizedBox(height: 5),
                          ]),
                          Column(children: [
                            IconButton(
                              iconSize: 30,
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => NewProfile()));
                              },
                              icon: const Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                            ),
                            const Text(
                              'My Profile',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 8.0),
                            ),
                            const SizedBox(height: 5),
                          ]),
                          Column(children: [
                            IconButton(
                                iconSize: 30,
                                onPressed: () async {
                                  bool result =
                                      await InternetConnectionChecker()
                                          .hasConnection;
                                  if (result == true) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => Inbox()));
                                  } else if (result == false) {
                                    internetToast();
                                  }
                                },
                                icon: const Icon(
                                  Icons.message_rounded,
                                  color: Colors.black,
                                )),
                            const Text(
                              'My Inbox',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 8.0),
                            ),
                            const SizedBox(height: 5),
                          ]),
                        ]),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class SearchedUser_Profile extends StatefulWidget {
  const SearchedUser_Profile({Key key}) : super(key: key);

  @override
  State<SearchedUser_Profile> createState() => _SearchedUser_ProfileState();
}

class _SearchedUser_ProfileState extends State<SearchedUser_Profile> {
  showToast() {
    return Fluttertoast.showToast(
        msg: 'CANNOT PROCCEED!',
        backgroundColor: Colors.black,
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
  String message;
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

  String receiverFirstName;
  String receiverLastName;
  String receiverProfilePicture;
  String galleryURL;
  String searchFirstName;
  String searchLastName;
  String searchFacebook;
  String searchInstagram;
  String searchTwitter;
  String searchInterest;
  String searchGallery;
  String searchContactNumber;
  String searchAge;
  String searchGender;

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
      receiverFirstName = prefs.getString('receiverFirstName');
      receiverLastName = prefs.getString('receiverLastName');
      receiverProfilePicture = prefs.getString('profilePictureURL');
      galleryURL = prefs.getString('galleryURL');
      searchFirstName = prefs.getString('searchFirstName');
      searchLastName = prefs.getString('searchLastName');
      searchFacebook = prefs.getString('searchFacebook');
      searchInstagram = prefs.getString('searchInstagram');
      searchTwitter = prefs.getString('searchTwitter');
      searchInterest = prefs.getString('searchInterest');
      searchGallery = prefs.getString('searchGallery');
      searchContactNumber = prefs.getString('searchContactNumber');
      searchAge = prefs.getString('searchAge');
      searchGender = prefs.getString('searchGender');
    });
  }

  Future<List<Map<String, dynamic>>> _loadImages1() async {
    List<Map<String, dynamic>> files = [];

    final ListResult result = await storage.ref(searchGallery).list();
    final List<Reference> allFiles = result.items;

    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      final FullMetadata fileMeta = await file.getMetadata();
      files.add({
        'url': fileUrl,
        'path': file.fullPath,
      });
    });
    return files;
  }

  String tdata = DateFormat("hh:mm:ss a").format(DateTime.now());

  Future sender() async {
    final docUser = FirebaseFirestore.instance
        .collection('$firstName$lastName')
        .doc('$receiverFirstName$receiverLastName');

    final json = {
      'sender': '$firstName $lastName',
      'time': '',
      'status': '',
      'profilePictureURL': receiverProfilePicture,
      'message': '',
      'personFirstName': '',
      'personLastName': '',
    };

    await docUser.set(json);
  }

  Future receiver() async {
    final docUser = FirebaseFirestore.instance
        .collection('$receiverFirstName$receiverLastName')
        .doc('$firstName$lastName');

    final json = {
      'sender': '$receiverFirstName $receiverLastName',
      'time': '',
      'status': '',
      'profilePictureURL': image,
      'message': '',
      'personFirstName': '',
      'personLastName': '',
    };

    await docUser.set(json);
  }

  @override
  Widget build(BuildContext context) {
    weight ??= '0 kg';
    height ??= "0'0 ft";
    caption ??= 'No caption';
    profilePictureURL ??=
        'https://buzz16.com/wp-content/uploads/2016/12/Popular-Shades-of-Blue-Color-3.jpg';
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              automaticallyImplyLeading: true,
              backgroundColor: Colors.black,
              title: const Text('PROFILE',
                  style:
                      TextStyle(color: Colors.white, fontFamily: 'Quicksand')),
              centerTitle: true,
            ),
            body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Stack(children: [
                Container(
                    height: 130,
                    color: Colors.black,
                    child: Column(children: [
                      Row(children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                          child: InkWell(
                            onTap: () async {
                              bool result = await InternetConnectionChecker()
                                  .hasConnection;

                              if (result == true) {
                                receiver();
                                sender();
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) => Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30, right: 30),
                                    child: AlertDialog(
                                        title: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                          const Icon(Icons.info_rounded,
                                              color: Colors.black),
                                          const SizedBox(height: 10),
                                          const Text(
                                            '✔ Only one message at a time.\n✔ Data is secure and encrypted.\n✔ Messaging System updates in Real Time.',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Quicksand'),
                                          ),
                                          const SizedBox(height: 20),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(0),
                                            child: FlatButton(
                                                color: Colors.black,
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              InboxMessages1()));
                                                },
                                                child: const Text('Continue',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily:
                                                            'Quicksand'))),
                                          )
                                        ])),
                                  ),
                                );
                              } else if (result == false) {
                                internetToast();
                              }
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                color: Colors.white,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: const [
                                        Text('Message',
                                            style: TextStyle(
                                                fontFamily: 'Quicksand',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.0,
                                                color: Colors.black)),
                                        SizedBox(width: 5),
                                      ]),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                            onTap: () async {
                              bool result = await InternetConnectionChecker()
                                  .hasConnection;
                              if (result == true) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SearchGender()));
                              } else if (result == false) {
                                internetToast();
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(180, 0, 10, 0),
                              child: Column(children: const [
                                Icon(
                                  Icons.search_rounded,
                                  color: Colors.white,
                                  size: 25,
                                ),
                                Text('Search',
                                    style: TextStyle(
                                        fontFamily: 'Quicksand',
                                        fontSize: 8.0,
                                        color: Colors.white)),
                              ]),
                            )),
                      ]),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 150, top: 20),
                              child: Text(searchGender,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Quicksand',
                                      fontSize: 12.0)),
                            ),
                            const SizedBox(width: 5),
                            const Padding(
                              padding: EdgeInsets.only(left: 0, top: 20),
                              child: Text("|",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Quicksand',
                                      fontSize: 12.0)),
                            ),
                            const SizedBox(width: 5),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Row(children: [
                                Text(searchAge,
                                    style: const TextStyle(
                                        fontFamily: 'Quicksand',
                                        fontSize: 12.0,
                                        color: Colors.white)),
                                const SizedBox(width: 5),
                              ]),
                            ),
                          ]),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 150),
                        child: Text(searchFirstName + " " + searchLastName,
                            style: const TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 18.0,
                              color: Colors.white,
                            )),
                      ),
                    ])),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 60, 0, 0),
                  child: CircleAvatar(
                    minRadius: 60,
                    maxRadius: 60,
                    backgroundImage: NetworkImage(receiverProfilePicture),
                  ),
                ),
              ]),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 30,
                    color: Colors.white,
                    child: const TabBar(
                      unselectedLabelColor: Colors.black,
                      indicator: BoxDecoration(color: Colors.black),
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Quicksand',
                      ),
                      tabs: [
                        Tab(
                          text: 'Information',
                        ),
                        Tab(
                          text: 'Interest',
                        ),
                        Tab(
                          text: 'Gallery',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 350,
                child: TabBarView(children: [
                  Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(children: [
                              Row(children: const [
                                Text('Contact Number',
                                    style: TextStyle(
                                        fontFamily: 'Quicksand',
                                        fontSize: 10.0,
                                        color: Colors.black)),
                                SizedBox(width: 5),
                              ]),
                              const SizedBox(height: 10),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(30, 5, 30, 5),
                                    child: Text(searchContactNumber,
                                        style: const TextStyle(
                                            fontFamily: 'Quicksand',
                                            fontSize: 24.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ),
                            ]),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Social Media's",
                          style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 40,
                              color: Colors.white,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Image(
                                      height: 30,
                                      image:
                                          AssetImage('lib/images/twitter.png'),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      searchTwitter,
                                      style: const TextStyle(
                                          fontFamily: 'Quicksand',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                          color: Colors.black),
                                    ),
                                    const SizedBox(width: 30),
                                  ]),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 40,
                              color: Colors.white,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Image(
                                      height: 30,
                                      image: AssetImage(
                                          'lib/images/instagram.png'),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      searchInstagram,
                                      style: const TextStyle(
                                          fontFamily: 'Quicksand',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                          color: Colors.black),
                                    ),
                                    const SizedBox(width: 30),
                                  ]),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 40,
                              color: Colors.white,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Image(
                                      height: 30,
                                      image:
                                          AssetImage('lib/images/facebook.png'),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      searchFacebook,
                                      style: const TextStyle(
                                          fontFamily: 'Quicksand',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                          color: Colors.black),
                                    ),
                                    const SizedBox(width: 30),
                                  ]),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(75, 20, 75, 10),
                          child: FlatButton(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'My Profile',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Quicksand',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0),
                                    ),
                                  ]),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => NewProfile()));
                              },
                              color: Colors.white),
                        ),
                      ])),
                  ListTile(
                      title: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                color: Colors.white,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(50, 10, 50, 20),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            searchFirstName +
                                                " is interested in: ",
                                            style: const TextStyle(
                                              fontFamily: 'Quicksand',
                                            )),
                                        const SizedBox(height: 10),
                                        Text(searchInterest,
                                            style: const TextStyle(
                                                fontFamily: 'Quicksand',
                                                fontWeight: FontWeight.bold)),
                                      ]),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(75, 20, 75, 10),
                              child: FlatButton(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'My Profile',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Quicksand',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.0),
                                        ),
                                      ]),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NewProfile()));
                                  },
                                  color: Colors.white),
                            ),
                          ]),
                    ),
                  )),
                  Stack(children: [
                    Positioned(
                      child: FutureBuilder(
                        future: _loadImages1(),
                        builder: (context,
                            AsyncSnapshot<List<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data?.length ?? 0,
                              itemBuilder: (context, index) {
                                final Map<String, dynamic> image =
                                    snapshot.data[index];

                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5, right: 5, top: 5),
                                  child: Column(children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image(
                                        height: 250,
                                        fit: BoxFit.contain,
                                        image: NetworkImage(image['url']),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                  ]),
                                );
                              },
                            );
                          }

                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          );
                        },
                      ),
                    ),
                  ]),
                ]),
              ),
            ])));
  }
}

class InboxMessages1 extends StatefulWidget {
  const InboxMessages1({Key key}) : super(key: key);

  @override
  State<InboxMessages1> createState() => _InboxMessages1State();
}

String firstName;
String lastName;
String senderURL;
String receiverFirstName;
String receiverLastName;
String receiverProfilePicture;
String message;
String personFirstName;
String personLastName;

class _InboxMessages1State extends State<InboxMessages1> {
  @override
  void initState() {
    super.initState();
    getData();
    getProfilePicture();
    getSender();
    getMessage();
    getTime();
    getStatus();
  }

  getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      firstName = prefs.getString('firstName');
      lastName = prefs.getString('lastName');
      senderURL = prefs.getString('url');
      receiverProfilePicture = prefs.getString('profilePictureURL');

      receiverFirstName = prefs.getString('receiverFirstName');

      receiverLastName = prefs.getString('receiverLastName');
      personFirstName = prefs.getString('personFirstName');
      personLastName = prefs.getString('personLastName');
    });
  }

  /* final Stream users = FirebaseFirestore.instance
      .collection('$firstName$lastName')
      .doc('$receiverFirstName$receiverLastName')
      .snapshots();
      */

  var _controller = TextEditingController();

  String profilePictureURL;

  getProfilePicture() async {
    var collection =
        FirebaseFirestore.instance.collection('$firstName$lastName');
    var docSnapshot =
        await collection.doc('$receiverFirstName$receiverLastName').get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data();
      var value = data['profilePictureURL'];

      return profilePictureURL = value;
    }
  }

  String sender;

  getSender() async {
    var collection =
        FirebaseFirestore.instance.collection('$firstName$lastName');
    var docSnapshot =
        await collection.doc('$receiverFirstName$receiverLastName').get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data();
      var value = data['sender'];

      return sender = value;
    }
  }

  String message;
  getMessage() async {
    var collection =
        FirebaseFirestore.instance.collection('$firstName$lastName');
    var docSnapshot =
        await collection.doc('$receiverFirstName$receiverLastName').get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data();
      var value = data['message'];

      return message = value;
    }
  }

  String time;

  getTime() async {
    var collection =
        FirebaseFirestore.instance.collection('$firstName$lastName');
    var docSnapshot =
        await collection.doc('$receiverFirstName$receiverLastName').get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data();
      var value = data['time'];

      return time = value;
    }
  }

  String status;

  getStatus() async {
    var collection =
        FirebaseFirestore.instance.collection('$firstName$lastName');
    var docSnapshot =
        await collection.doc('$receiverFirstName$receiverLastName').get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data();
      var value = data['status'];

      return status = value;
    }
  }

  String tdata = DateFormat("hh:mm:ss a").format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    profilePictureURL ??=
        'https://buzz16.com/wp-content/uploads/2016/12/Popular-Shades-of-Blue-Color-3.jpg';
    message ??= ' ';
    time ??= ' ';
    sender ??= ' ';

    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          title: Row(children: [
            InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SearchedUser_Profile()));
                },
                child:
                    const Icon(Icons.arrow_back_rounded, color: Colors.white)),
            const SizedBox(width: 120),
            const Text('INBOX',
                style: TextStyle(color: Colors.white, fontFamily: 'Quicksand')),
          ]),
          centerTitle: true,
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('$firstName$lastName')
                        .doc('$receiverFirstName$receiverLastName')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Text("Loading");
                      }
                      var userDocument = snapshot.data;
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 100,
                          width: 300,
                          color: Colors.white,
                          child: SingleChildScrollView(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 10),
                                    child: Row(children: [
                                      const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          child: Text('From:',
                                              style: TextStyle(
                                                  fontFamily: 'Quicksand',
                                                  fontSize: 10.0))),
                                      Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(5, 0, 30, 0),
                                          child: Text(userDocument['sender'],
                                              style: const TextStyle(
                                                  fontFamily: 'Quicksand',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10.0))),
                                    ]),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(30, 5, 30, 0),
                                    child: Text(
                                        '" ' + userDocument['message'] + ' "',
                                        style: const TextStyle(
                                            fontFamily: 'Quicksand',
                                            fontSize: 15.0)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 170, top: 10, bottom: 10),
                                    child: Text(userDocument['time'],
                                        style: const TextStyle(
                                          fontFamily: 'Quicksand',
                                          fontSize: 10.0,
                                        )),
                                  ),
                                ]),
                          ),
                        ),
                      );
                    }),
                const SizedBox(height: 10),
                const Image(
                  height: 200,
                  image: AssetImage('lib/images/talking.png'),
                ),
              ])),
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(0), topRight: Radius.circular(0)),
            child: Container(
              height: 80,
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextFormField(
                  controller: _controller,
                  onChanged: (_message) {
                    message = _message;
                  },
                  maxLines: 3,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: InkWell(
                        onTap: () {
                          FirebaseFirestore.instance
                              .collection('$firstName$lastName')
                              .doc('$receiverFirstName$receiverLastName')
                              .update({
                            'message': message,
                            'time': tdata,
                            'sender': firstName + " " + lastName,
                            'status': '',
                            'personFirstName': receiverFirstName,
                            'personLastName': receiverLastName,
                          });
                          FirebaseFirestore.instance
                              .collection('$receiverFirstName$receiverLastName')
                              .doc('$firstName$lastName')
                              .update({
                            'message': message,
                            'time': tdata,
                            'sender': firstName + " " + lastName,
                            'status': 'New Message',
                            'personFirstName': firstName,
                            'personLastName': lastName,
                          });
                          _controller.clear();
                          _controller.clearComposing();
                        },
                        child: const Icon(Icons.send, color: Colors.black)),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: 'Type. . .',
                    hintStyle: const TextStyle(
                      fontFamily: 'Quicksand',
                      color: Colors.black,
                      fontSize: 12.0,
                    ),
                    hintMaxLines: 10,
                  ),
                ),
              ),
            ),
          ),
        ]));
  }
}
