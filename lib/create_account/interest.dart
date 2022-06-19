import 'package:flutter/material.dart';
import 'package:flutter_application_1/loading_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Interest extends StatefulWidget {
  const Interest({Key key}) : super(key: key);

  @override
  State<Interest> createState() => _InterestState();
}

class _InterestState extends State<Interest> {
  showToast() {
    return Fluttertoast.showToast(
        msg: 'CATEGORY ADDED!',
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT);
  }

  showToast1() {
    return Fluttertoast.showToast(
        msg: 'CANNOT PROCCEED! PICK ATLEAST ONE INTEREST',
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT);
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

  List interest = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          InkWell(
            onTap: () {
              showToast();
              interest.add('Arts and Media');
            },
            child: Container(
              height: 200,
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Arts and\n Media',
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                        fontSize: 32.0,
                        color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  const Image(
                    height: 100,
                    image: AssetImage('lib/images/arts.png'),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              showToast();
              interest.add('Books and Literature');
            },
            child: Container(
              height: 200,
              color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Books and\n Literature',
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                        fontSize: 28.0,
                        color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  Image(
                    height: 100,
                    image: AssetImage('lib/images/books.png'),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              showToast();
              interest.add('Cooking');
            },
            child: Container(
              height: 200,
              color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Cooking',
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                        fontSize: 28.0,
                        color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  Image(
                    height: 100,
                    image: AssetImage('lib/images/cooking.png'),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              showToast();
              interest.add('Entertainment');
            },
            child: Container(
              height: 200,
              color: Colors.teal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Entertainment',
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                        fontSize: 28.0,
                        color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  Image(
                    height: 100,
                    image: AssetImage('lib/images/entertainment.png'),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              showToast();
              interest.add('Health and Lifestyle');
            },
            child: Container(
              height: 200,
              color: Colors.green,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Health and\n Lifestyle',
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                        fontSize: 28.0,
                        color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  Image(
                    height: 100,
                    image: AssetImage('lib/images/health.png'),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              showToast();
              interest.add('Travel');
            },
            child: Container(
              height: 200,
              color: Colors.purple,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Travel',
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                        fontSize: 28.0,
                        color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  Image(
                    height: 100,
                    image: AssetImage('lib/images/travel.png'),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              showToast();
              interest.add('Sports');
            },
            child: Container(
              height: 200,
              color: Colors.orange,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Sports',
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                        fontSize: 28.0,
                        color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  Image(
                    height: 100,
                    image: AssetImage('lib/images/sports.png'),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              showToast();
              interest.add('Style and Fashion');
            },
            child: Container(
              height: 200,
              color: Colors.pink,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Style and\n Fashion',
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                        fontSize: 28.0,
                        color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  Image(
                    height: 100,
                    image: AssetImage('lib/images/style.png'),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            bool result = await InternetConnectionChecker().hasConnection;

            if (result == true) {
              if (interest.isEmpty) {
                showToast1();
              } else {
                final prefs = await SharedPreferences.getInstance();
                String username = prefs.getString('firstName');
                String password = prefs.getString('password');
                AwesomeDialog(
                  buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
                  context: context,
                  btnOkColor: Colors.red,
                  dialogType: DialogType.SUCCES,
                  animType: AnimType.BOTTOMSLIDE,
                  title: 'Account Succesfully Created',
                  desc: 'Username: $username\nPassword: $password',
                  btnOkOnPress: () {
                    prefs.setStringList('interest', interest.cast<String>());
                    prefs.setString('url', '');
                    prefs.setString('height', '');
                    prefs.setString('weight', '');
                    prefs.setString('caption', '');
                    prefs.setInt('count', 2);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LoadingScreen()));
                  },
                ).show();
              }
            } else if (result == false) {
              internetToast();
            }
          },
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.check,
            color: Colors.black,
            size: 40,
          )),
    );
  }
}
