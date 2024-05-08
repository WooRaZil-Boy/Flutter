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

  @override
  Widget build(BuildContext context) {
    return Container(
      // 테마에 따라 색을 바꾼다.
      height: TtossAppBar.appBarHeight,
      color: context.appColors.appBarBackground,
      child: Row(
        children: [
          width10, // const Width(10), // 이런 식으로 반복되는 코드는 따라 관리하여 사용하는 것이 좋다.
          Image.asset(
            "$basePath/icon/toss.png",
            height: 30,
          ),
          // EmptyExpanded는 최대 넓이의 빈 공간을 만든다.
          emptyExpanded, // EmptyExpanded() // 이런 식으로 반복되는 코드는 따라 관리하여 사용하는 것이 좋다.
          Image.asset(
            "$basePath/icon/map_point.png",
            height: 30,
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
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                    ),
                  ))
              ],
            ),
          ),
          width10,
        ],
      ),
    );
  }
}
