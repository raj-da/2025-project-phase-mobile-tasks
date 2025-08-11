import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/chat_bloc.dart';

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
      body: BlocBuilder<ChatBloc, ChatState>(
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
                    // Navigator.push(context, MaterialPageRoute(builder: (_) => ))
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
          //   itemCount: allUsers.length,
          //   itemBuilder: (context, index) {
          //     final name = allUsers[index];
          //     final inChat = chatUsers.contains(name);

          //     return ListTile(
          //       leading: CircleAvatar(
          //         backgroundColor: Colors.blue.shade100,
          //         child: Text(
          //           name[0], // First letter of the name
          //           style: const TextStyle(
          //             fontWeight: FontWeight.bold,
          //             color: Colors.black,
          //           ),
          //         ),
          //       ),
          //       title: Text(name),
          //       subtitle: Text(inChat ? "In chats" : "Not in chats"),
          //       trailing: Icon(
          //         Icons.chat,
          //         color: inChat ? Colors.blue : Colors.grey,
          //       ),
          //       onTap: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (_) => ChatPage(contactName: name),
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

// class ChatPage extends StatefulWidget {
//   final String contactName;
//   const ChatPage({Key? key, required this.contactName}) : super(key: key);

//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   final TextEditingController _controller = TextEditingController();
//   final List<String> messages = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.contactName),
//         backgroundColor: Colors.blue,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.all(10),
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 final msg = messages[index];
//                 return Align(
//                   alignment: Alignment.centerRight,
//                   child: Container(
//                     margin: const EdgeInsets.symmetric(vertical: 4),
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: Colors.blue,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Text(
//                       msg,
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _controller,
//                     decoration: const InputDecoration(
//                       hintText: "Write your message",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(20)),
//                       ),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.send, color: Colors.blue),
//                   onPressed: () {
//                     if (_controller.text.trim().isNotEmpty) {
//                       setState(() {
//                         messages.add(_controller.text.trim());
//                       });
//                       _controller.clear();
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
