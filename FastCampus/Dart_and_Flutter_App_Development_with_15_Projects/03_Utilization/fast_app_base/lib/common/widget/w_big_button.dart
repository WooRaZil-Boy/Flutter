import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/common/widget/w_arrow.dart';
import 'package:fast_app_base/common/widget/w_rounded_container.dart';
import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  final String text;
  // final void Function() onTap; 과 동일하다.
  final VoidCallback onTap;

  const BigButton(this.text, {super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Tap(
      onTap: onTap,
      child: RoundedContainer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // spaceBetween은 최대한 두 위젯을 떨어뜨린다.
          // magin, padding 등은 해당 widget에서 사용할지, 상위 위젯에서 설정할지 생각을 해 봐야 한다.
          children: [
            text.text.white.size(20).bold.make(), // velocity_x 사용
            const Arrow(),
          ],
        ),
      ),
    );
  }
}
