import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/success/success.dart';
import '../repositories/chat_repositories.dart';

class ConnectSocket {
  final ChatRepository repository;

  const ConnectSocket({required this.repository});

  Future<Either<Failure, Success>> call({required String url}) {
    return repository.connectToSocket(url: url);
  }
}
