import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class Founder extends StatefulWidget {
  const Founder({Key key}) : super(key: key);

  @override
  State<Founder> createState() => _FounderState();
}

class _FounderState extends State<Founder> {
  String sender;
  String message1;

  sendMail() async {
    String username = 'olanalans12345@gmail.com';
    String password = '123moviestf';

    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username)
      ..recipients.add('olanalans12345@gmail.com')
      // ..ccRecipients.addAll([])
//      ..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'A message from your dating app'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>From: $sender\n --- Message: $message1</h1>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print(e);
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            const SizedBox(height: 50),
            const Text(
              'Creator',
              style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: Colors.black),
            ),
            const SizedBox(height: 20),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1000.0),
                child: const Image(
                  fit: BoxFit.fitWidth,
                  height: 150,
                  width: 150,
                  image: AssetImage('lib/images/id.jpg'),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Lance Olana, 20',
              style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  color: Colors.black),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.location_on_rounded, color: Colors.black, size: 20),
                SizedBox(width: 5),
                Text(
                  'Impasugong, Bukidnon, Philippines',
                  style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                      color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Send me a message!',
              style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: Colors.black),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 120, 0),
              child: TextFormField(
                style: const TextStyle(color: Colors.black),
                onChanged: (_sender) {
                  sender = _sender;
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: const Icon(Icons.person, color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'From',
                  labelStyle: const TextStyle(
                    fontFamily: 'Quicksand',
                    color: Colors.black,
                    fontSize: 12.0,
                  ),
                  hintMaxLines: 10,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: TextFormField(
                maxLines: 5,
                style: const TextStyle(color: Colors.black),
                onChanged: (_message) {
                  message1 = _message;
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'Message',
                  labelStyle: const TextStyle(
                    fontFamily: 'Quicksand',
                    color: Colors.black,
                    fontSize: 12.0,
                  ),
                  hintMaxLines: 10,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(220, 0, 70, 0),
              child: RaisedButton(
                  child: const Text(
                    'Send',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold),
                  ),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  onPressed: () {
                    AwesomeDialog(
                      buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
                      context: context,
                      btnOkColor: Colors.red,
                      dialogType: DialogType.SUCCES,
                      animType: AnimType.BOTTOMSLIDE,
                      title: 'Message Sent!',
                      desc: "",
                      btnOkOnPress: () {
                        sendMail();
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => MyApp()));
                      },
                    ).show();
                  },
                  color: Colors.white),
            ),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
              Image(
                height: 30,
                image: AssetImage('lib/images/facebook.png'),
              ),
              SizedBox(width: 10),
              Text(
                "facebook.com/lance.olana",
                style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.black),
              ),
            ]),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
              Image(
                height: 30,
                image: AssetImage('lib/images/gmail.png'),
              ),
              SizedBox(width: 10),
              Text(
                "olanalans12345@gmail.com",
                style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.black),
              ),
            ]),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
              Image(
                height: 30,
                image: AssetImage('lib/images/contactNumber1.png'),
              ),
              SizedBox(width: 10),
              Text(
                "09090104355",
                style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.black),
              ),
            ]),
            const SizedBox(height: 50),
          ]),
        ));
  }
}
