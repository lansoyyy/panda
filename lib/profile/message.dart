import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Message extends StatefulWidget {
  const Message({Key key}) : super(key: key);

  @override
  State<Message> createState() => _MessageState();
}

String firstName;
String lastName;
String sender;
String message;
String profilePictureURL;

class _MessageState extends State<Message> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    final prefs = await SharedPreferences.getInstance();
    firstName = prefs.getString('firstName');
    lastName = prefs.getString('lastName');
    profilePictureURL = prefs.getString('profilePictureURL');
  }

  final Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection('$firstName$lastName').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.red,
          title: const Text('INBOX',
              style: TextStyle(color: Colors.white, fontFamily: 'Quicksand')),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: users,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Error'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.red,
                ));
              }

              //Navigator.of(context)
              //.push(MaterialPageRoute(builder: (context) => Inbox()));
              final data = snapshot.requireData;
              return ListView.builder(
                  itemCount: snapshot.data?.size ?? 0,
                  itemBuilder: (context, index) {
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: 230,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20, left: 20),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            minRadius: 15,
                                            maxRadius: 15,
                                            backgroundImage: NetworkImage(
                                                data.docs[index]
                                                    ['profilePictureURL']),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            data.docs[index]['sender'],
                                            style: const TextStyle(
                                                fontFamily: 'Quicksand',
                                                fontSize: 12.0,
                                                color: Colors.red),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: SingleChildScrollView(
                                          child: Container(
                                            height: 150,
                                            width: 275,
                                            color: Colors.grey[100],
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20, right: 20),
                                                child: Text(
                                                  data.docs[index]['message'],
                                                  style: const TextStyle(
                                                      fontFamily: 'Quicksand',
                                                      fontSize: 12.0,
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          )
                        ]);
                  });
            }));
  }
}
