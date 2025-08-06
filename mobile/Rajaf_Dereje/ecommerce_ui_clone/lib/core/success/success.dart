import 'package:equatable/equatable.dart';

abstract class Success extends Equatable {
  final String messege;
  const Success({this.messege = 'Operation Successful'});

  @override
  List<Object> get props => [messege];
}

class LogInSuccess extends Success {
  const LogInSuccess({super.messege = 'Log in Successful'});
}

class LogOutSuccess extends Success {
  const LogOutSuccess({super.messege = 'Log out Successful'});
}

class SignUpSucess extends Success {
  const SignUpSucess({super.messege = 'Sign Up successful'});
}
