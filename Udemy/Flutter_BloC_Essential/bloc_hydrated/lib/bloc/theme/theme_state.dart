part of 'theme_bloc.dart';

enum AppTheme {
  light,
  dart;

  String toJson() => name;

  static AppTheme fromJson(String json) => values.byName(json);
}

class ThemeState extends Equatable {
  final AppTheme appTheme;

  ThemeState({
    required this.appTheme,
  });

  factory ThemeState.initial() => ThemeState(appTheme: AppTheme.light);

  @override
  List<Object> get props => [appTheme];

  @override
  String toString() => 'ThemeState(appTheme: $AppTheme)';

  ThemeState copyWith({
    AppTheme? appTheme,
  }) {
    return ThemeState(
      appTheme: appTheme ?? this.appTheme,
    );
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};
    result.addAll({'appTheme': appTheme.toJson()});
    return result;

    return <String, dynamic>{
      'appTheme': appTheme.toJson(),
    };
  }

  factory ThemeState.fromJson(Map<String, dynamic> json) {
    return ThemeState(
      appTheme: AppTheme.fromJson(json['appTheme']),
    );
  }
}
