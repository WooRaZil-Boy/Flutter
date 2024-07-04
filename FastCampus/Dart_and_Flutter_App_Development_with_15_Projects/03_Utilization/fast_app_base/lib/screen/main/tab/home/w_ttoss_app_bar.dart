import 'package:flutter/material.dart';

import '../../../../common/common.dart';
import '../../../notification/s_notification.dart';

class TtossAppBar extends StatefulWidget {
  static const double appBarHeight = 60;

  const TtossAppBar({super.key});

  @override
  State<TtossAppBar> createState() => _TtossAppBarState();
}

class _TtossAppBarState extends State<TtossAppBar> {
  bool _showRedDot = false;
  // inspector를 사용하면, 해당 위젯의 상태와 속성을 확인할 수 있다. 선택하여 해당 위젯의 코드로 이동할 수도 있다.
  int _tappingCount = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      // 테마에 따라 색을 바꾼다.
      height: TtossAppBar.appBarHeight,
      color: context.appColors.appBarBackground,
      child: Row(
        children: [
          width10, // const Width(10), // 이런 식으로 반복되는 코드는 따라 관리하여 사용하는 것이 좋다.
          // 애니메이션을 사용해 아이콘이 나타나고 사라지게 한다.
          // 애니메이션을 위한 가장 필수적인 요소는 duration과 height(시작, 끝)이다.
          // 중간에 어떻게 변화할지는 AnimatedContainer가 알아서 처리한다.
          // setState로 build가 다시 호출되면 자연스럽게 애니메이션이 된다.
          // ImplicitlyAnimatedWidget을 상속하는 위젯들을 사용하여 애니메이션을 쉽게 사용할 수 있다.
          // 한 번 감싸고 child로 추가해야 하기 때문에 번거롭지만, 처음 빌드 시가 아닌 상태 변화에 따른 애니메이션을 구현하는데 용이하다.
          // 빌트인 위젯을 확인할 때는 Android Studio의 Structure 메뉴를 사용하면 편하다.
          AnimatedContainer(
            duration: 1000.ms,
            // curve로 애니메이션의 속도를 조절할 수 있다.
            // 원하는 curve가 없는 경우, cubic을 사용해 베지어 곡선을 만들수 있다.
            curve: Curves.easeIn,
            // color: _tappingCount > 2 ? Colors.red : Colors.blue,
            height: _tappingCount > 2 ? 60: 30,
            child: Image.asset(
              "$basePath/icon/toss.png",
              // Image 위젯은 Container로 감싸져 있다면 내부의 height 값이 적용되지 않는다.
              // height: 30,
            ),
          ),
          // AnimatedCrossFade는 두 개의 위젯을 교체하는 애니메이션을 구현한다.
          AnimatedCrossFade(
            firstChild: Image.asset(
              "$basePath/icon/toss.png",
              height: 30,
            ), 
            secondChild: Image.asset(
              "$basePath/icon/map_point.png",
              height: 30,
            ), 
            crossFadeState: _tappingCount < 2 ? CrossFadeState.showFirst : CrossFadeState.showSecond, 
            duration: 1500.ms,
          ),
          // EmptyExpanded는 최대 넓이의 빈 공간을 만든다.
          emptyExpanded, // EmptyExpanded() // 이런 식으로 반복되는 코드는 따라 관리하여 사용하는 것이 좋다.
          Tap(
            onTap: () {
              setState(() {
                _tappingCount++;
              });
            },
            child: Image.asset(
              "$basePath/icon/map_point.png",
              height: 30,
            ),
          ),
          width10,
          // 공통 widget인 Tap을 사용해 해당 위젯을 눌렀을 때의 동작을 설정한다.
          Tap(
              onTap: () {
                //알림 화면
                Nav.push(const NotificationScreen());
              },
              // 겹쳐서 보여줘야 하는 것은 Stack으로 만든다.
              child: Stack(
                children: [
                  Image.asset(
                    "$basePath/icon/notification.png",
                    height: 30,
                  ),
                  if (_showRedDot)
                    // Positioned로 Stack에서 원하는 위치에 빨간 점을 찍는다.
                    Positioned.fill(
                        child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.red),
                      ),
                    ))
                ],
              )
                  .animate(
                    // onComplete에 repeat을 전달해 반복재생할 수 있다.
                    // onComplete: (controller) => controller.repeat(),
                  )
                  .shake(
                    duration: 2000.ms,
                    hz: 3,
                  ) // hz는 1초에 몇 번 진동하는지를 나타낸다. 종 모양 아이콘이 흔들리며 나타난다.
                  .then() // then은 앞에 있는 애니메이션이 끝나고 실행된다. 빌더 패턴이기에 계속해서 then을 연결해 사용할 수 있다.
                  .fadeOut(duration: 1000.ms)),
          width10,
        ],
      ),
    );
  }
}
