import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class PushMessaging extends StatefulWidget {
  @override
  _PushMessagingState createState() => _PushMessagingState();
}

class _PushMessagingState extends State<PushMessaging> {
  String _messageText = "Waiting for message...";
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        setState(() {
          _messageText = message;
        });
      },
      onLaunch: (Map<String, dynamic> message) async {
        setState(() {
          _messageText = message;
        });
      },
      onResume: (Map<String, dynamic> message) async {
        setState(() {
          _messageText = message;
        });
      },
    );

    _firebaseMessaging.requestNotificationPermissions(const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

    _firebaseMessaging.subscribeToTopic("All");
  }

  @override
  Widget build(BuildContext context) {
    final _biggerFont = const TextStyle(fontSize: 16.0);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Brainiacs Azure App Insights Monitor'),
        ),
        body: Material(
          child: Column(
            children: <Widget>[
              Row(children: <Widget>[
                Expanded(
                  child: Text(_messageText, style: _biggerFont),
                ),
              ]),
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
