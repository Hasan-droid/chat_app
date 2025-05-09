import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _inputController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _inputController.clear();
    super.dispose();
  }

  void submit() async {
    var _enterdMessage = _inputController.text;

    if (_enterdMessage.trim().isEmpty) return;

    _inputController.clear();

    //close anything on screen
    FocusScope.of(context).unfocus();

    final user = await FirebaseAuth.instance.currentUser!;
    final userData =
        await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .get();

    FirebaseFirestore.instance.collection("chat").add({
      "createdAt": Timestamp.now(),
      "message": _enterdMessage,
      "userId": user.uid,
      "image": userData.data()!["image url"],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22, left: 12, right: 12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _inputController,
              decoration: InputDecoration(label: Text("type message")),
            ),
          ),
          IconButton(
            onPressed: submit,
            icon: Icon(
              Icons.send,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
