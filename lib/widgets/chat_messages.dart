import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatefulWidget {
  const ChatMessages({super.key});

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
      stream:
          FirebaseFirestore.instance
              .collection("chat")
              .orderBy("createdAt", descending: false)
              .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text("no messages found yet"));
        }

        if (snapshot.hasError) {
          return Center(child: Text("something went wrong..."));
        }

        final loadedData = snapshot.data!.docs;

        return ListView.builder(
          itemCount: loadedData.length,
          itemBuilder: (context, index) {
            return Text(loadedData[index]["message"]);
          },
        );
      },
    );
  }
}
