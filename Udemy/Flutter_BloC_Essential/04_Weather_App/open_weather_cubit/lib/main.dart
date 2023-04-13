import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:open_weather_cubit/cubits/temp_settings/temp_settings_cubit.dart';
import 'package:open_weather_cubit/cubits/theme/theme_cubit.dart';
import 'package:open_weather_cubit/cubits/weather/weather_cubit.dart';
import 'package:open_weather_cubit/repositories/weather_repository.dart';
import 'package:open_weather_cubit/services/weather_api_services.dart';

import 'pages/home_page.dart';

void main() async {
  // 환경 변수에서 API 키를 가져온다.
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
              weatherRepository: context.read<WeatherRepository>()
            )
          ),
          BlocProvider<TempSettingsCubit>(
            create: (context) => TempSettingsCubit()),
          BlocProvider<ThemeCubit>(
            create: (context) =>
              ThemeCubit(weatherCubit: context.read<WeatherCubit>()))
        ],
        // provider의 context를 제대로 찾을 수 없기 때문에 Builder 위젯을 써야 감싸거나 따로 위젯 클래스를 만들어야 한다.
        // Bloc을 사용하면, BlocBuilder 또한 일반 Builder 위젯과 마찬가지로 context를 제공할 수 있다.
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
    );
  }
}
