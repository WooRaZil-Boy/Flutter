part of 'auth_bloc.dart';

enum AuthStatus {
  unknown,
  authenticated,
  unauthenticated,
}

// 인증 상태를 저장한다.
class AuthState extends Equatable {
  final AuthStatus authStatus;
  final fbAuth.User? user;

  AuthState({
    required this.authStatus,
    this.user,
  });

  factory AuthState.unknown() => AuthState(authStatus: AuthStatus.unknown);

  @override
  List<Object?> get props => [authStatus, user];

  @override
  String toString() => 'AuthState(authStatus: $authStatus, user: $user)';

  AuthState copyWith({
    AuthStatus? authStatus,
    fbAuth.User? user,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      user: user ?? this.user,
    );
  }
}
