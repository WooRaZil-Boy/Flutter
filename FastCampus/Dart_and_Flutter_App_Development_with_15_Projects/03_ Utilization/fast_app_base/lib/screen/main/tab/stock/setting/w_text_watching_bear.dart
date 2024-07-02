import 'package:fast_app_base/common/common.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

// success, fail 상태를 받아서 처리하기 위한 controller
class TextWatchingBearController {
  // 상태 변경은 State 객체에서 이루어지기 때문에 초기에 설정할 수 없다. 따라서 late로 선언한다.
  late void Function() runSuccessAnimation;
  late void Function() runFailAnimation;
}

class TextWatchingBear extends StatefulWidget {
  final bool check;
  final bool handsUp;
  final double look;
  final TextWatchingBearController controller;

  const TextWatchingBear({
    super.key,
    required this.check,
    required this.handsUp,
    required this.look,
    required this.controller,
  });

  @override
  State<TextWatchingBear> createState() => _TextWatchingBearState();
}

class _TextWatchingBearState extends State<TextWatchingBear> {
  late StateMachineController controller;
  // 변경할 수 있는 상태들 : Check, HandsUp, Look, Success, Fail
  // Rive에서 설정한 이름을 사용한다.
  late SMIBool smiCheck;
  late SMIBool smiHandsUp;
  late SMINumber smiLook;
  late SMITrigger smiSuccess;
  late SMITrigger smiFail;

  @override
  void initState() {
    widget.controller.runSuccessAnimation = () {
      smiSuccess.fire();
    };
    widget.controller.runFailAnimation = () {
      smiFail.fire();
    };
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TextWatchingBear oldWidget) {
    if (oldWidget.check != widget.check) {
      smiCheck.value = widget.check;
    }

    if (oldWidget.handsUp != widget.handsUp) {
      smiHandsUp.value = widget.handsUp;
    }

    if (oldWidget.look != widget.look) {
      smiLook.value = widget.look;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return RiveAnimation.asset(
      "$baseRivePath/login_screen_character.riv",
      stateMachines: const ['State Machine 1'], // 해당 state는 rive editor에서 확인 가능하다.
      onInit: (Artboard art) {
        controller = StateMachineController.fromArtboard(art, 'State Machine 1')!;
        controller.isActive = true;
        art.addController(controller);
        // rive editor에서 사용 중인 state 변수명을 그대로 사용해야 한다.
        smiCheck = controller.findInput<bool>('Check') as SMIBool;
        smiHandsUp = controller.findInput<bool>('hands_up') as SMIBool;
        smiLook = controller.findInput<double>('Look') as SMINumber;
        smiSuccess = controller.findInput<bool>('success') as SMITrigger;
        smiFail = controller.findInput<bool>('fail') as SMITrigger;
      },
    );
  }
}
