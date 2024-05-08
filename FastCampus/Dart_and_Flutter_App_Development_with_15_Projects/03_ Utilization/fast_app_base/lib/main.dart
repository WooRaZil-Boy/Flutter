import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';


import 'app.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'common/data/preference/app_preferences.dart';

void main() async {
  final bindings = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash에서 기존의 native splash를 유지한다.
  FlutterNativeSplash.preserve(widgetsBinding: bindings);
  await EasyLocalization.ensureInitialized();
  await AppPreferences.init();
  // 보통 전체에서 한 번만 세팅하는 경우
  timeago.setLocaleMessages('ko', timeago.KoMessages());

  runApp(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ko')],
      fallbackLocale: const Locale('en'),
      path: 'assets/translations',
      useOnlyLangCode: true,
      child: const App()));
}

// Flutter 기본 상태 관리 : setState, InheritedWidget

// chage_app_package_name 을 사용해서, package name을 일괄 변경할 수 있다.
// iOS의 경우 xcode의 bundle identifier를 변경해야 한다.