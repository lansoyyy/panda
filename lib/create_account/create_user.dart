import 'package:flutter/material.dart';
import 'package:flutter_application_1/create_account/gender.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({Key key}) : super(key: key);

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  String firstName;
  String lastName;
  String contactNumber;
  String password;
  String confirmPassword;
  int age;

  showToast() {
    return Fluttertoast.showToast(
        msg: 'INVALID PASSWORD!',
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT);
  }

  showToast1() {
    return Fluttertoast.showToast(
        msg: 'CANNOT PROCEED!',
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT);
  }

  bool _sec = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50)),
              child: Container(
                  color: Colors.grey[200],
                  height: 600,
                  width: 500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Personal Information",
                          style: TextStyle(
                              fontFamily: 'Quicksand',
                              color: Colors.black,
                              fontSize: 16.0)),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                        child: TextFormField(
                          style: const TextStyle(color: Colors.black),
                          onChanged: (_firstName) {
                            firstName = _firstName;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon:
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
                            labelText: 'First Name',
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
                          onChanged: (_lastName) {
                            lastName = _lastName;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon:
                                const Icon(Icons.person, color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            labelText: 'Last Name',
                            labelStyle: const TextStyle(
                              fontFamily: 'Quicksand',
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(15),
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
                          onChanged: (_contactNumber) {
                            contactNumber = _contactNumber;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon:
                                const Icon(Icons.phone, color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            labelText: 'Contact Number',
                            labelStyle: const TextStyle(
                              fontFamily: 'Quicksand',
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            hintMaxLines: 10,
                          ),
                          maxLength: 11,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                        child: TextFormField(
                          style: const TextStyle(color: Colors.black),
                          obscureText: _sec,
                          onChanged: (_password) {
                            password = _password;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: IconButton(
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
                            labelText: 'Password',
                            labelStyle: const TextStyle(
                              fontFamily: 'Quicksand',
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(15),
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
                          obscureText: _sec,
                          onChanged: (_confirmPassword) {
                            confirmPassword = _confirmPassword;
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: IconButton(
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
                            labelText: 'Confirm Password',
                            labelStyle: const TextStyle(
                              fontFamily: 'Quicksand',
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            hintMaxLines: 10,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(100, 0, 100, 0),
                        child: TextFormField(
                          style: const TextStyle(color: Colors.black),
                          onChanged: (_age) {
                            age = int.parse(_age);
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon:
                                const Icon(Icons.person, color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            labelText: 'Age',
                            labelStyle: const TextStyle(
                              fontFamily: 'Quicksand',
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            hintMaxLines: 10,
                          ),
                          maxLength: 2,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  )),
            ),
            const SizedBox(height: 20),
            Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(90, 10, 90, 0),
                      child: FloatingActionButton(
                          child: const Text(
                            'Continue',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.bold),
                          ),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          onPressed: () async {
                            if (password != confirmPassword) {
                              showToast();
                            } else {
                              try {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setString('firstName', firstName);
                                prefs.setString('lastName', lastName);
                                prefs.setString('contactNumber', contactNumber);
                                prefs.setString('password', password);
                                prefs.setString(
                                    'confirmPassword', confirmPassword);
                                prefs.setInt('age', age);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Gender()));
                              } catch (e) {
                                showToast1();
                              }
                            }
                          },
                          backgroundColor: Colors.white),
                    ),
                    const SizedBox(height: 50),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
