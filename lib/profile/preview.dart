import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/loading_screen.dart';
import 'package:flutter_application_1/profile/inbox.dart';
import 'package:flutter_application_1/profile/newProfile.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../gallery/gallery.dart';
import '../search/search.dart';
import '../search/search_gender.dart';

import 'dart:io';

import 'package:flutter_application_1/gallery/gallery.dart';

import 'package:flutter_application_1/search/search_gender.dart';

class NewPreview extends StatefulWidget {
  const NewPreview({Key key}) : super(key: key);

  @override
  State<NewPreview> createState() => _NewPreviewState();
}

class _NewPreviewState extends State<NewPreview> {
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
              'gallery': 'gallery/$region/$gender/$firstName$lastName/'
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
                        const Image(
                          height: 20,
                          image: AssetImage('lib/images/location.png'),
                        ),
                        const SizedBox(width: 10),
                        Text('$province, $municipality',
                            style: GoogleFonts.permanentMarker(
                              textStyle: const TextStyle(
                                  fontFamily: 'Permanent Marker',
                                  fontSize: 12.0,
                                  color: Colors.red),
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
                              stops: [0.7, 1]),
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
                                        color: Colors.red),
                                  )),
                              Text('$firstName, $age',
                                  style: GoogleFonts.permanentMarker(
                                    textStyle: const TextStyle(
                                        fontFamily: 'Permanent Marker',
                                        fontSize: 45.0,
                                        color: Colors.red),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
              actions: [
                Center(
                  child: RaisedButton(
                    onPressed: () {},
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
          onTap: () {},
          child: const Image(
            height: 80,
            image: AssetImage('lib/images/male.png'),
          ),
        );
      } else {
        return InkWell(
          onTap: () {},
          child: CircleAvatar(
            minRadius: 60,
            maxRadius: 60,
            backgroundImage: NetworkImage(image),
            child: Padding(
              padding: EdgeInsets.fromLTRB(50, 50, 0, 0),
            ),
          ),
        );
      }
    } else {
      if (image == null) {
        return InkWell(
          onTap: () {},
          child: const Image(
            height: 80,
            image: AssetImage('lib/images/female.png'),
          ),
        );
      } else {
        return InkWell(
          onTap: () {},
          child: CircleAvatar(
            minRadius: 60,
            maxRadius: 60,
            backgroundImage: NetworkImage(image),
            child: Padding(
              padding: EdgeInsets.fromLTRB(50, 50, 0, 0),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.black,
          title: const Text('PREVIEW',
              style: TextStyle(color: Colors.white, fontFamily: 'Quicksand')),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            const SizedBox(height: 30),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              InkWell(
                onTap: () {},
                child: Column(children: const [
                  Icon(
                    Icons.message_rounded,
                    color: Colors.black,
                    size: 30,
                  ),
                  Text('Message',
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 8.0,
                          color: Colors.black)),
                ]),
              ),
              genderImage(),
              InkWell(
                  onTap: () {},
                  child: Column(children: const [
                    Icon(
                      Icons.search_rounded,
                      color: Colors.black,
                      size: 30,
                    ),
                    Text('Search',
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 8.0,
                            color: Colors.black)),
                  ])),
            ]),
            const SizedBox(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('$firstName $lastName , ',
                  style: const TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 24.0,
                    color: Colors.black,
                  )),
              Row(children: [
                Text('$age',
                    style: const TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 20.0,
                        color: Colors.black)),
                const SizedBox(width: 5),
              ]),
            ]),
            const Padding(
              padding: EdgeInsets.only(left: 25, right: 25),
              child: Divider(
                height: 20,
                thickness: 2,
                color: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: FlatButton(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.image,
                              color: Colors.black,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Gallery',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      onPressed: () {},
                      color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 30),
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
                  const SizedBox(height: 5),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
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
            const SizedBox(height: 20),
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
                          image: AssetImage('lib/images/instagram.png'),
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
                          image: AssetImage('lib/images/facebook.png'),
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
                      ]),
                ),
              ),
            ),
            const SizedBox(height: 50),
          ]),
        ));
  }
}
