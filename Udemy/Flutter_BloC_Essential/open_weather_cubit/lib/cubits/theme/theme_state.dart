part of 'theme_cubit.dart';

enum AppTheme {
  light,
  dark
}

class ThemeState extends Equatable {
  final AppTheme appTheme;
  
  ThemeState({
    this.appTheme = AppTheme.light,
  });

  factory ThemeState.initial() => ThemeState();

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
