import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/loading_screen.dart';
import 'package:flutter_application_1/profile/inbox.dart';
import 'package:flutter_application_1/profile/inbox_messages.dart';
import 'package:flutter_application_1/profile/preview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../gallery/gallery.dart';
import '../search/search.dart';
import '../search/search_gender.dart';

import 'package:flutter_application_1/gallery/gallery.dart';

import 'package:flutter_application_1/search/search_gender.dart';

class NewProfile extends StatefulWidget {
  const NewProfile({Key key}) : super(key: key);

  @override
  State<NewProfile> createState() => _NewProfileState();
}

class _NewProfileState extends State<NewProfile> {
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

  String fileName;
  File imageFile;

  String fileName1;
  File imageFile1;

  String province;
  String municipality;

  String gender;

  String profilePicture;
  List interest;

  getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      firstName = prefs.getString('firstName');
      lastName = prefs.getString('lastName');
      age = prefs.getInt('age');
      province = prefs.getString('province');
      municipality = prefs.getString('municipality');
      region = prefs.getString('region');
      gender = prefs.getString('gender');

      instagramAccount = prefs.getString('instagramAccount');
      facebookAccount = prefs.getString('facebookAccount');
      twitterAccount = prefs.getString('twitterAccount');

      contactNumber = prefs.getString('contactNumber');

      height = prefs.getString('height');
      weight = prefs.getString('weight');
      caption = prefs.getString('caption');
      profilePicture = prefs.getString('url');

      image = prefs.getString('url');

