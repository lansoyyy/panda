import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/profile/newProfile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key key}) : super(key: key);

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  String fileName;
  File imageFile;

  String fileName1;
  File imageFile1;

  String firstName;
  int age;
  String province;
  String municipality;
  String region;
  String gender;
  String lastName;
  String instagramAccount;
  String facebookAccount;
  String twitterAccount;
  String contactNumber;
  String height;
  String weight;
  String caption;
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
    });
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

  String postImageURL;

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
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Gallery()));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        const SizedBox(height: 50),
        const Text(
          'PHOTO GALLERY',
          style: TextStyle(
              color: Colors.red,
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.bold,
              fontSize: 16.0),
        ),
        Expanded(
          child: FutureBuilder(
            future: _loadImages(),
            builder:
                (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  height: 400,
                  width: 300,
                  child: ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      final Map<String, dynamic> image = snapshot.data[index];

                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: Column(children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image(
                              fit: BoxFit.contain,
                              image: NetworkImage(image['url']),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ]),
                      );
                    },
                  ),
                );
              }

              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.fromLTRB(90, 10, 90, 0),
          child: FlatButton(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Add Photo to Gallery',
                      style: TextStyle(
                          color: Colors.red,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              onPressed: () {
                uploadToGallery('gallery');
              },
              color: Colors.white),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(90, 0, 90, 0),
          child: FlatButton(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Profile',
                      style: TextStyle(
                          color: Colors.red,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => NewProfile()));
              },
              color: Colors.white),
        ),
        const SizedBox(height: 50),
      ]),
    );
  }
}
