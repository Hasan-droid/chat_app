import 'package:chat_app/widgets/message_buble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatefulWidget {
  const ChatMessages({super.key});

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
      stream:
          FirebaseFirestore.instance
              .collection("chat")
              .orderBy("createdAt", descending: true)
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
          reverse: true,
          itemBuilder: (context, index) {
            //next will take message and message come next to it to render messages
            //that are from the same user , with one image of the send/receiver user as in messenger

            //current message
            final chatMessage = loadedData[index].data();

            //check if there is next message and store it or null
            final nextChatMessage =
                index + 1 < loadedData.length ? loadedData[index + 1] : null;

            //current user's message id
            final currentMessageUserId = chatMessage["userId"];

            //check if there's next message and store it's id or null
            final nextMessageUserId =
                nextChatMessage != null ? nextChatMessage["userId"] : null;

            //is the messages sent from same user
            final nextUserIsSame = currentMessageUserId == nextMessageUserId;

            if (nextUserIsSame) {
              return MessageBubble.next(
                message: chatMessage["message"],
                isMe: currentUser.uid == currentMessageUserId,
              );
            }

            return MessageBubble.first(
              userImage: chatMessage["image"],
              username: chatMessage["userName"],
              message: chatMessage["message"],
              isMe: currentUser.uid == currentMessageUserId,
            );
          },
        );
      },
    );
  }
}
