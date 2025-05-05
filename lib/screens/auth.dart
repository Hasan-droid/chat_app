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
  var _isLogin = true;
  final _formkey = GlobalKey<FormState>();
  var _emailEntered = "";
  var _passwordEntered = "";

  void submit() {
    final validValue = _formkey.currentState!.validate();

    if (validValue) {
      _formkey.currentState!.save();
      print('_enteredPassword $_emailEntered');
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
                          if (value == null || value.trim().isEmpty || !value.contains("@")) {
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
                          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(_isLogin ? "Create Account" : "Already have account"),
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
