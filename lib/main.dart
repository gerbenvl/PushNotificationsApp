import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class PushMessaging extends StatefulWidget {
  @override
  _PushMessagingState createState() => _PushMessagingState();
}

class _PushMessagingState extends State<PushMessaging> {
  String _homeScreenText = "Waiting for token...";
  String _messageText = "Waiting for messages. You can close the application now, notifications will popup.";
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        setState(() {
          _messageText = "$message";
        });
      },
      onLaunch: (Map<String, dynamic> message) async {
        setState(() {
          _messageText = "$message";
        });
      },
      onResume: (Map<String, dynamic> message) async {
        setState(() {
          _messageText = "$message";
        });
      },
    );

    _firebaseMessaging.requestNotificationPermissions(const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

     _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
        _homeScreenText += "Push Messaging token received. ";
      });
    });

    _firebaseMessaging.subscribeToTopic("All").then((val) {
      _homeScreenText += "Subscribed to All. ";
    });
  }

   @override
  Widget build(BuildContext context) {
    final _biggerFont = const TextStyle(fontSize: 16.0);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Brainiacs Alert'),
        ),
        body: Material(
          child: Column(
            children: <Widget>[
              Row(children: <Widget>[
                Expanded(
                  child: Text(_messageText, style: _biggerFont),
                ),
              ]),
              Spacer(),
              Center(
                child: Text(_homeScreenText),
              ),
            ],
          ),
        ));
  }
}

void main() {
  runApp(
    MaterialApp(
      home: PushMessaging(),
    ),
  );
}
