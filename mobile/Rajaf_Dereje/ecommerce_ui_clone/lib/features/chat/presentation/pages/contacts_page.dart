import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Required for SystemUiOverlayStyle
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/chat_bloc.dart';
import 'chat_page.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  void initState() {
    super.initState();
    // Logic remains unchanged
    context.read<ChatBloc>().add(LoadUsersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // A light background color makes the white cards stand out.
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        // Modern, clean AppBar that matches the ChatListPage.
        systemOverlayStyle: SystemUiOverlayStyle.dark, // Dark status bar icons
        backgroundColor: Colors.white,
        elevation: 1.0,
        title: const Text(
          'Contacts',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      // BlocConsumer is perfect here and its logic is preserved.
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          // This navigation logic is untouched.
          if (state is ChatCreated) {
            // A small improvement: clear existing routes to avoid stacking pages
            // if the user goes back and creates another chat.
            // You can uncomment the line below for this behavior.
            // Navigator.pushAndRemoveUntil(context, newRoute, (route) => route.isFirst);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChatPage(
                  contactName: state.chat.user1.name != state.loggedUser.name
                      ? state.chat.user1.name
                      : state.chat.user2.name,
                  chatId: state.chat.id,
                  loggedUser: state.loggedUser.name,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          // While creating a chat, a full-screen loader appears. This is
          // dictated by the BLoC state logic and is kept as is.
          if (state is ChatLoading) {
            return const Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ));
          }

          if (state is UsersLoaded) {
            final users = state.users;

            // A user-friendly message when the contact list is empty.
            if (users.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.people_outline, size: 80, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'No Contacts Found',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(12.0),
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                // Using a Card provides better visual structure.
                return Card(
                  elevation: 2.0,
                  margin: const EdgeInsets.symmetric(vertical: 6.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    leading: CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.blue.shade400,
                      child: Text(
                        user.name[0].toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    title: Text(
                      user.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      user.email,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    trailing: const Icon(
                      Icons.chat_bubble_outline_rounded,
                      color: Colors.blue,
                    ),
                    // The core onTap logic is preserved perfectly.
                    onTap: () {
                      context.read<ChatBloc>().add(CreateChatEvent(user.id));
                    },
                  ),
                );
              },
            );
          }

          if (state is ChatError) {
            // Using the same enhanced error display for consistency.
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.redAccent, size: 60),
                    const SizedBox(height: 16),
                    const Text(
                      'An Error Occurred',
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