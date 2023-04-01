import 'package:flutter/material.dart';
import 'package:open_weather_cubit/cubits/weather/weather_cubit.dart';
import 'package:open_weather_cubit/pages/search_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          )
        ],
      ),
      body: _showWeather(),
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
        
        return Center(
          child: Text(
            state.weather.name,
            style: const TextStyle(fontSize: 18.0),
          ),
        );
      },
      listener: (context, state) {
        if (state.status == WeatherStatus.error) {
          showDialog(
            context: context, 
            builder: (context) {
              return AlertDialog(
                content: Text(state.error.errMsg),
              );
            }
          );
        }
      },
    );
  }
}
