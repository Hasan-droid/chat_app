import "package:flutter/material.dart";

class authScreen extends StatefulWidget {
  authScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _authScreen();
  }
}

class _authScreen extends State<authScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 20),
              width: 200,
              height: 200,
              child: Image(image: AssetImage('assets/images/chat.png')),
            ),
            Card(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: "Email"),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                    ),
                    TextFormField(decoration: InputDecoration(labelText: "Password"), obscureText: true),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
