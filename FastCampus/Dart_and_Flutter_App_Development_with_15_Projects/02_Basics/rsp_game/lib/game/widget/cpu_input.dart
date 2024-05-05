import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rsp_game/game/enum.dart';
import 'package:rsp_game/game/widget/input_card.dart';

class CpuInput extends StatelessWidget {
  const CpuInput({super.key, required this.isDone, required this.cpuInput});

  final bool isDone;
  final InputType cpuInput;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      // 빈 공간을 만든다.
      const Expanded(
        child: SizedBox.shrink(),
      ),
      Expanded(
        child: InputCard(
          child: getCpuInput(),
        ),
      ),
      const Expanded(
        child: SizedBox.shrink(),
      ),
    ]);
  }

  Widget getCpuInput() {
    if (isDone) {
      return Image.asset(cpuInput.path);
    }

    return const SizedBox(
      height: 80,
      child: Center(
        child: Text(
          '?',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}