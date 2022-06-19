import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/gallery/gallery.dart';
import 'package:flutter_application_1/loading_screen.dart';
import 'package:flutter_application_1/profile/inbox.dart';
import 'package:flutter_application_1/profile/newProfile.dart';
import 'package:flutter_application_1/profile/preview.dart';
import 'package:flutter_application_1/search/search_gender.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:path/path.dart' as path;

import 'package:flutter/foundation.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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

  String profileImageURL;

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
                  color: Colors.red,
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
            .push(MaterialPageRoute(builder: (context) => Profile()));
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

  Widget gender() {
    if (gender1 == 'Male') {
      if (image == null) {
        return InkWell(
          onTap: () {
            _upload('gallery');
          },
          child: const Image(
            height: 80,
            image: AssetImage('lib/images/male.png'),
          ),
        );
      } else {
        return InkWell(
          onTap: () {
            _upload('gallery');
          },
          child: CircleAvatar(
            minRadius: 40,
            maxRadius: 40,
            backgroundImage: NetworkImage(image),
            child: const Padding(
              padding: EdgeInsets.fromLTRB(50, 50, 0, 0),
              child: Icon(Icons.add_a_photo_rounded,
                  color: Colors.white, size: 25.0),
            ),
          ),
        );
      }
    } else {
      if (image == null) {
        return InkWell(
          onTap: () {
            _upload('gallery');
          },
          child: const Image(
            height: 80,
            image: AssetImage('lib/images/female.png'),
          ),
        );
      } else {
        return InkWell(
          onTap: () {
            _upload('gallery');
          },
          child: CircleAvatar(
            minRadius: 40,
            maxRadius: 40,
            backgroundImage: NetworkImage(image),
            child: const Padding(
              padding: EdgeInsets.fromLTRB(50, 50, 0, 0),
              child: Icon(Icons.add_a_photo_rounded,
                  color: Colors.white, size: 25.0),
            ),
          ),
        );
      }
    }
  }

  String newTwitter;
  String newInstagram;
  String newFacebook;

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
              height: 500,
              color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => NewProfile()));
                    },
                    child: Column(children: const [
                      Icon(
                        Icons.person_pin_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                      Text('Preview Profile',
                          style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 8.0,
                              color: Colors.white)),
                    ]),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Gallery()));
                          },
                          child: Column(children: const [
                            Icon(
                              Icons.photo_size_select_actual_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                            Text('My Gallery',
                                style: TextStyle(
                                    fontFamily: 'Quicksand',
                                    fontSize: 8.0,
                                    color: Colors.white)),
                          ])),
                      gender(),
                      InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SearchGender()));
                          },
                          child: Column(children: const [
                            Icon(
                              Icons.search_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                            Text('Search',
                                style: TextStyle(
                                    fontFamily: 'Quicksand',
                                    fontSize: 8.0,
                                    color: Colors.white)),
                          ])),
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
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text('Bio',
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 10.0,
                            color: Colors.white)),
                    const SizedBox(width: 5),
                    InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) => AlertDialog(
                              title: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(25, 0, 25, 0),
                                child: TextFormField(
                                  style: const TextStyle(color: Colors.red),
                                  onChanged: (_caption) {
                                    caption = _caption;
                                  },
                                  decoration: const InputDecoration(
                                      labelText: 'Bio',
                                      labelStyle: TextStyle(
                                        fontFamily: 'Quicksand',
                                        color: Colors.red,
                                        fontSize: 12.0,
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.grey))),
                                ),
                              ),
                              actions: [
                                Center(
                                  child: RaisedButton(
                                    onPressed: () async {
                                      final prefs =
                                          await SharedPreferences.getInstance();
                                      if (caption.isEmpty) {
                                        showToast();
                                      } else {
                                        prefs.setString('caption', caption);
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Profile()));
                                      }
                                    },
                                    child: const Text(
                                      'Continue',
                                      style: TextStyle(
                                          fontFamily: 'Quicksand',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          letterSpacing: 2.0),
                                    ),
                                    color: Colors.red,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        child:
                            Icon(Icons.edit, color: Colors.white, size: 12.0)),
                  ]),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                    child: Text('$caption',
                        style: const TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(children: [
                        Row(children: [
                          const Text('Height (ft)',
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontSize: 10.0,
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
                                        style:
                                            const TextStyle(color: Colors.red),
                                        keyboardType: TextInputType.number,
                                        onChanged: (_height) {
                                          height = _height;
                                        },
                                        decoration: const InputDecoration(
                                            labelText: 'Height',
                                            labelStyle: TextStyle(
                                              fontFamily: 'Quicksand',
                                              color: Colors.red,
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
                                            prefs.setString('height', height);
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Profile()));
                                          },
                                          child: const Text(
                                            'Continue',
                                            style: TextStyle(
                                                fontFamily: 'Quicksand',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                letterSpacing: 2.0),
                                          ),
                                          color: Colors.red,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Icon(Icons.edit,
                                  color: Colors.white, size: 12.0)),
                        ]),
                        Text("$height",
                            style: const TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 24.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ]),
                      Column(children: [
                        Row(children: [
                          const Text('Age',
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontSize: 10.0,
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
                                        style:
                                            const TextStyle(color: Colors.red),
                                        keyboardType: TextInputType.number,
                                        onChanged: (_age) {
                                          age = int.parse(_age);
                                        },
                                        decoration: const InputDecoration(
                                            labelText: 'Age',
                                            labelStyle: TextStyle(
                                              fontFamily: 'Quicksand',
                                              color: Colors.red,
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
                                                        Profile()));
                                          },
                                          child: const Text(
                                            'Continue',
                                            style: TextStyle(
                                                fontFamily: 'Quicksand',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                letterSpacing: 2.0),
                                          ),
                                          color: Colors.red,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Icon(Icons.edit,
                                  color: Colors.white, size: 12.0)),
                        ]),
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
                        Row(children: [
                          const Text('Contact Number',
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontSize: 10.0,
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
                                        keyboardType: TextInputType.number,
                                        style:
                                            const TextStyle(color: Colors.red),
                                        onChanged: (_contactNumber) {
                                          contactNumber = _contactNumber;
                                        },
                                        decoration: const InputDecoration(
                                            labelText: 'Contact Number',
                                            labelStyle: TextStyle(
                                              fontFamily: 'Quicksand',
                                              color: Colors.red,
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
                                            if (caption.isEmpty) {
                                              showToast();
                                            } else {
                                              prefs.setString('contactNumber',
                                                  contactNumber);
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Profile()));
                                            }
                                          },
                                          child: const Text(
                                            'Continue',
                                            style: TextStyle(
                                                fontFamily: 'Quicksand',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                letterSpacing: 2.0),
                                          ),
                                          color: Colors.red,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Icon(Icons.edit,
                                  color: Colors.white, size: 12.0)),
                        ]),
                        Text("$contactNumber",
                            style: const TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 24.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ]),
                    ],
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Inbox()));
                    },
                    child: Column(children: const [
                      Icon(
                        Icons.message_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                      Text('Inbox',
                          style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 8.0,
                              color: Colors.white)),
                    ]),
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
              borderRadius: BorderRadius.circular(10),
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
                  const SizedBox(width: 30),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) => AlertDialog(
                          title: Padding(
                            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                            child: TextFormField(
                              style: const TextStyle(color: Colors.red),
                              onChanged: (_newTwitter) {
                                newTwitter = _newTwitter;
                              },
                              decoration: const InputDecoration(
                                  labelText: 'Twitter',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Quicksand',
                                    color: Colors.red,
                                    fontSize: 12.0,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey))),
                            ),
                          ),
                          actions: [
                            Center(
                              child: RaisedButton(
                                onPressed: () async {
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString('twitterAccount', newTwitter);
                                },
                                child: const Text(
                                  'Continue',
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      letterSpacing: 2.0),
                                ),
                                color: Colors.red,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.edit,
                      color: Colors.red,
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
                  const SizedBox(width: 30),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) => AlertDialog(
                          title: Padding(
                            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                            child: TextFormField(
                              style: const TextStyle(color: Colors.red),
                              onChanged: (_newInstagram) {
                                newInstagram = _newInstagram;
                              },
                              decoration: const InputDecoration(
                                  labelText: 'Instagram',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Quicksand',
                                    color: Colors.red,
                                    fontSize: 12.0,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey))),
                            ),
                          ),
                          actions: [
                            Center(
                              child: RaisedButton(
                                onPressed: () async {
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString(
                                      'instagramAccount', newInstagram);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Profile()));
                                },
                                child: const Text(
                                  'Continue',
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      letterSpacing: 2.0),
                                ),
                                color: Colors.red,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.edit,
                      color: Colors.red,
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
                  const SizedBox(width: 30),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) => AlertDialog(
                          title: Padding(
                            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                            child: TextFormField(
                              style: const TextStyle(color: Colors.red),
                              onChanged: (_newFacebook) {
                                newFacebook = _newFacebook;
                              },
                              decoration: const InputDecoration(
                                  labelText: 'Facebook',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Quicksand',
                                    color: Colors.red,
                                    fontSize: 12.0,
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey))),
                            ),
                          ),
                          actions: [
                            Center(
                              child: RaisedButton(
                                onPressed: () async {
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setString(
                                      'facebookAccount', newFacebook);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Profile()));
                                },
                                child: const Text(
                                  'Continue',
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      letterSpacing: 2.0),
                                ),
                                color: Colors.red,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.edit,
                      color: Colors.red,
                      size: 15,
                    ),
                  )
                ]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(90, 20, 90, 0),
            child: FlatButton(
                child: const Text(
                  'Log out',
                  style: TextStyle(
                      color: Colors.white,
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
                color: Colors.red),
          ),
          const SizedBox(height: 50),
        ]),
      ),
    );
  }
}
