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

  void submit() {
    var _enterdMessage = _inputController.text;

    if (_enterdMessage.trim().isEmpty) return;

    _inputController.clear();
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
