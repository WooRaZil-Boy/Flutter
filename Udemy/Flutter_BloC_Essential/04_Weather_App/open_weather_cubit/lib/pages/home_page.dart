import 'package:flutter/material.dart';
import 'package:open_weather_cubit/constants/constants.dart';
import 'package:open_weather_cubit/cubits/temp_settings/temp_settings_cubit.dart';
import 'package:open_weather_cubit/cubits/weather/weather_cubit.dart';
import 'package:open_weather_cubit/pages/search_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_weather_cubit/pages/settins_page.dart';
import 'package:open_weather_cubit/widgets/error_dialog.dart';
import 'package:recase/recase.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 아무 것도 입력하지 않은 상태에서는 null 이므로 nullable 해야 한다.
  String? _city;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            // SearchPage 에서 넘어오는 값을 기다려야 하기 때문에 await, sync가 필요하다.
            onPressed: () async {
              _city = await Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) {
                  return SearchPage();
                }),
              );
              print('city: $_city');
              if (_city != null) {
                context.read<WeatherCubit>().fetchWeather(_city!);
              }
            }, 
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) {
                  return const SettingsPage();
                }),
              );
            }, 
          )
        ],
      ),
      body: _showWeather(),
    );
  } 

  String showTemperature(double temperature) {
    final tempUnit = context.watch<TempSettingsCubit>().state.tempUnit;

    if (tempUnit == TempUnit.fahrenheit) {
      return ((temperature * 9 / 5) + 32).toStringAsFixed(2) + '℉';
    }

    return temperature.toStringAsFixed(2) + '℃';
  }

  // 이미지를 네트워크에서 읽어와 위젯을 반환한다.
  Widget showIcon(String icon) {
    // 네트워크에서 이미지를 불러오는 동안 placeholder를 노출한다.
    return FadeInImage.assetNetwork(
      placeholder: 'assets/images/loading.gif', 
      image: 'http://$kIconHost/img/wn/$icon@4x.png',
      width: 96,
      height: 96
    );
  }

  Widget formatText(String description) {
    // 첫 문자를 대문자로 한다.
    final formattedString = description.titleCase;
    return Text(
      formattedString,
      style: const TextStyle(fontSize: 24.0),
      textAlign: TextAlign.center,
    );
  }

  // 정상 반환된 경우에는 해당 데이터를 보여주는 위젯을 반환하고, 에러인 경우에는 Dialog를 반환한다.
  // 따라서 BlocBuilder와 BlocListener가 모두 필요하다.
  // 이런 경우에는 BlocCumsumer를 사용하여 깔끔하게 정리할 수 있다.
  Widget _showWeather() {
    return BlocConsumer<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state.status == WeatherStatus.initial) {
          return const Center(
            child: Text(
              'Select a city',
              style: TextStyle(fontSize: 20.0),
            ),
          );
        }

        if (state.status == WeatherStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.status == WeatherStatus.error && state.weather.name == '') {
          return const Center(
            child: Text(
              'Select a city',
              style: TextStyle(fontSize: 20.0),
            ),
          );
        }    
        
        return ListView(
          children: [
            SizedBox(
              // 화면 높이의 1/6
              height: MediaQuery.of(context).size.height / 6
            ),
            Text(
              state.weather.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  TimeOfDay.fromDateTime(state.weather.lastUpdated).format(context),
                  style: const TextStyle(fontSize: 18.0),
                ),
                const SizedBox(width: 10.0),
                Text(
                  '(${state.weather.country})',
                  style: const TextStyle(fontSize: 18.0),
                ),
              ],
            ),
            const SizedBox(height: 60.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  showTemperature(state.weather.temp),
                  style: const TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(width: 20.0),
                Column(
                  children: [
                    Text(
                      showTemperature(state.weather.tempMax),
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      showTemperature(state.weather.tempMin),
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Spacer(),
                showIcon(state.weather.icon),
                Expanded(
                  flex: 3,
                  child: formatText(state.weather.description)
                ),
                Spacer()
              ],
            )
          ],
        );
      },
      listener: (context, state) {
        if (state.status == WeatherStatus.error) {
          errorDialog(context, state.error.errMsg);
        }
      },
    );
  }
}
