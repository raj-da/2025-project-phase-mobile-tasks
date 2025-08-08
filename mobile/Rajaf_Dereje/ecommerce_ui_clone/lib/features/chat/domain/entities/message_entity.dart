import 'package:equatable/equatable.dart';

import '../../../authentication/domain/entity/user.dart';
import 'chat_entity.dart';

class MessageEntity extends Equatable {
  final String id;
  final ChatEntity chat;
  final User sender;
  final String content;
  final String type;

  const MessageEntity({
    required this.id,
    required this.chat,
    required this.sender,
    required this.content,
    required this.type,
  });
  
  @override
  List<Object?> get props => [id, chat, sender, content, type];
}
