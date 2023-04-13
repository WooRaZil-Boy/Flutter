import 'package:bloc_anonymous/counter/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowMeCounter extends StatelessWidget {
  const ShowMeCounter({super.key});

  // ShowMeCounter는 BlocProvider의 자식이 아니고, BlocProvider의 형제로 MaterialApp의 자식이다.
  // 따라서 ShowMeCounter에서 BlocProvider.of<CounterCubit>(context)를 해도 찾을 수 없다.
  // 즉 ShowMeCounter와 BlocProvider는 부모 - 자식 간의 관계가 아니다.
  // 여기서는 Navigator.push()를 사용했기 때문인데, 이를 사용하면 자식 위젯이 생기는 것이 아니라 새로운 위젯 트리가 생성된다.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter'),
      ),
      body: Center(
        child: BlocBuilder<CounterCubit, CounterState>(
          builder: (context, state) {
            return Text(
              '${state.counter}',
              style: TextStyle(fontSize: 52.0),
            );
          },
        ),
      ),
    );
  }
}
