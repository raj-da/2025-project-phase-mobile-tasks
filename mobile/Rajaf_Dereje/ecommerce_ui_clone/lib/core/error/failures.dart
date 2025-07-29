abstract class Failure {
  final String messege;
  Failure(this.messege);
}

class ServerFailure extends Failure {
  ServerFailure(super.messege);
}

class CachedFailure extends Failure {
  CachedFailure(super.messege);
}

class NetworkFailure extends Failure {
  NetworkFailure(super.messege);
}
