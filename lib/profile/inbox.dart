import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/profile/inbox_messages.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class Inbox extends StatefulWidget {
  const Inbox({Key key}) : super(key: key);

  @override
  State<Inbox> createState() => _InboxState();
}

String firstName;
String lastName;

class _InboxState extends State<Inbox> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  final Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection('$firstName$lastName').snapshots();

  getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      firstName = prefs.getString('firstName');
      lastName = prefs.getString('lastName');
    });
  }

  String person;

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
            const SizedBox(width: 120),
            const Text('INBOX',
                style: TextStyle(color: Colors.white, fontFamily: 'Quicksand')),
          ]),
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
                  color: Colors.black,
                ));
              }

              //Navigator.of(context)
              //.push(MaterialPageRoute(builder: (context) => Inbox()));
              final data = snapshot.requireData;
              return ListView.builder(
                  itemCount: snapshot.data?.size ?? 0,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: InkWell(
                                onTap: () async {
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  bool result =
                                      await InternetConnectionChecker()
                                          .hasConnection;

                                  if (result == true) {
                                    prefs.setString('personFirstName',
                                        data.docs[index]['personFirstName']);
                                    prefs.setString('personLastName',
                                        data.docs[index]['personLastName']);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                InboxMessages()));
                                  } else if (result == false) {
                                    internetToast();
                                  }
                                },
                                child: Container(
                                  height: 75,
                                  color: Colors.white,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(data.docs[index]['status'],
                                            style: const TextStyle(
                                                fontFamily: 'Quicksand',
                                                fontSize: 8.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black)),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: CircleAvatar(
                                                  minRadius: 20,
                                                  maxRadius: 20,
                                                  backgroundImage: NetworkImage(
                                                      data.docs[index][
                                                          'profilePictureURL']),
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            50, 50, 0, 0),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Text(
                                                  data.docs[index]
                                                          ['personFirstName'] +
                                                      " " +
                                                      data.docs[index]
                                                          ['personLastName'],
                                                  style: const TextStyle(
                                                      fontFamily: 'Quicksand',
                                                      fontSize: 18.0,
                                                      color: Colors.black)),
                                              const SizedBox(width: 50),
                                              const Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                color: Colors.black,
                                              )
                                            ]),
                                      ]),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    );
                  });
            }));
  }
}
