import 'package:bloc/bloc.dart';

// blocObserver 스니펫 파일로 바로 생성할 수 있다.  
// 각각의 이벤트를 트래킹할 수 있기 때문에 유용하다.
class AppBlocObserver extends BlocObserver {
  // Bloc 인수 외에 각 메서드의 추가적인 인수들은 각 이벤트에 해당하는 객체로 해당 이벤트에 대한 추가적인 데이터를 가지고 있다.

  // onEvent와 onTransition는 BloC에만 있기 때문에 타입이 Bloc이다.
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('onEvent -- ${bloc.runtimeType}: $event');
  }

  // onError와 onChange는 Cubit과 BloC의 공통이기 때문에 타입이 BlocBase 이다.
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}: $error, $stackTrace');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}: $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('onTransition -- ${bloc.runtimeType}: $transition');
  }
}

  // blocOverrides 가 deprecated 되고, 다시 Bloc.observer, Bloc.transformer 로 사용한다.
// Cubit의 LifeCycle
// Function - emit - onChange - State
// BloC의 LifeCycle
// Event - onEvent - EventTransformer - EventHandler - emit - onTransition - State

// Cubit : Change에서 State의 값 변화를 알수는 있지만, 촉발시키는 원인은 알 수 없다.
// onCreate - [ onChange ] - onClose
// BloC : State의 변화를 촉발시키는 원인을 추적할 수 있다.
// onCreate - [ onEvent - onTransition - onChange ] - onClose
// ex. 로그아웃이 되는 경우, Cubit은 로그아웃이 됐다는 건 알 수 있지만, 왜 로그아웃이 됐는지는 알 수 없다.
// BloC는 사용자가 로그아웃 버튼을 클릭했는지, 타임아웃으로 세션이 종료되어 자동 로그아웃 됐는지 등을 각각 알 수 있다.