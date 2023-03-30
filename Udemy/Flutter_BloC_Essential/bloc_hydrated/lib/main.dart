import 'package:bloc_hydrated/bloc/counter/counter_bloc.dart';
import 'package:bloc_hydrated/bloc/theme/theme_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// hydrated_bloc의 저장소의 위치를 알려줘야 한다. 이 작업이 시간이 걸리므로, main 함수를 async로 지정해야 한다.
void main() async {
  // hydrated_bloc은 네이티브 코드를 호출하기 때문에, 먼저 WidgetsFlutterBinding.ensureInitialized()를 호출해야 한다.
  WidgetsFlutterBinding.ensureInitialized();

  // 9.0 버전 이후 부터는 HydratedBlocOverride.runZoned 대신, HydratedBloc.storage 를 사용한다.
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb 
      ? HydratedStorage.webStorageDirectory
      : await getApplicationDocumentsDirectory()
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterBloc>(
          create: (context) => CounterBloc()
        ),
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc()
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Hydrated Bloc',
            debugShowCheckedModeBanner: false,
            theme: state.appTheme == AppTheme.light
              ? ThemeData.light()          
              : ThemeData.dark(),
            home: const MyHomePage(),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '${context.watch<CounterBloc>().state.counter}',
          style: const TextStyle(fontSize: 64.0),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<ThemeBloc>().add(ToggleThemeEvent());
            },
            child: const Icon(Icons.brightness_6),
          ),
          const SizedBox(width: 5.0),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterBloc>().add(IncrementCounterEvent());
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 5.0),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterBloc>().add(DecrementCounterEvent());
            },
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 5.0),
          FloatingActionButton(
            onPressed: () {
              // hydrated_bloc package는 flutter_bloc package의 extension
              // BloC나 Cubit의 state를 persist/restore를 자동으로 해 준다.
              // State는 기본적으로 hot-restart하거나 rebooting하면 초기화된다. 
              // 하지만 때로는 hot-restart하거나 rebooting해도 DB에 저장된것 처럼 state가 유지되는게 좋은 경우도 있다. (ex. 쇼핑 카트)
              // 기본적으로 state를 저장하려면 persistent storage가 필요하다. remote에 유지한다면 시간이 오래걸리거나 접속 불량인 경우도 있으므로 local에서 유지하는 것이 좋다.
              // hydrated_bloc은 local 저장으로 Hive를 사용하고 있다. 다른 SQFlite, SharedPreferences에 비해 속도가 훨씬 빠르다.
              HydratedBloc.storage.clear();
            },
            child: const Icon(Icons.delete_forever),
          )
        ],
      ),
    );
  }
}