import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fb_auth_bloc/models/custom_error.dart';
import 'package:fb_auth_bloc/repositories/auth_repository.dart';

part 'signin_state.dart';

// Signin 에서는 유저가 입력한 email / password로 Auth Repository의 sign in 함수를 호출해야 한다.
// 성공하면 HomePage로 이동하고 실패하면 UI로 실패했다는 정보를 제공하며 진행 중이라면 진행 중이라는 정보를 제공해야 한다.
// State가 복잡하지 않고, SigninPage 외에 전달할 필요도 없기 때문에 Cubit으로 충분하다.
class SigninCubit extends Cubit<SigninState> {
  // authRepository의 signin 함수 호출이 필요하다.
  final AuthRepository authRepository;

  SigninCubit({required this.authRepository}) : super(SigninState.initial());

  Future<void> signin({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(signinStatus: SigninStatus.submitting));

    try {
      await authRepository.signin(email: email, password: password);

      emit(state.copyWith(signinStatus: SigninStatus.success));
    } on CustomError catch (e) {
      emit(
        state.copyWith(
          signinStatus: SigninStatus.error,
          error: e,
        ),
      );
    }
  }
}
