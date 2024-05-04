import 'package:flutter/material.dart';
import 'package:rsp_game/game/enum.dart';
import 'package:rsp_game/game/widget/input_card.dart';

class UserInput extends StatelessWidget {
  const UserInput(
      {super.key,
      required this.isDone,
      this.userInput,
      required this.callback});

  final bool isDone;
  final InputType? userInput;
  final Function(InputType) callback;

  @override
  Widget build(BuildContext context) {
    if (isDone) {
      return Row(
        children: [
          const Expanded(
            child: SizedBox.shrink(),
          ),
          Expanded(
            child: InputCard(
              child: Image.asset(userInput!.path),
            ),
          ),
          const Expanded(
            child: SizedBox.shrink(),
          ),
        ],
      );
    }

    return Row(
      children: _getInputs(callback),
    );
  }

  List<Widget> _getInputs(Function(InputType) callback) {
    return InputType.values
        .map(
          (type) => InputCard(
            child: Image.asset(type.path),
            callback: () => callback.call(type),
          ),
        )
        .toList();
  }
}
