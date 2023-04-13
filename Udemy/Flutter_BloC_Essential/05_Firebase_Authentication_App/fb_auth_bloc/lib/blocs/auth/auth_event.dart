part of 'auth_bloc.dart';

// 인증 상태가 변할 때마다 발생할 이벤트들
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

// 인증 상태가 변하면, AuthRepository의 User getter도 변한다.
// 따라서 이벤트가 발생할 때 User 값도 포함해서 발생시킨다.
class AuthStateChangedEvent extends AuthEvent {
  final fbAuth.User? user;

  AuthStateChangedEvent({
    this.user,
  });

  @override
  List<Object?> get props => [user];
}

class SignoutRequestedEvent extends AuthEvent {}