import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class chatScreen extends StatelessWidget {
  chatScreen({super.key});

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
      body: Center(child: Text("loggedIn!")),
    );
  }
}
