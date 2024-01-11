part of 'auth_cubit.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationIntial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final String token;

  Authenticated(this.token);
}

class UnAuthenticated extends AuthenticationState {}
