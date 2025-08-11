import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/chat_bloc.dart';
import 'chat_page.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(LoadChatsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        // A modern, clean AppBar style.
        systemOverlayStyle: SystemUiOverlayStyle.dark, 
        backgroundColor: Colors.white,
        elevation: 1.0,
        title: const Text(
          'Chats',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            );
          }

          if (state is ChatsLoaded) {
            final chats = state.chats;
            if (chats.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.message_outlined, size: 80, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'No Chats Yet',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                     SizedBox(height: 8),
                    Text(
                      'Start a conversation to see it here.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
              itemCount: chats.length,
              separatorBuilder: (context, index) => const SizedBox(height: 4), 
              itemBuilder: (context, index) {
                final chat = chats[index];
                final contactName = chat.user1.name != state.loggedUser.name
                    ? chat.user1.name
                    : chat.user2.name;

                return Card(
                  elevation: 2.0,
                  shadowColor: Colors.black.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    leading: CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.blue.shade400,
                      child: Text(
                        contactName[0].toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    title: Text(
                      contactName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Tap to see the conversation...', 
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    trailing: Icon(
                      Icons.chevron_right_rounded, 
                      color: Colors.grey.shade400,
                      size: 28,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatPage(
                            contactName: contactName,
                            chatId: chat.id,
                            loggedUser: state.loggedUser.name,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }

          if (state is ChatError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.redAccent, size: 60),
                    const SizedBox(height: 16),
                    const Text(
                      'Something Went Wrong',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  ],
                ),
              ),
            );
          }
          // Default empty state.
          return const SizedBox.shrink();
        },
      ),
    );
  }
}