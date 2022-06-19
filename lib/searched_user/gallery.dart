import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchedUser_Gallery extends StatefulWidget {
  const SearchedUser_Gallery({Key key}) : super(key: key);

  @override
  State<SearchedUser_Gallery> createState() => _SearchedUser_GalleryState();
}

class _SearchedUser_GalleryState extends State<SearchedUser_Gallery> {
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

  String downloadURL;

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
              'age': age.toString(),
              'province': province,
              'municipality': municipality,
              'region': region,
              'gender': gender
            }));

        downloadURL = await firebase_storage.FirebaseStorage.instance
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
                    Text('POSTED!',
                        style: GoogleFonts.permanentMarker(
                          textStyle: const TextStyle(
                              fontFamily: 'Permanent Marker',
                              fontSize: 18.0,
                              color: Colors.red),
                        )),
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
                            image: NetworkImage(downloadURL),
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SearchedUser_Gallery()));
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
        ClipRRect(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
          child: Container(
            height: 570,
            width: 500,
            color: Colors.red,
            child: Column(children: [
              const SizedBox(height: 50),
              const Text(
                'PHOTO GALLERY',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0),
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

                          return Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
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
                      );
                    }

                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
            ]),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.fromLTRB(90, 0, 90, 0),
          child: FlatButton(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Back',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              onPressed: () {
                Navigator.of(context).pop();
              },
              color: Colors.red),
        ),
        const SizedBox(height: 50),
      ]),
    );
  }
}
