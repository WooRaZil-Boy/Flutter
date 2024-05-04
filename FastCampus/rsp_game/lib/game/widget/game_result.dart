import 'package:flutter/material.dart';
import 'package:rsp_game/game/enum.dart';

class GameResult extends StatelessWidget {
  const GameResult(
      {super.key, required this.isDone, this.result, required this.callback});

  final bool isDone;
  final Result? result;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    if (isDone) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            result!.displayString,
            style: const TextStyle(fontSize: 32),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => callback.call(),
            child: const Text(
              '다시하기',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ],
      );
    }

    return const Center(
      child: Text(
        '가위, 바위, 보 중 하나를 선택하세요.',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
