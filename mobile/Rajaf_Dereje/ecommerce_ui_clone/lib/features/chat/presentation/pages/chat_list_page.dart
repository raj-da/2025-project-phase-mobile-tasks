import 'package:flutter/material.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: const Text('Chats', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),

      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ChatsLoaded) {
            final chats = state.chats;
            return ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue.shade100,
                    child: Text(chat.user2.name[0]),
                  ),
                  title: Text(chat.user1.name),
                  subtitle: const Text('Tap to open chat'),
                  trailing: const Icon(Icons.chat, color: Colors.blue),
                  onTap: () {
                    // Navigator.pushNamed(context, '/chatpage', arguments: chat);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatPage(
                          contactName: chat.user1.name != state.loggedUser.name? chat.user1.name: chat.user2.name,
                          chatId: chat.id,
                          loggedUser: state.loggedUser.name,
                        ),
                      ),
                    );
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