      interest = prefs.getStringList('interest');
    });
  }

  showToast() {
    return Fluttertoast.showToast(
        msg: 'CANNOT PROCCEED!',
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT);
  }

  String postImageURL;

  String newTwitter;
  String newInstagram;
  String newFacebook;

  String profileImageURL;

  Future<void> uploadToPost(String inputSource) async {
    final picker = ImagePicker();
    XFile pickedImage;
    try {
      pickedImage = await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920);

      fileName1 = path.basename(pickedImage.path);
      imageFile1 = File(pickedImage.path);

      try {
        showDialog(
          barrierColor: Colors.white,
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: AlertDialog(
                title: Text(
              '         Loading . . .',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Quicksand'),
            )),
          ),
        );

        await storage.ref('post/$region/$gender/$fileName1').putFile(
            imageFile1,
            SettableMetadata(customMetadata: {
              'firstName': firstName,
              'lastName': lastName,
              'age': age.toString(),
              'province': province,
              'municipality': municipality,
              'region': region,
              'gender': gender,
              'instagramAccount': instagramAccount,
              'facebookAccount': facebookAccount,
              'twitterAccount': twitterAccount,
              'contactNumber': contactNumber,
              'height': height,
              'weight': weight,
              'caption': caption,
              'profilePicture': profilePicture,
              'gallery': 'gallery/$region/$gender/$firstName$lastName/',
              'interest': interest.toString(),
            }));

        postImageURL = await firebase_storage.FirebaseStorage.instance
            .ref('post/$region/$gender/$fileName1')
            .getDownloadURL();

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => SingleChildScrollView(
            child: AlertDialog(
              insetPadding: EdgeInsets.all(10),
              title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.location_on_rounded,
                            color: Colors.black, size: 20),
                        const SizedBox(width: 10),
                        Text('$province, $municipality',
                            style: GoogleFonts.permanentMarker(
                              textStyle: const TextStyle(
                                  fontFamily: 'Permanent Marker',
                                  fontSize: 12.0,
                                  color: Colors.black),
                            )),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(postImageURL),
                            fit: BoxFit.cover,
                            alignment: Alignment(-0.3, 0)),
                      ),
                      child: Container(
                        width: 300.0,
                        height: 500.0,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.transparent, Colors.black],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.4, 1]),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('$gender',
                                  style: GoogleFonts.permanentMarker(
                                    textStyle: const TextStyle(
                                        fontFamily: 'Permanent Marker',
                                        fontSize: 12.0,
                                        color: Colors.white),
                                  )),
                              Text('$firstName, $age',
                                  style: GoogleFonts.permanentMarker(
                                    textStyle: const TextStyle(
                                        fontFamily: 'Permanent Marker',
                                        fontSize: 45.0,
                                        color: Colors.white),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
              actions: [
                Center(
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => NewProfile()));
                    },
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2.0),
                    ),
                    color: Colors.black,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
              ],
            ),
          ),
        );

        // Refresh the UI
        setState(() {});
      } on FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  Future<void> _upload(String inputSource) async {
    final picker = ImagePicker();
    XFile pickedImage;
    try {
      pickedImage = await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920);

      fileName = path.basename(pickedImage.path);
      imageFile = File(pickedImage.path);

      try {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: AlertDialog(
                title: Text(
              '         Loading . . .',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Quicksand'),
            )),
          ),
        );
        final prefs = await SharedPreferences.getInstance();
        await firebase_storage.FirebaseStorage.instance
            .ref('profile/$region/$gender1/$firstName, $lastName/$fileName')
            .putFile(imageFile);
        profileImageURL = await firebase_storage.FirebaseStorage.instance
            .ref('profile/$region/$gender1/$firstName, $lastName/$fileName')
            .getDownloadURL();

        setState(() {
          prefs.setString('url', profileImageURL);
        });

        Navigator.of(context).pop();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => NewProfile()));
      } on firebase_storage.FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  Widget genderImage() {
    if (gender1 == 'Male') {
      if (image == null) {
        return InkWell(
          onTap: () async {
            bool result = await InternetConnectionChecker().hasConnection;

            if (result == true) {
              _upload('gallery');
            } else if (result == false) {
              internetToast();
            }
          },
          child: const Image(
            height: 80,
            image: AssetImage('lib/images/male.png'),
          ),
        );
      } else {
        return InkWell(
          onTap: () async {
            bool result = await InternetConnectionChecker().hasConnection;

            if (result == true) {
              _upload('gallery');
            } else if (result == false) {
              internetToast();
            }
          },
          child: CircleAvatar(
            minRadius: 60,
            maxRadius: 60,
            backgroundImage: NetworkImage(image),
            child: Padding(
              padding: EdgeInsets.fromLTRB(80, 80, 0, 0),
              child: Icon(Icons.add_a_photo_rounded,
                  color: Colors.black, size: 30.0),
            ),
          ),
        );
      }
    } else {
      if (image == null) {
        return InkWell(
          onTap: () async {
            bool result = await InternetConnectionChecker().hasConnection;

            if (result == true) {
              _upload('gallery');
            } else if (result == false) {
              internetToast();
            }
          },
          child: const Image(
            height: 80,
            image: AssetImage('lib/images/female.png'),
          ),
        );
      } else {
        return InkWell(
          onTap: () async {
            bool result = await InternetConnectionChecker().hasConnection;

            if (result == true) {
              _upload('gallery');
            } else if (result == false) {
              internetToast();
            }
          },
          child: CircleAvatar(
            minRadius: 60,
            maxRadius: 60,
            backgroundImage: NetworkImage(image),
            child: Padding(
              padding: EdgeInsets.fromLTRB(80, 80, 0, 0),
              child: Icon(Icons.add_a_photo_rounded,
                  color: Colors.black, size: 30.0),
            ),
          ),
        );
      }
    }
  }

  FirebaseStorage storage = FirebaseStorage.instance;

  // Read Image
  Future<List<Map<String, dynamic>>> _loadImages() async {
    List<Map<String, dynamic>> files = [];

    final ListResult result = await storage
        .ref('gallery/$region/$gender/$firstName$lastName/')
        .list();
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

  Future<void> uploadToGallery(String inputSource) async {
    final picker = ImagePicker();
    XFile pickedImage;
    try {
      pickedImage = await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920);

      fileName = path.basename(pickedImage.path);
      imageFile = File(pickedImage.path);

      try {
        await firebase_storage.FirebaseStorage.instance
            .ref('gallery/$region/$gender/$firstName$lastName/$fileName')
            .putFile(imageFile);
        // Uploading the selected image with some custom meta data

        // Refresh the UI
        setState(() {});
      } on FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  internetToast() {
    return Fluttertoast.showToast(
        msg: 'No Internet Connection!',
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Stack(children: [
              Container(
                  height: 180,
                  color: Colors.black,
                  child: Column(children: [
                    Row(children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 50, 0, 0),
                        child: InkWell(
                          onTap: () async {
                            bool result =
                                await InternetConnectionChecker().hasConnection;
                            if (result == true) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Inbox()));
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
                                      Text('Inbox',
                                          style: TextStyle(
                                              fontFamily: 'Quicksand',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.0,
                                              color: Colors.black)),
                                      SizedBox(width: 5),
                                      Icon(
                                        Icons.mail_rounded,
                                        size: 14.0,
                                        color: Colors.black,
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(100, 50, 10, 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: InkWell(
                            onTap: () async {
                              bool result = await InternetConnectionChecker()
                                  .hasConnection;

                              if (result == true) {
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
                                            '✔ Post will be automatically deleted within 24hours after posting.',
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
                                                  uploadToPost('gallery');
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
                            child: Container(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'Post',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.0,
                                              fontFamily: 'Quicksand',
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Icon(
                                          Icons.add,
                                          color: Colors.black,
                                          size: 14.0,
                                        ),
                                      ]),
                                ),
                                color: Colors.white),
                          ),
                        ),
                      ),
                      InkWell(
                          onTap: () async {
                            bool result =
                                await InternetConnectionChecker().hasConnection;
                            if (result == true) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SearchGender()));
                            } else if (result == false) {
                              internetToast();
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 50, 10, 0),
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
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 150, top: 20),
                        child: Text(gender,
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
                          Text('$age',
                              style: const TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontSize: 12.0,
                                  color: Colors.white)),
                          const SizedBox(width: 5),
                          InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          25, 0, 25, 0),
                                      child: TextFormField(
                                        maxLength: 2,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        keyboardType: TextInputType.number,
                                        onChanged: (_age) {
                                          age = int.parse(_age);
                                        },
                                        decoration: const InputDecoration(
                                            labelText: 'Age',
                                            labelStyle: TextStyle(
                                              fontFamily: 'Quicksand',
                                              color: Colors.black,
                                              fontSize: 12.0,
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey))),
                                      ),
                                    ),
                                    actions: [
                                      Center(
                                        child: RaisedButton(
                                          onPressed: () async {
                                            final prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            prefs.setInt('age', age);
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        NewProfile()));
                                          },
                                          child: const Text(
                                            'Continue',
                                            style: TextStyle(
                                                fontFamily: 'Quicksand',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                letterSpacing: 2.0),
                                          ),
                                          color: Colors.white,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: const Icon(Icons.edit,
                                  color: Colors.white, size: 12.0)),
                        ]),
                      ),
                    ]),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 150),
                      child: Text('$firstName $lastName',
                          style: const TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 18.0,
                            color: Colors.white,
                          )),
                    ),
                  ])),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 110, 0, 0),
                child: genderImage(),
              ),
            ]),
            const SizedBox(height: 20),
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
              height: 300,
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
                                  child: Text("$contactNumber",
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
                                    image: AssetImage('lib/images/twitter.png'),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "$twitterAccount",
                                    style: const TextStyle(
                                        fontFamily: 'Quicksand',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(width: 30),
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                25, 0, 25, 0),
                                            child: TextFormField(
                                              style: const TextStyle(
                                                  color: Colors.black),
                                              onChanged: (_newTwitter) {
                                                newTwitter = _newTwitter;
                                              },
                                              decoration: const InputDecoration(
                                                  labelText: 'Twitter',
                                                  labelStyle: TextStyle(
                                                    fontFamily: 'Quicksand',
                                                    color: Colors.black,
                                                    fontSize: 12.0,
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .grey))),
                                            ),
                                          ),
                                          actions: [
                                            Center(
                                              child: RaisedButton(
                                                onPressed: () async {
                                                  final prefs =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  prefs.setString(
                                                      'twitterAccount',
                                                      newTwitter);
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              NewProfile()));
                                                },
                                                child: const Text(
                                                  'Continue',
                                                  style: TextStyle(
                                                      fontFamily: 'Quicksand',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      letterSpacing: 2.0),
                                                ),
                                                color: Colors.black,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20))),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                      size: 15,
                                    ),
                                  )
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
                                        AssetImage('lib/images/instagram.png'),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    "$instagramAccount",
                                    style: const TextStyle(
                                        fontFamily: 'Quicksand',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(width: 30),
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                25, 0, 25, 0),
                                            child: TextFormField(
                                              style: const TextStyle(
                                                  color: Colors.black),
                                              onChanged: (_newInstagram) {
                                                newInstagram = _newInstagram;
                                              },
                                              decoration: const InputDecoration(
                                                  labelText: 'Instagram',
                                                  labelStyle: TextStyle(
                                                    fontFamily: 'Quicksand',
                                                    color: Colors.black,
                                                    fontSize: 12.0,
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .grey))),
                                            ),
                                          ),
                                          actions: [
                                            Center(
                                              child: RaisedButton(
                                                onPressed: () async {
                                                  final prefs =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  prefs.setString(
                                                      'instagramAccount',
                                                      newInstagram);
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              NewProfile()));
                                                },
                                                child: const Text(
                                                  'Continue',
                                                  style: TextStyle(
                                                      fontFamily: 'Quicksand',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      letterSpacing: 2.0),
                                                ),
                                                color: Colors.black,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20))),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                      size: 15,
                                    ),
                                  )
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
                                    "$facebookAccount",
                                    style: const TextStyle(
                                        fontFamily: 'Quicksand',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(width: 30),
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                25, 0, 25, 0),
                                            child: TextFormField(
                                              style: const TextStyle(
                                                  color: Colors.black),
                                              onChanged: (_newFacebook) {
                                                newFacebook = _newFacebook;
                                              },
                                              decoration: const InputDecoration(
                                                  labelText: 'Facebook',
                                                  labelStyle: TextStyle(
                                                    fontFamily: 'Quicksand',
                                                    color: Colors.black,
                                                    fontSize: 12.0,
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .grey))),
                                            ),
                                          ),
                                          actions: [
                                            Center(
                                              child: RaisedButton(
                                                onPressed: () async {
                                                  final prefs =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  prefs.setString(
                                                      'facebookAccount',
                                                      newFacebook);
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              NewProfile()));
                                                },
                                                child: const Text(
                                                  'Continue',
                                                  style: TextStyle(
                                                      fontFamily: 'Quicksand',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      letterSpacing: 2.0),
                                                ),
                                                color: Colors.black,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20))),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                      size: 15,
                                    ),
                                  )
                                ]),
                          ),
                        ),
                      ),
                    ])),
                ListView.builder(
                    itemCount: interest.length,
                    itemBuilder: (context, index) {
                      final interests = interest[index];
                      return ListTile(
                          title: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            color: Colors.white,
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(50, 10, 50, 10),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.check,
                                        color: Colors.black),
                                    const SizedBox(width: 5),
                                    Text(interests,
                                        style: const TextStyle(
                                            fontFamily: 'Quicksand',
                                            fontWeight: FontWeight.bold)),
                                  ]),
                            ),
                          ),
                        ),
                      ));
                    }),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: FutureBuilder(
                          future: _loadImages(),
                          builder: (context,
                              AsyncSnapshot<List<Map<String, dynamic>>>
                                  snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Container(
                                height: 400,
                                width: 300,
                                child: ListView.builder(
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image(
                                            height: 220,
                                            fit: BoxFit.contain,
                                            image: NetworkImage(image['url']),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                      ]),
                                    );
                                  },
                                ),
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(90, 0, 90, 0),
                        child: FlatButton(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Add Photo to Gallery',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Quicksand',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            onPressed: () async {
                              bool result = await InternetConnectionChecker()
                                  .hasConnection;
                              if (result == true) {
                                uploadToGallery('gallery');
                              } else if (result == false) {
                                internetToast();
                              }
                            },
                            color: Colors.white),
                      ),
                    ]),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(90, 10, 90, 0),
              child: FlatButton(
                  child: const Text(
                    'Log out',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold),
                  ),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  onPressed: () {
                    print(lastName);

                    AwesomeDialog(
                      buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
                      context: context,
                      btnOkColor: Colors.red,
                      btnCancelColor: Colors.red,
                      dialogType: DialogType.WARNING,
                      animType: AnimType.BOTTOMSLIDE,
                      title: 'Are you sure you\n want to log out?',
                      desc: '',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () async {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setInt('count', 2);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoadingScreen()));
                      },
                    ).show();
                  },
                  color: Colors.white),
            ),
          ]),
        ),
      ),
    );
  }
}
