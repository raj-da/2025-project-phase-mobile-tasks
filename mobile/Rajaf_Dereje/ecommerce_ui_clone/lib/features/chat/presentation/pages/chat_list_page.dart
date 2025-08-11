import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Required for SystemUiOverlayStyle
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
    // No changes to the logic, we still load chats on init.
    context.read<ChatBloc>().add(LoadChatsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use a slightly off-white background for better contrast with cards.
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        // A modern, clean AppBar style.
        systemOverlayStyle: SystemUiOverlayStyle.dark, // Makes status bar icons dark
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
          // Loading state remains the same, it's clear and effective.
          if (state is ChatLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            );
          }

          // The main UI improvement is in the ChatsLoaded state.
          if (state is ChatsLoaded) {
            final chats = state.chats;
            // Handle case where there are no chats
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
            // Use ListView.separated for clean dividers between cards.
            return ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
              itemCount: chats.length,
              separatorBuilder: (context, index) => const SizedBox(height: 4), // Spacing between cards
              itemBuilder: (context, index) {
                final chat = chats[index];
                // Determine the contact's name based on the logged-in user.
                final contactName = chat.user1.name != state.loggedUser.name
                    ? chat.user1.name
                    : chat.user2.name;

                // Using a Card for each list item gives a modern, elevated look.
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
                      'Tap to see the conversation...', // A more inviting subtitle
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    trailing: Icon(
                      Icons.chevron_right_rounded, // A chevron is a common UI pattern for "enter"
                      color: Colors.grey.shade400,
                      size: 28,
                    ),
                    // The core onTap logic is preserved perfectly.
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

          // A more user-friendly error display.
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