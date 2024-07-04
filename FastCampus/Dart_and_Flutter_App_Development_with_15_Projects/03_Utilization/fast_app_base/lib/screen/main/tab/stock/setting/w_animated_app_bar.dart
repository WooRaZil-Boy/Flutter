import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/widget/w_arrow.dart';
import 'package:flutter/material.dart';

class AnimatedAppBar extends StatefulWidget {
  final String title;
  final ScrollController scrollController;
  // tick마다 변화를 감지해 notify 해준다. Flutter는 60fps로 동작한다.
  // _AnimatedAppBarState에서 생성할 수도 있지만, 초기화될때 받아 올 수도 있다.
  final AnimationController animationController;

  const AnimatedAppBar({
    super.key,
    required this.title,
    required this.scrollController,
    required this.animationController,
  });

  @override
  State<AnimatedAppBar> createState() => _AnimatedAppBarState();
}

class _AnimatedAppBarState extends State<AnimatedAppBar> {
  // 해당 부분은 초기화 될 때 적용되므로, duration을 변경하고 hotreload에서 확인하고 싶다면, build에서 호출되도록 하면 된다.
  // getter로 변경하면, 필요할 때마다 해당 값을 호출해서 가져오는 방식이다.
  Duration get duration => 10.ms;
  double scrollPosition = 0;
  // animation이 필요할 때, controller를 사용하기 때문에 controller와 animation이 같이 초기화된다.
  // late Animation animation = ColorTween(begin: Colors.blue, end: Colors.red).animate(controller);
  late CurvedAnimation animation = CurvedAnimation(parent: widget.animationController, curve: Curves.bounceInOut); // Animation<double> 타입과 동일하다.
  // widget 자체가 getter로 되어 있기 때문에, 초기화 될때 animationConrtroller를 받더라도, late 키워드가 필요하다.

  @override
  void initState() {
    // controller.forward(); // forward로 애니메이션을 시작한다.
    // controller.reverse(); // reverse는 반대로 end -> begin으로 실행한다. 중간 지점에서 실행할 수도 있다.
    // controller.repeat(); // 반복해서 실행한다.
    // controller.animateTo(target); // 특정 지점에서 애니메이션을 실행한다.
    // controller.animateBack(target); // 특정 지점에서 반대로 애니메이션을 실행한다.
    
    // addListener를 해 줘야, setState 마다 애니메이션이 실행되면서 animation.value가 변경된다.
    widget.animationController.addListener(() {
      setState(() {});
    });

    widget.scrollController.addListener(() {
      setState(() {
        scrollPosition = widget.scrollController.position.pixels;
      });
    });
    super.initState();
  }

  bool get isTriggered => scrollPosition > 80;
  // bool get isNotTriggered => !isTriggered;

  // 중간 지점에서도 자연스럽게 애니메이션이 되도록 함수를 추가한다.
  double getValue(double initial, double target) {
    if (isTriggered) {
      return target;
    }
    double fraction = scrollPosition / 80;
    return initial + (target - initial) * fraction;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: context.backgroundColor,
      child: SafeArea(
        child: Stack(
          children: [
            // 해당 부분이 애니메이션이 되도록 한다.
            AnimatedContainer(
              duration: duration,
              padding: EdgeInsets.only(
                left: getValue(20, 50),
                top: getValue(50, 15),
              ),
              // 움직이는 text를 표현한다.
              child: AnimatedDefaultTextStyle(
                duration: duration,
                style: TextStyle(
                  fontSize: getValue(30, 18),
                  fontWeight: FontWeight.bold,
                ),
                child: widget.title.text.make(),
              ),
            ),
            Tap(
                onTap: () {
                  Nav.pop(context);
                },
                child: const Arrow(
                  direction: AxisDirection.left,
                )).p20(),
            Positioned(
              // 새상 변경을 위한 TweenAnimationBuilder를 사용한다.
              left: animation.value * 200,
              child: TweenAnimationBuilder<Color?>(
                duration: 1000.ms,
                tween: ColorTween(
                  begin: Colors.green,
                  end: isTriggered ? Colors.orange : Colors.green,
                ),
                // Color를 사용해 계속해서 업데이트 하는 것 보다, ColorFiltered를 사용하는 것이 좋다.
                builder: (context, value, child) => ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    value ?? Colors.green,
                    BlendMode.modulate,
                  ),
                  // child 파라미터는 가장 아래에 두는 것이 좋다.
                  child: child,
                ),
                child: Image.asset(
                  "$basePath/icon/map_point.png",
                  height: 60,
                  // 색상이 들어가지만, 이미지와 겹치지 않고 사각형 박스 형태로 들어가게 된다.
                  // color: Colors.green,
                  // colorBlendMode를 지정해주면, 이미지와 색상이 겹쳐서 나오게 된다.
                  // colorBlendMode: BlendMode.modulate,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Rive와 Lottie로 drawing base animation을 구현할 수 있다.

// Lottie는 Adobe After Effect로 만든 애니메이션을 Bodymovin을 사용해 json으로 변환하여 사용한다.
// 따라서 마우스 동작에 따라 interactive 한다거나, 상태에 따른 동작을 다르게 애니메이션 하는 등의 복잡한 구현은 어렵다.
// AE에 익숙한 디자이너가 러닝커브 없이 다양한 애니메이션을 구현할 수 있고, 이미 구현된 다양한 asset이 많은 것이 장점이다.

// Rive는 다양한 interactive 애니메이션을 구현할 수 있고, 상태에 따른 동작을 다르게 애니메이션 하는 등의 복잡한 구현이 가능하다.
// 또한, Rive의 mac/window 앱 자체가 Flutter로 구현되어 있다. 
// https://www.youtube.com/playlist?list=PLujDTZWVDSsFGonP9kzAnvryowW098-p3 에서 가이드를 확인해 볼 수 있다.