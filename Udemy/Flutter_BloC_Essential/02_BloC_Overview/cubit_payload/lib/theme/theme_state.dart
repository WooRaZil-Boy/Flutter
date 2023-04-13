part of 'theme_cubit.dart';

enum AppTheme {
  light,
  dark
}

// cubit과 BloC는 state를 handling하는 방식의 차이이기 때문에 State 자체는 동일하다.
class ThemeState extends Equatable {
  final AppTheme appTheme;

  ThemeState({
    this.appTheme = AppTheme.light,
  });

  factory ThemeState.initial() {
    return ThemeState();
  }
  
  @override
  List<Object> get props => [appTheme];

  @override
  String toString() => 'ThemeState(appTheme: $appTheme)';

  ThemeState copyWith({
    AppTheme? appTheme,
  }) {
    return ThemeState(
      appTheme: appTheme ?? this.appTheme,
    );
  }
}

