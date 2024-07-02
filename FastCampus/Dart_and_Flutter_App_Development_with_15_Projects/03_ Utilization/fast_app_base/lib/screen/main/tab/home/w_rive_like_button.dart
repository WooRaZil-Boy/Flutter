import 'package:fast_app_base/common/common.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveLikeButton extends StatefulWidget {
  // 보통은 상위에서 like 상태를 받아서 처리한다.
  final bool isLike;
  final void Function(bool isLike) onTapLike;

  const RiveLikeButton(this.isLike, {super.key, required this.onTapLike});

  @override
  State<RiveLikeButton> createState() => _RiveLikeButtonState();
}

class _RiveLikeButtonState extends State<RiveLikeButton> {
  late StateMachineController controller; // 초기화 시에는 init 되지 않는다.
  // 변경할 수 있는 상태들 : Hover, Pressed
  late SMIBool smiPressed;
  late SMIBool smiHover;

  // bool isLike = false;
  // 
  // @override
  // void initState() {
  //   // 상위 widget에서 받은 isLiked를 사용한다.
  //   isLike = widget.isLike;
  //   super.initState();
  // }

  // didUpdateWidget은 해당 위젯이 사용 중인 화면에서 build가 일어날 때 호출된다.
  // 즉, 여기에서는 상위에서 받은 isLiked가 변경되었을 때 호출된다.
  @override
  void didUpdateWidget(covariant RiveLikeButton oldWidget) {
    if (oldWidget.isLike != widget.isLike) {
      smiPressed.value = widget.isLike;
      smiHover.value = widget.isLike;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Tap(
      onTap: () {
        widget.onTapLike(!widget.isLike);
      },
      child: RiveAnimation.asset(
        '$baseRivePath/light_like.riv',
        stateMachines: const ['State Machine 1'], // 해당 state는 rive editor에서 확인 가능하다.
        onInit: (Artboard art) {
            // controller에 artboard를 연결한다.
            controller = StateMachineController.fromArtboard(art, 'State Machine 1')!;
            controller.isActive = true;
            art.addController(controller);
            // controller에서 해당 state를 찾아 연결한다.
            smiPressed = controller.findInput<bool>('Pressed') as SMIBool;
            smiHover = controller.findInput<bool>('Hover') as SMIBool;
          },
      ),
    );
  }
}

// network로 인터넷에 있는 rive 파일을 재생할 수도 있다.