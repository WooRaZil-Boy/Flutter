import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fb_auth_bloc/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;

part 'auth_event.dart';
part 'auth_state.dart';

// AuthBloc의 핵심역할은
// 1. User stream을 읽어서 값이 변할 때마다 event를 생성한다.
// 2. User가 null 인지 확인해서 auth/unauth 상태를 생성한다.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // UserRepository의 user getter stream을 listen해야 한다.
  late final StreamSubscription authSubsription;
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthState.unknown()) {
    // authRepository에서 새로운 User의 상태가 감지되면 이를 수신해 새로운 이벤트를 발생시킨다.
    authSubsription = authRepository.user.listen((fbAuth.User? user) {
      add(AuthStateChangedEvent(user: user));
    });

    on<AuthStateChangedEvent>((event, emit) {
      if (event.user != null) {
        emit(
          state.copyWith(
            authStatus: AuthStatus.authenticated,
            user: event.user,
          ),
        );
      } else {
        // log out된 상황
        emit(
          state.copyWith(
            authStatus: AuthStatus.unauthenticated,
            user: null,
          ),
        );
      }
    });

    on<SignoutRequestedEvent>((event, emit) async {
      await authRepository.signout();
    });
  }
}
