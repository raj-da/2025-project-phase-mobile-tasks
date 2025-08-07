import 'package:equatable/equatable.dart';

String generalFailureMessege = 'Failure';
String generalServerFailureMessege = 'Server Failure';
String generalCachedFailureMessege = 'Cache Failure';
String generalNetworkFailureMessege = 'Network Failure';

abstract class Failure extends Equatable {
  final String messege;
  const Failure({this.messege = 'Failure'});

  @override
  List<Object> get props => [messege];
}

class ServerFailure extends Failure {
  const ServerFailure({super.messege = 'Server Failure'});
}

class CachedFailure extends Failure {
  const CachedFailure({super.messege = 'Cache Failure'});
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.messege = 'Network Failure'});
}

class InvalidNameFailure extends Failure {
  const InvalidNameFailure({super.messege = 'Invalid Name'});
}

class InvalidDescriptionFailure extends Failure {
  const InvalidDescriptionFailure({super.messege = 'Invalid Description'});
}

class InvalidImageFailure extends Failure {
  const InvalidImageFailure({super.messege = 'Image upload Failure'});
}

class InvalidPriceFailure extends Failure {
  const InvalidPriceFailure({super.messege = 'Invalid Price'});
}

class InvalidIdFailure extends Failure {
  const InvalidIdFailure({super.messege = 'Invalid Id'});
}

class LogInFailure extends Failure {
  const LogInFailure({super.messege = 'Log in failed'});
}

class LogOutFailure extends Failure {
  const LogOutFailure({super.messege = 'Log out failed'});
}

class SignInFailure extends Failure {
  const SignInFailure({super.messege = 'Sign in failed'});
}
