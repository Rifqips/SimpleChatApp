import 'package:chat_app/widgets/chat/bubble_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessagesWidget extends StatefulWidget {
  const MessagesWidget({super.key});

  @override
  State<MessagesWidget> createState() => _MessagesWidgetState();
}

class _MessagesWidgetState extends State<MessagesWidget> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDots = chatSnapshot.data!.docs;
        return ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          reverse: true,
          itemCount: chatDots.length,
          itemBuilder: (ctx, index) {
            return BubbleWidget(
               message: (chatDots[index].data()! as Map)['text'],
               userName: (chatDots[index].data()! as Map)['username'],
               userImage: (chatDots[index].data()! as Map)['userImage'],
               isMe:(chatDots[index].data()! as Map)['userId'] == user!.uid ,
            );
          },
        );
      },
    );
  }
}
