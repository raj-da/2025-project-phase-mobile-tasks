import 'package:flutter/material.dart';
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
    context.read<ChatBloc>().add(LoadUsersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is ChatCreated) {
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
          if (state is ChatLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is UsersLoaded) {
            final users = state.users;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue.shade100,
                    child: Text(user.name[0]),
                  ),
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  trailing: const Icon(
                    Icons.chat_bubble_rounded,
                    color: Colors.blue,
                  ),
                  onTap: () {
                    context.read<ChatBloc>().add(CreateChatEvent(user.id));
                  },
                );
              },
            );
          }

          if (state is ChatError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox();
        },
      ),
    );
  }
}
