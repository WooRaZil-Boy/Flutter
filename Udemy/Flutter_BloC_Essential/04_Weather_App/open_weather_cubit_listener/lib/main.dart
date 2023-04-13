import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'cubits/temp_settings/temp_settings_cubit.dart';
import 'cubits/theme/theme_cubit.dart';
import 'cubits/weather/weather_cubit.dart';
import 'pages/home_page.dart';
import 'repositories/weather_repository.dart';
import 'services/weather_api_services.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WeatherRepository(
        weatherApiServices: WeatherApiServices(
          httpClient: http.Client(),
        ),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<WeatherCubit>(
            create: (context) => WeatherCubit(
              weatherRepository: context.read<WeatherRepository>(),
            ),
          ),
          BlocProvider<TempSettingsCubit>(
            create: (context) => TempSettingsCubit(),
          ),
          BlocProvider<ThemeCubit>(
            create: (context) => ThemeCubit(),
          ),
        ],
        // StreamSubscription 대신  BlocListener를 사용하여 Cubit간 커뮤니케이션을 하는 방식으로 변경한다.
        // global theme 설정을 material에서 했으므로, MaterialApp을 BlocProvider로 감싸야 한다.
        // Weather의 상태가 변경될 때마다 업데이트 필요하므로 WeatherCubit을 가져와야 한다.
        child: BlocListener<WeatherCubit, WeatherState>(
          listener: (context, state) {
            context.read<ThemeCubit>().setTheme(state.weather.temp);
          },
          child: BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return MaterialApp(
                title: 'Weather App',
                debugShowCheckedModeBanner: false,
                theme: state.appTheme == AppTheme.light
                    ? ThemeData.light()
                    : ThemeData.dark(),
                home: const HomePage(),
              );
            },
          ),
        ),
      ),
    );
  }
}
