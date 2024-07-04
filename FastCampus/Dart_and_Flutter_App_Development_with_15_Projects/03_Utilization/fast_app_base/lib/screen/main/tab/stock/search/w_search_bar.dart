import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/widget/w_arrow.dart';
import 'package:fast_app_base/common/widget/w_text_field_with_delete.dart';
import 'package:flutter/material.dart';

// AppBar는 PreferredSizeWidget를 구현해야 한다.
class SearchBarWidget extends StatelessWidget implements PreferredSizeWidget {
  // TextEditingController를 상위에서 주입받는다.
  final TextEditingController controller;

  const SearchBarWidget({required this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // statusBar를 고려하여 SafeArea로 감싸준다.
    return SafeArea(
      child: SizedBox(
        height: kToolbarHeight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Tap(
                onTap: () {
                  Nav.pop(context);
                },
                child: const SizedBox(
                  height: 50,
                  width: 50,
                  child: Arrow(
                    direction: AxisDirection.left,
                  ),
                )),
            Expanded(
              child: TextFieldWithDelete(
                // 키보드의 완료 버튼을 검색 버튼으로 변경한다.
                textInputAction: TextInputAction.search,
                controller: controller,
                texthint: "'게임'을 검색해보세요",
                onEditingComplete: () {
                  //print(controller.text);
                  //검색 버튼 눌렀을때 처리 //search
                },
              ).pOnly(top: 5),
            ),
            Tap(
                onTap: () {
                  //search
                },
                child: const Icon(Icons.search).pOnly(right: 15))
          ],
        ),
      ),
    );
  }

  // kToolbarHeights는 Material Design에서 제공하는 AppBar의 높이를 나타내는 상수이다.
  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight);
}
