part of 'auth_cubit.dart';

sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

final class Authlooding extends AuthState {}

final class AuthDone extends AuthState {
  const AuthDone();
}

final class AuthError extends AuthState {
  final String errormessage;
  AuthError(this.errormessage);
}

final class AuthLogingout extends AuthState {
  const AuthLogingout();
}

final class AuthLogedout extends AuthState {
  const AuthLogedout();
}

final class AuthLogoutfail extends AuthState {
  final String message;
  AuthLogoutfail(this.message);
}

final class GoogleAuthenticating extends AuthState {
  const GoogleAuthenticating();
}

final class GoogleAuthError extends AuthState {
  final String message;
  GoogleAuthError(this.message);
}

final class GoogleAuthDone extends AuthState {}

final class FacebookAuthenticating extends AuthState {
  const FacebookAuthenticating();
}

final class FacebookAuthError extends AuthState {
  final String message;
  FacebookAuthError(this.message);
}

final class FacebookAuthDone extends AuthState {}
