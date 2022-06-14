part of 'login_bloc.dart';

@immutable
abstract class LoginState {
  String user = '';
  bool get isValid => user.length > 3;
  LoginState(this.user);
}

class LoginInitial extends LoginState {
  LoginInitial(String user) : super('');
}

class LoginUserState extends LoginState {
  LoginUserState(String user) : super(user);
}
