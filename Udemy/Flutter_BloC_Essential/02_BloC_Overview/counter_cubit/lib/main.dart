import 'package:counter_cubit/cubits/counter/counter_cubit.dart';
import 'package:counter_cubit/other_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocProvider로 DI를 한다. 해당 cubit을 사용하는 상위 위젯에서 만들어 주면 된다.
    // BlocProvider는 cubit을 lazy하게 생성한다(기본값).
    return BlocProvider<CounterCubit>(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        title: 'MyCounter Cubit',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 단순히 BlocProvider.of<CounterCubit>(context) 로 context를 가져오면
      // listen을 하지 않기 때문에 변화가 반영되지 않는다.
      //  1. BlocProvider.of<CounterCubit>(context, listen: true) 를 사용한다.
      //  2. BlocBuilder를 사용한다.
      body: BlocConsumer<CounterCubit, CounterState>(
        // builder은 필요에 따라 flutter framework에서 추가로 호출할 수 있기 때문에 pure 해야 한다.
          // 따라서 state 값에 따라 한 번만 수행해야 하는 Navigator 이동, Dialog 호출 등은 BlocBuilder 내에서 수행하면 crash 된다.
          // BlocBuilder 대신 BlocListener 에서 수행해야 한다.
          // BlocListener는 BlocBuilder와 달리 state 변화에 대해 한 번만 호출이 되고, 반환 타입이 void 이다.

          // 이런 작업은 빈번하게 일어나므로 좀 더 간편하게 처리할 수 있는 BlocConsumer를 사용하는 것이 좋다.
          // BlocConsumer는 BlocBuilder와 BlocListener를 wrapping 하지 않아도 된다.
          // builder와 listener를 동시에 제공한다.
        builder: (context, state) {
          return Center(
            child: Text(
              '${state.counter}',
              style: TextStyle(fontSize: 52.0),
            ),
          );
        },
        listener: (context, state) {
          if (state.counter == 3) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text('counter is ${state.counter}'),
                  );
                }
              );
            } else if (state.counter == -1) {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) {
                    return OtherPage();
                  }
                )
              );
            }
          },
        ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
          // context.watch<T>() : context로 부터 위젯 리빌드 필요한 경우
          //    == BlocProvider.of<T>(context, listen: true)
          // context.read<T>() : context가 필요하지만, 위젯 리빌드가 필요 없는 경우
          //    == BlocProvider.of<T>(context)
          // context.select<T, R>(R cb(T value)) : 특정 프로퍼티만 선택해 listen 하는 경우
        children: [
          FloatingActionButton(
            onPressed: () {
              // BlocProvider.of<CounterCubit>(context).increment();
              context.read<CounterCubit>().increment();
            },
            child: Icon(Icons.add),
            heroTag: 'increment',
          ),
          SizedBox(width: 10.0),
          FloatingActionButton(
            onPressed: () {
              // BlocProvider.of<CounterCubit>(context).decrement();
              context.read<CounterCubit>().decrement();
            },
            child: Icon(Icons.remove),
            heroTag: 'decrement',
          ),
        ],
      ),
    );
  }
}