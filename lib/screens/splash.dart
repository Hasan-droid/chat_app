import 'package:flutter/material.dart';

class splashScreen extends StatelessWidget {
  splashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(appBar: AppBar(title: Text("chat")), body: Center(child: Text("...loading!")));
  }
}
