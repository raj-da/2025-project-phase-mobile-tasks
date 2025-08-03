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
