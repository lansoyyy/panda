import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/profile/inbox.dart';
import 'package:flutter_application_1/profile/messages/bubble.dart';
import 'package:flutter_application_1/search/search.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InboxMessages extends StatefulWidget {
  const InboxMessages({Key key}) : super(key: key);

  @override
  State<InboxMessages> createState() => _InboxMessagesState();
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

class _InboxMessagesState extends State<InboxMessages> {
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

  internetToast() {
    return Fluttertoast.showToast(
        msg: 'No Internet Connection!',
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT);
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
                  Navigator.of(context).pop();
                },
                child:
                    const Icon(Icons.arrow_back_rounded, color: Colors.white)),
            const SizedBox(width: 100),
            const Text('MESSAGE',
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
                        .doc('$personFirstName$personLastName')
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
                  height: 180,
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
                        onTap: () async {
                          bool result =
                              await InternetConnectionChecker().hasConnection;

                          if (result == true) {
                            FirebaseFirestore.instance
                                .collection('$firstName$lastName')
                                .doc('$personFirstName$personLastName')
                                .update({
                              'message': message,
                              'time': tdata,
                              'sender': firstName + " " + lastName,
                              'status': '',
                              'personFirstName': personFirstName,
                              'personLastName': personLastName,
                            });
                            FirebaseFirestore.instance
                                .collection('$personFirstName$personLastName')
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
                          } else if (result == false) {
                            internetToast();
                          }
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
