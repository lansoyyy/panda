import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Message extends StatefulWidget {
  const Message({Key key}) : super(key: key);

  @override
  State<Message> createState() => _MessageState();
}

Future sendMessage() async {
  final docUser =
      FirebaseFirestore.instance.collection('FirstName').doc('LastName');

  final json = {
    'message': 'Message',
  };

  await docUser.set(json);
}

class _MessageState extends State<Message> {
  String firstName_message;
  String lastName_message;
  String sender;
  String message;
  String imageURL;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    final prefs = await SharedPreferences.getInstance();
    firstName_message = prefs.getString('firstName_message');
    lastName_message = prefs.getString('lastName_message');
    imageURL = prefs.getString('sendToURL');
  }

  Widget avatar() {
    if (imageURL == null) {
      return const CircleAvatar(
        minRadius: 40,
        maxRadius: 40,
        backgroundImage: AssetImage('lib/images/male.png'),
      );
    } else {
      CircleAvatar(
        minRadius: 40,
        maxRadius: 40,
        backgroundImage: NetworkImage(imageURL),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [avatar()],
      ),
    );
  }
}
