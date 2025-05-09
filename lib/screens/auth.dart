import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';

class authScreen extends StatefulWidget {
  authScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _authScreen();
  }
}

class _authScreen extends State<authScreen> {
  var _isLogin = true;
  final _formkey = GlobalKey<FormState>();
  final authInstance = FirebaseAuth.instance;
  var _emailEntered = "";
  var _passwordEntered = "";

  void submit() async {
    FocusScope.of(context).unfocus();
    final validValue = _formkey.currentState!.validate();

    if (!validValue) {
      return;
    }

    _formkey.currentState!.save();
    try {
      if (_isLogin) {
        final userCredentials = await authInstance.signInWithEmailAndPassword(
          email: _emailEntered,
          password: _passwordEntered,
        );

        await FirebaseFirestore.instance
            .collection("users")
            .doc(userCredentials.user!.uid)
            .set({
              "username": "to to done ...",
              "email": _emailEntered,
              "image url": "to be done ...",
            });
      } else {
        final userCredentials = await authInstance
            .createUserWithEmailAndPassword(
              email: _emailEntered,
              password: _passwordEntered,
            );
        print('user credentials $userCredentials');
      }
    } on FirebaseAuthException catch (err) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(err.message ?? "authentication error")),
      );
    }
  }

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
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: "Email"),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              !value.contains("@")) {
                            return "Please Enter Valid Email";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _emailEntered = newValue!;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: "Password"),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return "Password must be at least 6 characters";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _passwordEntered = newValue!;
                        },
                      ),
                      SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: submit,
                        child: Text(_isLogin ? "LogIn" : "SignUp"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(
                          _isLogin ? "Create Account" : "Already have account",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
