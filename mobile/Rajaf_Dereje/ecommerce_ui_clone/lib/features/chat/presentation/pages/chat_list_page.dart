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

  // final List<Map<String, dynamic>> chats = [
  //   {
  //     "name": "Alex Linderson",
  //     "message": "How are you today?",
  //     "time": "2 min ago",
  //     "unread": 3,
  //   },
  //   {
  //     "name": "Team Align",
  //     "message": "Don't miss to attend the meeting.",
  //     "time": "2 min ago",
  //     "unread": 4,
  //   },
  //   {
  //     "name": "John Ahraham",
  //     "message": "Hey! Can you join the meeting?",
  //     "time": "2 min ago",
  //     "unread": 0,
  //   },
  //   {
  //     "name": "Sabila Sayma",
  //     "message": "How are you today?",
  //     "time": "2 min ago",
  //     "unread": 0,
  //   },
  //   {
  //     "name": "John Borino",
  //     "message": "Have a good day 🌸",
  //     "time": "2 min ago",
  //     "unread": 0,
  //   },
  //   {
  //     "name": "Angel Dayna",
  //     "message": "How are you today?",
  //     "time": "2 min ago",
  //     "unread": 0,
  //   },
  // ];

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
                          contactName: chat.user2.name,
                          chatId: chat.id,
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
          // return ListView.builder(
          //   itemCount: chats.length,
          //   itemBuilder: (context, index) {
          //     final chat = chats[index];
          //     return ListTile(
          //       leading: CircleAvatar(
          //         backgroundColor: Colors.blue.shade100,
          //         child: Text(
          //           chat['name'][0],
          //           style: const TextStyle(
          //             fontWeight: FontWeight.bold,
          //             color: Colors.black,
          //           ),
          //         ), // First Letter of the name
          //       ),

          //       title: Text(
          //         chat['name'],
          //         style: const TextStyle(fontWeight: FontWeight.bold),
          //       ),

          //       subtitle: Text(
          //         chat['message'],
          //         overflow: TextOverflow.ellipsis,
          //       ),

          //       trailing: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Text(
          //             chat["time"],
          //             style: const TextStyle(fontSize: 12, color: Colors.grey),
          //           ),
          //           if (chat["unread"] > 0)
          //             Container(
          //               margin: const EdgeInsets.only(top: 4),
          //               padding: const EdgeInsets.all(6),
          //               decoration: const BoxDecoration(
          //                 color: Colors.blue,
          //                 shape: BoxShape.circle,
          //               ),
          //               child: Text(
          //                 chat["unread"].toString(),
          //                 style: const TextStyle(
          //                   color: Colors.white,
          //                   fontSize: 12,
          //                 ),
          //               ),
          //             ),
          //         ],
          //       ),

          //       onTap: () {
          //         // Navigator.pushNamed(
          //         //   context,
          //         //   '/chatPage',
          //         //   arguments: chat['name'],
          //         // );
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (_) => ChatPage(contactName: chat["name"]),
          //           ),
          //         );
          //       },
          //     );
          //   },
          // );
        },
      ),
    );
  }
}
