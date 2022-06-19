import 'package:flutter/material.dart';
import 'package:flutter_application_1/create_account/create_user.dart';
import 'package:flutter_application_1/loading_screen.dart';
import 'package:flutter_application_1/loading_screen2.dart';
import 'package:flutter_application_1/more/aboutUs.dart';
import 'package:flutter_application_1/more/founder.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:neumorphic_container/neumorphic_container.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: LoadingScreen()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  internetToast() {
    return Fluttertoast.showToast(
        msg: 'No Internet Connection!',
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT);
  }

  showToast() {
    return Fluttertoast.showToast(
        msg: 'INVALID ACCOUNT!',
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT);
  }

  showToast1() {
    return Fluttertoast.showToast(
        msg: 'INVALID USERNAME!',
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT);
  }

  String username;
  String password;
  String newUsername;

  bool _sec = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PANDA',
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            SingleChildScrollView(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50)),
                child: Container(
                  height: 580,
                  color: Colors.grey[200],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(80, 10, 80, 10),
                        child: NeumorphicContainer(
                          height: 150,
                          width: 50,
                          borderRadius: 10,
                          primaryColor: Color(0xfff0f0f0),
                          curvature: Curvature.flat,
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Image(
                              height: 20,
                              image: AssetImage('lib/images/pandalogo.png'),
                            ),
                          ),
                        ),
                      ),
                      const Image(
                        height: 40,
                        image: AssetImage('lib/images/pandatext.png'),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                        child: TextFormField(
                          style: const TextStyle(color: Colors.black),
                          onChanged: (_username) {
                            username = _username;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            suffixIcon:
                                const Icon(Icons.person, color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            labelText: 'Username',
                            labelStyle: const TextStyle(
                              fontFamily: 'Quicksand',
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                            hintMaxLines: 10,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                        child: TextFormField(
                          style: const TextStyle(color: Colors.black),
                          onChanged: (_password) {
                            password = _password;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.remove_red_eye,
                                  color: Colors.black),
                              onPressed: () {
                                setState(() {
                                  _sec = !_sec;
                                });
                              },
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            labelText: 'Password',
                            labelStyle: const TextStyle(
                              fontFamily: 'Quicksand',
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                            hintMaxLines: 10,
                          ),
                          obscureText: _sec,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 50),
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) => AlertDialog(
                                    title: TextFormField(
                                      onChanged: (_username) {
                                        newUsername = _username;
                                      },
                                      decoration: const InputDecoration(
                                          labelText: 'Enter Username',
                                          labelStyle: TextStyle(
                                            fontFamily: 'Quicksand',
                                            color: Colors.black,
                                            fontSize: 12.0,
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey))),
                                    ),
                                    backgroundColor: Colors.grey[200],
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    actions: [
                                      Center(
                                        child: FlatButton(
                                          color: Colors.white,
                                          onPressed: () async {
                                            final prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            if (prefs.getString('firstName') ==
                                                newUsername) {
                                              String username =
                                                  prefs.getString('firstName');
                                              String password =
                                                  prefs.getString('password');
                                              AwesomeDialog(
                                                borderSide: BorderSide(
                                                    color: Colors.red,
                                                    width: 1),
                                                buttonsBorderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(2)),
                                                context: context,
                                                btnOkColor: Colors.red,
                                                dialogType: DialogType.SUCCES,
                                                animType: AnimType.BOTTOMSLIDE,
                                                title: 'Account Details',
                                                desc:
                                                    'Username: $username\nPassword: $password',
                                                btnOkOnPress: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MyApp()));
                                                },
                                              ).show();
                                            } else {
                                              showToast1();
                                            }
                                          },
                                          child: const Text(
                                            'Continue',
                                            style: TextStyle(
                                                fontFamily: 'Quicksand',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                letterSpacing: 2.0),
                                          ),
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                        ),
                                      )
                                    ]),
                              );
                            },
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  color: Colors.black,
                                  fontSize: 12.0),
                            ),
                          ),
                        ),
                      ]),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(90, 0, 90, 0),
                        child: RaisedButton(
                            child: const Text(
                              'Log in',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.bold),
                            ),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            onPressed: () async {
                              final prefs =
                                  await SharedPreferences.getInstance();

                              prefs.setInt('count', 1);

                              bool result = await InternetConnectionChecker()
                                  .hasConnection;

                              if (result == true) {
                                if (username == prefs.getString('firstName') &&
                                    password == prefs.getString('password')) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => LoadingScreen2()));
                                } else {
                                  showToast();
                                }
                              } else if (result == false) {
                                internetToast();
                              }
                            },
                            color: Colors.white),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.only(left: 100, right: 100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Founder()));
                                },
                                child: const Icon(Icons.person,
                                    color: Colors.black, size: 30)),
                            const SizedBox(width: 20),
                            InkWell(
                              onTap: () {
                                AwesomeDialog(
                                  showCloseIcon: true,
                                  buttonsBorderRadius:
                                      BorderRadius.all(Radius.circular(2)),
                                  context: context,
                                  dialogType: DialogType.INFO_REVERSED,
                                  animType: AnimType.BOTTOMSLIDE,
                                  title: 'Terms and Conditions',
                                  desc:
                                      'By signing up, you agree to the Terms and Conditions of this platform.\n\n It means you trust us to keep your personal information.',
                                ).show();
                              },
                              child: const Icon(Icons.list_rounded,
                                  color: Colors.black, size: 30),
                            ),
                            const SizedBox(width: 20),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AboutUs()));
                              },
                              child: const Icon(Icons.info_outline_rounded,
                                  color: Colors.black, size: 30),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 75),
                  child: Text(
                    "Doesn't have an account?",
                    style: TextStyle(fontFamily: 'Quicksand'),
                  ),
                ),
                const SizedBox(width: 5),
                InkWell(
                  onTap: () async {
                    bool result =
                        await InternetConnectionChecker().hasConnection;

                    if (result == true) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CreateUser()));
                    } else if (result == false) {
                      internetToast();
                    }
                  },
                  child: const Text(
                    "Create now",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Quicksand'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            const Text("All Right Reserved.",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 8.0,
                    fontFamily: 'Quicksand')),
            const SizedBox(height: 50),
          ]),
        ),
      ),
    );
  }
}
