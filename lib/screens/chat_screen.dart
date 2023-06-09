import 'package:chat_app/widgets/chat/chat_input_widget.dart';
import 'package:chat_app/widgets/chat/messages_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Screen'),
        actions: [
          DropdownButton(
            underline: Container(),
            icon: Icon(Icons.more_vert, color: Colors.white),
            items: [
              DropdownMenuItem(
                value: 'Logout',
                child: Row(
                  children: const [
                    Icon(
                      Icons.exit_to_app,
                      color: Colors.black,
                    ),
                    SizedBox(width: 8),
                    Text('Logout'),
                  ],
                ),
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'Logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          children: const [
            Expanded(
              child: MessagesWidget(),
            ),
            ChatInputWidget(),
          ],
        ),
      ),
    );
  }
}
