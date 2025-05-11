import 'package:chat_app/widgets/chat_messages.dart';
import 'package:chat_app/widgets/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class chatScreen extends StatefulWidget {
  chatScreen({super.key});

  @override
  State<chatScreen> createState() => _chatScreenState();
}

class _chatScreenState extends State<chatScreen> {
  //notifications should only received to loggedIn users , which this screen is
  void setPoshNotifications() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission();

    //get the address of the user device
    final token = await fcm.getToken();

    print("virtual token $token");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setPoshNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final firbaseAuth = FirebaseAuth.instance;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("chat"),
        actions: [
          IconButton(
            onPressed: () {
              firbaseAuth.signOut();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(children: [Expanded(child: ChatMessages()), NewMessage()]),
    );
  }
}
